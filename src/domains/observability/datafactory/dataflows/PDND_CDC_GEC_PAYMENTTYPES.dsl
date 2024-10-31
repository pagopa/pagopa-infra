source(output(
          {_rid} as string,
          {_ts} as long,
          id as string,
          name as string,
          createdDate as long[],
          {_etag} as string
     ),
     allowSchemaDrift: true,
     validateSchema: false,
     inferDriftedColumnTypes: true,
     container: 'touchpoints',
     storeType: 'olap',
     format: 'document',
     enableChangeFeed: true,
     changeFeedStartFromTheBeginning: true,
     captureIntermediateUpdate: false,
     captureUserDeletes: true,
     captureTxnTTLDeletes: true,
     store: 'cosmosDB') ~> touchpoints
touchpoints derive(createdDate = iif(isNull(createdDate), '', toString(createdDate[1]) + '-' + lpad(toString(createdDate[2]), 2, '0') + '-' + lpad(toString(createdDate[3]), 2, '0')),
          {_etag} = regexReplace({_etag}, '\\\"', '')) ~> formatDateString
formatDateString select(mapColumn(
          {_rid},
          {_ts},
          id,
          name,
          createdDate,
          {_etag}
     ),
     skipDuplicateMapInputs: true,
     skipDuplicateMapOutputs: true) ~> selectOutputFileds
selectOutputFileds sink(allowSchemaDrift: true,
     validateSchema: false,
     format: 'json',
     container: ${container_name},
     folderPath: 'paymenttypes',
     truncate: true,
     skipDuplicateMapInputs: true,
     skipDuplicateMapOutputs: true) ~> afmgecstorage