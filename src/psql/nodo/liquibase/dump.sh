  #!/bin/bash

  liquibase generate-changelog \
  --url="jdbc:oracle:thin:@//localhost:1555/NDPSPCST" \
  --username=NODO4_CFG \
  --password=NODO4_CFG \
  --classpath="./com.oracle.ojdbc8-12.2.0.1.jar" \
  --default-schema-name=NODO4_CFG \
  --liquibase-schema-name=NODO4_CFG \
  --changelog-file="prf.dump.xml" \
  --diff-types=data
