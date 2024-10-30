source(output(
          {_rid} as string,
          {_ts} as long,
          id as string,
          ciFiscalCode as string,
          idBundle as string,
          type as string,
          attributes as (id as string, maxPaymentAmount as long, transferCategory as string, transferCategoryRelation as string, insertedDate as long[])[],
          validityDateFrom as long[],
          validityDateTo as long[],
          insertedDate as long[],
          {_etag} as string
     ),
     allowSchemaDrift: true,
     validateSchema: false,
     inferDriftedColumnTypes: true,
     container: 'cibundles',
     storeType: 'olap',
     format: 'document',
     enableChangeFeed: true,
     changeFeedStartFromTheBeginning: true,
     systemColumns: true,
     captureIntermediateUpdate: false,
     captureUserDeletes: true,
     captureTxnTTLDeletes: true,
     store: 'cosmosDB') ~> cibundles
flattenAttribute derive(validityDateFrom = iif(isNull(validityDateFrom), '', toString(validityDateFrom[1]) + '-' + lpad(toString(validityDateFrom[2]), 2, '0') + '-' + lpad(toString(validityDateFrom[3]), 2, '0')),
          validityDateTo = iif(isNull(validityDateTo), '', toString(validityDateTo[1]) + '-' + lpad(toString(validityDateTo[2]), 2, '0') + '-' + lpad(toString(validityDateTo[3]), 2, '0')),
          insertedDate = iif(isNull(insertedDate), '', toString(insertedDate[1]) + '-' + lpad(toString(insertedDate[2]), 2, '0') + '-' + lpad(toString(insertedDate[3]), 2, '0') + 'T' + lpad(toString(insertedDate[4]), 2, '0') + ':' + lpad(toString(insertedDate[5]), 2, '0') + ':' + lpad(toString(insertedDate[6]), 2, '0') + '.' + toString(insertedDate[7])),
          {_etag} = regexReplace({_etag}, '\\\"', ''),
          attributes = @(id=attributes.id,
          maxPaymentAmount=attributes.maxPaymentAmount,
          transferCategory=attributes.transferCategory,
          transferCategoryRelation=attributes.transferCategoryRelation,
          insertedDate=iif(isNull(attributes.insertedDate), 
                              '', 
                              toString(attributes.insertedDate[1]) + '-' + 
                              lpad(toString(attributes.insertedDate[2]), 2, '0') + '-' + 
                              lpad(toString(attributes.insertedDate[3]), 2, '0') + 'T' + 
                              lpad(toString(attributes.insertedDate[4]), 2, '0') + ':' + 
                              lpad(toString(attributes.insertedDate[5]), 2, '0') + ':' + 
                              lpad(toString(attributes.insertedDate[6]), 2, '0') + '.' + 
                              toString(attributes.insertedDate[7])))) ~> formatDate
aggregateAttribute select(mapColumn(
          {_rid},
          {_ts},
          ciFiscalCode,
          idBundle,
          type,
          attributes,
          validityDateFrom,
          insertedDate,
          id,
          {_etag}
     ),
     skipDuplicateMapInputs: true,
     skipDuplicateMapOutputs: true) ~> selctOutputFields
cibundles foldDown(unroll(attributes, attributes),
     mapColumn(
          {_rid},
          {_ts},
          ciFiscalCode,
          idBundle,
          type,
          attributes,
          validityDateFrom,
          validityDateTo,
          insertedDate,
          id,
          {_etag}
     ),
     skipDuplicateMapInputs: false,
     skipDuplicateMapOutputs: false) ~> flattenAttribute
formatDate aggregate(groupBy({_rid},
          {_ts},
          ciFiscalCode,
          idBundle,
          type,
          validityDateFrom,
          validityDateTo,
          insertedDate,
          id,
          {_etag}),
     attributes = collect(attributes)) ~> aggregateAttribute
selctOutputFields sink(allowSchemaDrift: true,
     validateSchema: false,
     format: 'json',
     container: ${container_name},
     folderPath: 'cibundles',
     skipDuplicateMapInputs: true,
     skipDuplicateMapOutputs: true) ~> afmgecstorage