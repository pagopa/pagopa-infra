  #!/bin/bash

  liquibase \
  --url="jdbc:oracle:thin:@//10.250.32.152:1524/NDPSPCST_SERVICE" \
  --username=NODO4_CFG \
  --password=NODO4_CFG \
  --classpath="./libs/com.oracle.ojdbc8-12.2.0.1.jar" \
  --default-schema-name=NODO4_CFG \
  --liquibase-schema-name=NODO4_CFG \
  --changelog-file="prf.dump.xml" \
  generate-changelog \
  --diff-types=data