parameters{
  daysToKeep as integer (90)
}
source(output(
          id as long,
          data_ora_evento as string,
          identificativo_dominio as string,
          identificativo_univoco_versamento as string,
          codice_contesto_pagamento as string,
          identificativo_prestatore_servizi_pagamento as string,
          tipo_versamento as string,
          componente as string,
          categoria_evento as string,
          tipo_evento as string,
          sotto_tipo_evento as string,
          identificativo_fruitore as string,
          identificativo_erogatore as string,
          identificativo_stazione_intermediario_pa as string,
          canale_pagamento as string,
          parametri_specifici_interfaccia as string,
          esito as string,
          id_sessione as string,
          status as string,
          payload as binary,
          info as string,
          inserted_timestamp as timestamp,
          business_process as string,
          fruitore_descr as string,
          erogatore_descr as string,
          psp_descr as string,
          notice_id as string,
          creditor_reference_id as string,
          payment_token as string,
          id_sessione_originale as string,
          id_eventhub as string
     ),
     allowSchemaDrift: false,
     validateSchema: false,
     isolationLevel: 'READ_UNCOMMITTED',
     query: ("SELECT * FROM re.re WHERE inserted_timestamp < (NOW()::date - '{$daysToKeep} DAY'::interval)"),
     format: 'query') ~> reRead
reRead alterRow(deleteIf(toDate(toString(inserted_timestamp,'dd-MM-yyyy','it-IT'),'dd-MM-yyyy','it-IT')<currentDate())) ~> markRecordReToDelete
markRecordReToDelete sink(allowSchemaDrift: false,
     validateSchema: false,
     input(
          id as decimal(0,0),
          data_ora_evento as string,
          identificativo_dominio as string,
          identificativo_univoco_versamento as string,
          codice_contesto_pagamento as string,
          identificativo_prestatore_servizi_pagamento as string,
          tipo_versamento as string,
          componente as string,
          categoria_evento as string,
          tipo_evento as string,
          sotto_tipo_evento as string,
          identificativo_fruitore as string,
          identificativo_erogatore as string,
          identificativo_stazione_intermediario_pa as string,
          canale_pagamento as string,
          parametri_specifici_interfaccia as string,
          esito as string,
          id_sessione as string,
          status as string,
          payload as binary,
          info as string,
          inserted_timestamp as timestamp,
          business_process as string,
          fruitore_descr as string,
          erogatore_descr as string,
          psp_descr as string,
          notice_id as string,
          creditor_reference_id as string,
          payment_token as string,
          id_sessione_originale as string,
          id_eventhub as string
     ),
     deletable:true,
     insertable:false,
     updateable:false,
     upsertable:false,
     keys:['id'],
     format: 'table',
     skipDuplicateMapInputs: true,
     skipDuplicateMapOutputs: true,
     saveOrder: 1) ~> executeReDeleteDB