# ============================================================
# DATA SOURCE: Risorse Redis per dominio
# ============================================================
# Per ogni dominio definito in local.alerting_domains, recupera
# tutte le risorse Azure di tipo Redis che hanno il tag
# "domain" corrispondente. Questo permette di scoprire
# dinamicamente le istanze Redis senza doverle elencare manualmente.
data "azurerm_resources" "alerting_redis_resources" {
  for_each = toset(local.alerting_domains)
  type     = local.azure_redis_resource_type  # es. "Microsoft.Cache/redis"

  required_tags = {
    domain = each.key  # filtra solo le risorse taggate con il dominio corrente
  }
}

locals {

  # ============================================================
  # custom_action_group_map
  # ============================================================
  # Converte la lista di oggetti `local.global_custom_action_group`
  # (strutturata come [{key, action_groups}]) in una map indicizzata
  # per chiave, per permettere lookup efficienti.
  #
  # La chiave "default" viene usata come fallback quando non esiste
  # una configurazione specifica per una risorsa o metrica.
  #
  # Esempio di risultato:
  # {
  #   "default"                              => [{action_group_name = "PagoPA"}, ...]
  #   "pagopa-d-redis-active_connections"    => [{action_group_name = "SlackPagoPANODO"}, ...]
  # }
  custom_action_group_map = {
    for item in local.global_custom_action_group :
    (item.key == "default" ? item.key : "${item.key}") => item.action_groups
  }

  # ============================================================
  # redis_id_map
  # ============================================================
  # Appiattisce (flatten) la struttura annidata restituita dal
  # data source `alerting_redis_resources`, che raggruppa le risorse
  # per dominio, producendo una lista piatta di oggetti con le
  # informazioni essenziali di ogni istanza Redis:
  # - redis_name: nome della risorsa
  # - redis_rg:   resource group di appartenenza
  # - redis_id:   ID ARM completo (usato come scope dell'alert)
  redis_id_map = flatten([
    for rp in data.azurerm_resources.alerting_redis_resources : [
      for r in rp.resources : {
        redis_name = r.name
        redis_rg   = r.resource_group_name
        redis_id   = r.id
      }
    ]
  ])

  # ============================================================
  # redis_resource_metric_map
  # ============================================================
  # Cross join tra tutte le istanze Redis (redis_id_map) e tutte
  # le metriche configurate (var.redis_metric_alerts).
  # Produce una lista di oggetti, uno per ogni combinazione
  # (istanza Redis × metrica), che rappresenta un singolo alert
  # da creare.
  #
  # Per ogni combinazione viene anche risolto l'action group da
  # associare, con la seguente logica di priorità (dal più
  # specifico al più generico):
  #   1. Chiave "{redis_name}-{metric_name}" → override per specifica
  #      istanza E specifica metrica
  #   2. Chiave "{redis_name}"               → override per specifica
  #      istanza su tutte le metriche
  #   3. Chiave "default"                    → fallback globale
  redis_resource_metric_map = flatten([
    for rp in local.redis_id_map : [
      for m in var.redis_metric_alerts : {
        redis_name       = rp.redis_name
        redis_rg         = rp.redis_rg
        redis_id         = rp.redis_id
        metric_name      = m.metric_name
        metric_namespace = m.metric_namespace
        aggregation      = m.aggregation
        operator         = m.operator
        threshold        = m.threshold
        frequency        = m.frequency
        window_size      = m.window_size
        severity         = m.severity

        # Risoluzione action group con fallback a cascata tramite try():
        # try() restituisce il primo valore non nullo / non in errore
        action_group = try(
          local.custom_action_group_map["${rp.redis_name}-${m.metric_name}"], # livello 1: istanza + metrica
          try(
            local.custom_action_group_map[rp.redis_name],                     # livello 2: istanza
            local.custom_action_group_map["default"]                          # livello 3: default
          )
        )
      }
    ]
  ])

  # ============================================================
  # redis_action_group_map
  # ============================================================
  # Appiattisce il campo `action_group` (che è una lista) presente
  # in ogni elemento di redis_resource_metric_map, producendo una
  # lista piatta in cui ogni elemento rappresenta la coppia
  # (alert, action group).
  # Questa struttura è necessaria perché un alert può avere più
  # action group associati e il data source di lookup richiede
  # un oggetto per ciascuno.
  redis_action_group_map = flatten([
    for rp in local.redis_resource_metric_map : [
      for ag in rp.action_group : {
        redis_name                       = rp.redis_name
        metric_name                      = rp.metric_name
        action_group_name                = ag.action_group_name
        action_group_name_resource_group = ag.resource_group_name
      }
    ]
  ])
}

# ============================================================
# DATA SOURCE: Dettagli degli Action Group
# ============================================================
# Recupera i dettagli (incluso l'ID ARM) di ogni action group
# referenziato negli alert. La chiave della map è composta da
# "{redis_name}-{metric_name}-{action_group_name}" per garantire
# unicità anche quando lo stesso action group appare su più alert.
data "azurerm_monitor_action_group" "all_action_groups" {
  for_each = {
    for idx, val in local.redis_action_group_map :
    "${val.redis_name}-${val.metric_name}-${val.action_group_name}" => val
  }

  resource_group_name = each.value.action_group_name_resource_group
  name                = each.value.action_group_name
}

# Output temporaneo per debug: mostra tutti gli action group risolti.
# Da rimuovere prima di andare in produzione.
output "test" {
  value = data.azurerm_monitor_action_group.all_action_groups
}

# ============================================================
# RESOURCE: Metric Alert per ogni istanza Redis × metrica
# ============================================================
# Crea un azurerm_monitor_metric_alert per ogni elemento del
# redis_resource_metric_map. La chiave della map è
# "{redis_name}-{metric_name}", che garantisce un alert univoco
# per combinazione istanza/metrica.
resource "azurerm_monitor_metric_alert" "redis_alerts" {
  for_each = {
    for idx, val in local.redis_resource_metric_map :
    "${val.redis_name}-${val.metric_name}" => val
  }

  enabled             = var.redis_alerts_enabled
  name                = "${each.value.redis_name}-${upper(each.key)}" # nome in uppercase per leggibilità
  resource_group_name = each.value.redis_rg
  scopes              = [each.value.redis_id]  # scope = ID ARM dell'istanza Redis
  frequency           = each.value.frequency   # frequenza di valutazione (es. PT1M)
  window_size         = each.value.window_size # finestra temporale di aggregazione (es. PT5M)
  severity            = each.value.severity    # 0=Critical, 1=Error, 2=Warning, 3=Informational

  # Collega dinamicamente tutti gli action group risolti per questo alert.
  # Nota: al momento itera su ALL_action_groups globalmente — vedere nota sotto.
  dynamic "action" {
    for_each = data.azurerm_monitor_action_group.all_action_groups
    content {
      action_group_id    = action.value["id"]  # ID ARM dell'action group
      webhook_properties = null                # nessuna proprietà webhook aggiuntiva
    }
  }

  # Definisce la condizione che scatena l'alert
  criteria {
    aggregation      = each.value.aggregation      # es. Average, Maximum, Total
    metric_namespace = each.value.metric_namespace # es. Microsoft.Cache/redis
    metric_name      = each.value.metric_name      # es. ConnectedClients
    operator         = each.value.operator         # es. GreaterThan
    threshold        = each.value.threshold        # valore soglia numerico
  }

  tags = var.tags
}