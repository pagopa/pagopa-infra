openapi: 3.0.3
info:
  title: pagopa-selfcare-ms-backoffice
  description: PagoPa backoffice API documentation
  version: 0.0.127
servers:
  - url: 'https://${host}/${basePath}'
    description: Inferred Url
tags:
  - name: channels
    description: Api config channels operations
  - name: creditor-institutions
    description: Api Config creditor institution's operations
  - name: institution
    description: Institution operations
  - name: stations
    description: Api config stations operations
paths:
  /channels:
    get:
      tags:
        - channels
      summary: getChannels
      description: Get paginated list of channels
      operationId: getChannelsUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: code
          in: query
          description: Filter chennel by code
          required: false
          style: form
          schema:
            type: string
        - name: ordering
          in: query
          description: Sort Direction ordering
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    post:
      tags:
        - channels
      summary: createChannel
      description: Create a channel
      operationId: createChannelUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ChannelDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperChannelDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/brokerspsp:
    post:
      tags:
        - channels
      summary: createBrokerPsp
      description: Create a PSP broker
      operationId: createBrokerPspUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/BrokerPspDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BrokerPspDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/configuration/paymenttypes:
    get:
      tags:
        - channels
      summary: getPaymentTypes
      description: Get list of payment type
      operationId: getPaymentTypesUsingGET
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/create-wrapperChannel:
    post:
      tags:
        - channels
      summary: createWrapperChannelDetails
      description: Create a WrapperChannel on Cosmodb
      operationId: createWrapperChannelDetailsUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/WrapperChannelDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/csv:
    get:
      tags:
        - channels
      summary: getChannelsCSV
      description: Download the list of channelss as CSV file
      operationId: getChannelsCSVUsingGET
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Resource'
            text/plain:
              schema:
                $ref: '#/components/schemas/Resource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/details/{channelcode}:
    get:
      tags:
        - channels
      summary: getChannelDetails
      operationId: getChannelDetailsUsingGET
      parameters:
        - name: channelcode
          in: path
          description: Code of the payment channel
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/get-details/{channelcode}:
    get:
      tags:
        - channels
      summary: getChannelDetail
      operationId: getChannelDetailUsingGET
      parameters:
        - name: channelcode
          in: path
          description: Code of the payment channel
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/get-wrapper/{wrapperType}/{wrapperStatus}:
    get:
      tags:
        - channels
      summary: getWrapperByTypeAndStatus
      description: Get Wrapper Channel Details from cosmos db
      operationId: getWrapperByTypeAndStatusUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: wrapperType
          in: path
          description: Type of Wrapper like CHANNEL or STATION
          required: true
          style: simple
          schema:
            type: string
            enum:
              - CHANNEL
              - STATION
        - name: wrapperStatus
          in: path
          description: 'Validation Status of a CHANNEL or STATION  '
          required: true
          style: simple
          schema:
            type: string
            enum:
              - APPROVED
              - TO_CHECK
              - TO_CHECK_UPDATE
              - TO_FIX
        - name: brokerCode
          in: query
          description: Broker code filter for search
          required: false
          style: form
          schema:
            type: string
        - name: idLike
          in: query
          description: Query with sql like parameter for field id search
          required: false
          style: form
          schema:
            type: string
        - name: sorting
          in: query
          description: Method of sorting
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesList'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/get-wrapperEntities/{code}:
    get:
      tags:
        - channels
      summary: getWrapperEntities
      description: Get wrapperEntities
      operationId: getWrapperEntitiesUsingGET
      parameters:
        - name: code
          in: path
          description: Channlecode or StationCode
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/getAllChannels:
    get:
      tags:
        - channels
      summary: getAllChannelsMerged
      description: Get All Channels from cosmos db merged whit apiConfig
      operationId: getAllChannelsMergedUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: channelcode
          in: query
          description: Channel code
          required: false
          style: form
          schema:
            type: string
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: sorting
          in: query
          description: Method of sorting
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperChannelsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/paymenttypes/{channelcode}:
    get:
      tags:
        - channels
      summary: getChannelPaymentTypes
      description: Get list of payment type of a channel
      operationId: getChannelPaymentTypesUsingGET
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelPaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/psp:
    post:
      tags:
        - channels
      summary: createPaymentServiceProvider
      description: Create a payment service provider
      operationId: createPaymentServiceProviderUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PaymentServiceProviderDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaymentServiceProviderDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/psp/{channelcode}/{pspcode}:
    put:
      tags:
        - channels
      summary: updatePaymentServiceProvidersChannels
      description: Update a relation between a PSP and a channel
      operationId: updatePaymentServiceProvidersChannelsUsingPUT
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PspChannelPaymentTypes'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelPaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    delete:
      tags:
        - channels
      summary: deletePaymentServiceProvidersChannels
      description: Delete a relation between a PSP and a channel
      operationId: deletePaymentServiceProvidersChannelsUsingDELETE
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/psp/{pspcode}:
    get:
      tags:
        - channels
      summary: getPSPDetails
      description: Get payment service provider's details
      operationId: getPSPDetailsUsingGET
      parameters:
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaymentServiceProviderDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/pspdirect:
    post:
      tags:
        - channels
      summary: createPSPDirect
      description: Create a payment service provider
      operationId: createPSPDirectUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PaymentServiceProviderDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaymentServiceProviderDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/update-wrapperChannel:
    put:
      tags:
        - channels
      summary: updateWrapperChannelDetails
      description: Put a new WrapperChannel entity inside a list of the WrapperEntities object on Cosmodb
      operationId: updateWrapperChannelDetailsUsingPUT
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ChannelDetailsDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/update-wrapperChannelByOpt:
    put:
      tags:
        - channels
      summary: updateWrapperChannelDetailsByOpt
      description: Update a WrapperChannel on Cosmodb
      operationId: updateWrapperChannelDetailsByOptUsingPUT
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ChannelDetailsDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/wfespplugins:
    get:
      tags:
        - channels
      summary: getWfespPlugins
      description: Update a WrapperChannel on Cosmodb
      operationId: getWfespPluginsUsingGET
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WfespPluginConfs'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/{brokerpspcode}/paymentserviceproviders:
    get:
      tags:
        - channels
      summary: getPspBrokerPsp
      description: Get the PSP list of a broker
      operationId: getPspBrokerPspUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: brokerpspcode
          in: path
          description: Broker code of a PSP
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaymentServiceProvidersResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/{channelcode}:
    put:
      tags:
        - channels
      summary: updateChannel
      description: Create a channel
      operationId: updateChannelUsingPUT
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ChannelDetailsDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    delete:
      tags:
        - channels
      summary: deleteChannel
      description: delete channel
      operationId: deleteChannelUsingDELETE
      parameters:
        - name: channelcode
          in: path
          description: Code of the payment channel
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/{channelcode}/paymenttypes:
    post:
      tags:
        - channels
      summary: createChannelPaymentType
      description: Create a payment types of a channel
      operationId: createChannelPaymentTypeUsingPOST
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PspChannelPaymentTypes'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelPaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/{channelcode}/psp:
    get:
      tags:
        - channels
      summary: getChannelPaymentServiceProviders
      description: Get paginated list of PSPs associated with the channel
      operationId: getChannelPaymentServiceProvidersUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: channelcode
          in: path
          description: Code of the payment channel
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelPspListResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/{channelcode}/{paymenttypecode}:
    delete:
      tags:
        - channels
      summary: deleteChannelPaymentType
      description: delete payment type of a channel
      operationId: deleteChannelPaymentTypeUsingDELETE
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: paymenttypecode
          in: path
          description: Code of the payment type
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/{pspcode}:
    get:
      tags:
        - channels
      summary: getPspChannels
      operationId: getPspChannelsUsingGET
      parameters:
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /channels/{pspcode}/generate:
    get:
      tags:
        - channels
      summary: getChannelCode
      description: Generate new channel Code
      operationId: getChannelCodeUsingGET
      parameters:
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelCodeResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /creditor-institutions:
    post:
      tags:
        - creditor-institutions
      summary: createCreditorInstitution
      description: Service to add a Creditor Institution to Api Config
      operationId: createCreditorInstitutionUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreditorInstitutionDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CreditorInstitutionDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /creditor-institutions/{ecCode}:
    get:
      tags:
        - creditor-institutions
      summary: getCreditorInstitutionDetails
      description: Service to retrieve specific creditor institution details
      operationId: getCreditorInstitutionDetailsUsingGET
      parameters:
        - name: ecCode
          in: path
          description: Creditor institution code
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CreditorInstitutionDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    put:
      tags:
        - creditor-institutions
      summary: updateCreditorInstitutionDetails
      description: Service to update specific creditor institution details
      operationId: updateCreditorInstitutionDetailsUsingPUT
      parameters:
        - name: ecCode
          in: path
          description: Creditor institution code
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateCreditorInstitutionDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CreditorInstitutionDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations:
    get:
      tags:
        - stations
      summary: getStations
      description: Get paginated list of stations
      operationId: getStationsUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: stationCode
          in: query
          description: Station's unique identifier
          required: false
          style: form
          schema:
            type: string
        - name: creditorInstitutionCode
          in: query
          description: Creditor institution associated to given station
          required: false
          style: form
          schema:
            type: string
        - name: ordering
          in: query
          description: Sort Direction ordering
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/StationsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    post:
      tags:
        - stations
      summary: createStation
      description: Create new station
      operationId: createStationUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/StationDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntityOperationsOfStationDetails'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/create-broker:
    post:
      tags:
        - stations
      summary: createBroker
      description: Create a Broker
      operationId: createBrokerUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/BrokerDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BrokerResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/create-wrapperStation:
    post:
      tags:
        - stations
      summary: createWrapperStationDetails
      description: Create a WrapperChannel on Cosmodb
      operationId: createWrapperStationDetailsUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/WrapperStationDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperationsOfStationDetails'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/details/{stationId}:
    get:
      tags:
        - stations
      summary: getStation
      description: Get station's details
      operationId: getStationUsingGET
      parameters:
        - name: stationId
          in: path
          description: Station's unique identifier
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/StationDetailResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/get-details/{stationId}:
    get:
      tags:
        - stations
      summary: getStationDetail
      description: Get station's details
      operationId: getStationDetailUsingGET
      parameters:
        - name: stationId
          in: path
          description: Station's unique identifier
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/StationDetailResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/get-wrapperEntities/{code}:
    get:
      tags:
        - stations
      summary: getWrapperEntitiesStation
      description: Get wrapper station from mongo DB
      operationId: getWrapperEntitiesStationUsingGET
      parameters:
        - name: code
          in: path
          description: Channlecode or StationCode
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/getAllStations:
    get:
      tags:
        - stations
      summary: getAllStationsMerged
      description: Get All Stations from cosmos db merged whit apiConfig
      operationId: getAllStationsMergedUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: stationcode
          in: query
          description: Station's unique identifier
          required: false
          style: form
          schema:
            type: string
        - name: brokerCode
          in: query
          description: Broker code filter for search
          required: true
          style: form
          schema:
            type: string
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: sorting
          in: query
          description: Method of sorting
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperStationsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/getCreditorInstitutions/{stationcode}:
    get:
      tags:
        - stations
      summary: getCreditorInstitutionsByStationCode
      description: Get wrapper station from mongo DB
      operationId: getCreditorInstitutionsByStationCodeUsingGET
      parameters:
        - name: stationcode
          in: path
          description: Channlecode or StationCode
          required: true
          style: simple
          schema:
            type: string
        - name: limit
          in: query
          description: limit
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: page
          required: true
          style: form
          schema:
            type: integer
            format: int32
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CreditorInstitutionsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/update-wrapperStation:
    put:
      tags:
        - stations
      summary: updateWrapperStationDetails
      description: Update WrapperStationDetails
      operationId: updateWrapperStationDetailsUsingPUT
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/StationDetailsDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/update-wrapperStationByOpt:
    put:
      tags:
        - stations
      summary: updateWrapperStationDetailsByOpt
      description: Update a WrapperStation on Cosmodb
      operationId: updateWrapperStationDetailsByOptUsingPUT
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/StationDetailsDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WrapperEntitiesOperations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/{brokerId}:
    get:
      tags:
        - stations
      summary: getStationsDetailsListByBroker
      description: Get paginated list of stations given brokerid code
      operationId: getStationsDetailsListByBrokerUsingGET
      parameters:
        - name: brokerId
          in: path
          description: brokerId
          required: true
          style: simple
          schema:
            type: string
        - name: stationId
          in: query
          description: stationId
          required: false
          style: form
          schema:
            type: string
        - name: limit
          in: query
          description: limit
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: page
          required: false
          style: form
          schema:
            type: integer
            format: int32
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/StationDetailsResourceList'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/{ecCode}/generate:
    get:
      tags:
        - stations
      summary: getStationCode
      description: Generate a station code given the creditor institution's code
      operationId: getStationCodeUsingGET
      parameters:
        - name: ecCode
          in: path
          description: Creditor institution code
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/StationCodeResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/{ecCode}/station:
    post:
      tags:
        - stations
      summary: associateStationToCreditorInstitution
      description: Creates the relationship between the created station and the creditorInstitution
      operationId: associateStationToCreditorInstitutionUsingPOST
      parameters:
        - name: ecCode
          in: path
          description: Creditor institution code
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreditorInstitutionStationDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CreditorInstitutionStationEditResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/{ecCode}/station/{stationcode}:
    delete:
      tags:
        - stations
      summary: deleteCreditorInstitutionStationRelationship
      description: delete the relationship between the created station and the creditorInstitution
      operationId: deleteCreditorInstitutionStationRelationshipUsingDELETE
      parameters:
        - name: ecCode
          in: path
          description: Creditor institution code
          required: true
          style: simple
          schema:
            type: string
        - name: stationcode
          in: path
          description: Channlecode or StationCode
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  /stations/{stationcode}:
    put:
      tags:
        - stations
      summary: updateStation
      description: Update a station
      operationId: updateStationUsingPUT
      parameters:
        - name: stationcode
          in: path
          description: Station's unique identifier
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/StationDetailsDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/StationDetailResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
components:
  schemas:
    BrokerDetails:
      title: BrokerDetails
      type: object
      properties:
        broker_code:
          type: string
        broker_details:
          type: string
        description:
          type: string
        enabled:
          type: boolean
        extended_fault_bean:
          type: boolean
    BrokerDetailsResource:
      title: BrokerDetailsResource
      type: object
      properties:
        broker_code:
          type: string
        broker_details:
          type: string
        enabled:
          type: boolean
        extended_fault_bean:
          type: boolean
    BrokerDto:
      title: BrokerDto
      type: object
      properties:
        broker_code:
          type: string
        description:
          type: string
    BrokerPspDetailsDto:
      title: BrokerPspDetailsDto
      type: object
      properties:
        broker_psp_code:
          type: string
        description:
          type: string
        enabled:
          type: boolean
        extended_fault_bean:
          type: boolean
    BrokerPspDetailsResource:
      title: BrokerPspDetailsResource
      type: object
      properties:
        broker_psp_code:
          type: string
        description:
          type: string
        enabled:
          type: boolean
        extended_fault_bean:
          type: boolean
    BrokerResource:
      title: BrokerResource
      type: object
      properties:
        broker_code:
          type: string
        description:
          type: string
        enabled:
          type: boolean
        extended_fault_bean:
          type: boolean
    ChannelCodeResource:
      title: ChannelCodeResource
      type: object
      properties:
        channel_code:
          type: string
          description: Channel code
    ChannelDetailsDto:
      title: ChannelDetailsDto
      type: object
      properties:
        agid:
          type: boolean
          description: agid
          example: false
        broker_description:
          type: string
          description: Broker description. Read only field
        broker_psp_code:
          type: string
          description: 'psp code '
        card_chart:
          type: boolean
          description: card chart
          example: false
        channel_code:
          type: string
          description: Channel code
        digital_stamp_brand:
          type: boolean
          description: digital stamp brand
          example: false
        enabled:
          type: boolean
        flag_io:
          type: boolean
          description: flag io
          example: false
        ip:
          type: string
          description: channel's ip
        new_fault_code:
          type: boolean
          description: new fault code
          example: false
        new_password:
          type: string
          description: channel's new password
        nmp_service:
          type: string
          description: nmp service
        note:
          type: string
          description: channel note description by operation team
        on_us:
          type: boolean
          description: on us
          example: false
        password:
          type: string
          description: channel's password
        payment_model:
          type: string
          description: payment model
          enum:
            - ACTIVATED_AT_PSP
            - DEFERRED
            - IMMEDIATE
            - IMMEDIATE_MULTIBENEFICIARY
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
        port:
          type: integer
          description: channel's port
          format: int64
        primitive_version:
          type: string
          description: primitive version
        protocol:
          type: string
          description: channel's protocol
          enum:
            - HTTP
            - HTTPS
        proxy_enabled:
          type: boolean
          description: proxy Enabled
          example: false
        proxy_host:
          type: string
          description: proxy Host
        proxy_password:
          type: string
          description: proxy Password
        proxy_port:
          type: integer
          description: proxy Port
          format: int64
        proxy_username:
          type: string
          description: proxy Username
        recovery:
          type: boolean
          description: recovery
          example: false
        redirect_ip:
          type: string
          description: redirect ip
        redirect_path:
          type: string
          description: redirect path
        redirect_port:
          type: integer
          description: redirect port
          format: int64
        redirect_protocol:
          type: string
          description: redirect protocol
          enum:
            - HTTP
            - HTTPS
        redirect_query_string:
          type: string
          description: redirect query string
        rt_push:
          type: boolean
          description: rt Push
          example: false
        serv_plugin:
          type: string
          description: service plugin
        service:
          type: string
          description: channel's service
        status:
          type: string
          description: channel's validation status
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        target_host:
          type: string
          description: target host
        target_path:
          type: string
          description: target path's
        target_port:
          type: integer
          description: target port
          format: int64
        thread_number:
          type: integer
          description: thread number
          format: int64
        timeout_a:
          type: integer
          description: timeout A
          format: int64
        timeout_b:
          type: integer
          description: timeout B
          format: int64
        timeout_c:
          type: integer
          description: timeout C
          format: int64
    ChannelDetailsResource:
      title: ChannelDetailsResource
      type: object
      properties:
        agid:
          type: boolean
          description: agid
          example: false
        broker_description:
          type: string
          description: Broker description. Read only field
        broker_psp_code:
          type: string
          description: 'psp code '
        card_chart:
          type: boolean
          description: card chart
          example: false
        channel_code:
          type: string
          description: Channel code
        digital_stamp_brand:
          type: boolean
          description: digital stamp brand
          example: false
        enabled:
          type: boolean
        flag_io:
          type: boolean
          description: flag io
          example: false
        ip:
          type: string
          description: channel's ip
        new_fault_code:
          type: boolean
          description: new fault code
          example: false
        new_password:
          type: string
          description: channel's new password
        nmp_service:
          type: string
          description: nmp service
        on_us:
          type: boolean
          description: on us
          example: false
        password:
          type: string
          description: channel's password
        payment_model:
          type: string
          description: payment model
          enum:
            - ACTIVATED_AT_PSP
            - DEFERRED
            - IMMEDIATE
            - IMMEDIATE_MULTIBENEFICIARY
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
        port:
          type: integer
          description: channel's port
          format: int64
        primitive_version:
          type: string
          description: primitive version
        protocol:
          type: string
          description: channel's protocol
          enum:
            - HTTP
            - HTTPS
        proxy_enabled:
          type: boolean
          description: proxy Enabled
          example: false
        proxy_host:
          type: string
          description: proxy Host
        proxy_password:
          type: string
          description: proxy Password
        proxy_port:
          type: integer
          description: proxy Port
          format: int64
        proxy_username:
          type: string
          description: proxy Username
        recovery:
          type: boolean
          description: recovery
          example: false
        redirect_ip:
          type: string
          description: redirect ip
        redirect_path:
          type: string
          description: redirect path
        redirect_port:
          type: integer
          description: redirect port
          format: int64
        redirect_protocol:
          type: string
          description: redirect protocol
          enum:
            - HTTP
            - HTTPS
        redirect_query_string:
          type: string
          description: redirect query string
        rt_push:
          type: boolean
          description: rt Push
          example: false
        serv_plugin:
          type: string
          description: service plugin
        service:
          type: string
          description: channel's service
        target_host:
          type: string
          description: target host
        target_host_nmp:
          type: string
          description: target host NMP
        target_path:
          type: string
          description: target path's
        target_path_nmp:
          type: string
          description: target path NMP
        target_port:
          type: integer
          description: target port
          format: int64
        target_port_nmp:
          type: string
          description: target port NMP
        thread_number:
          type: integer
          description: thread number
          format: int64
        timeout_a:
          type: integer
          description: timeout A
          format: int64
        timeout_b:
          type: integer
          description: timeout B
          format: int64
        timeout_c:
          type: integer
          description: timeout C
          format: int64
    ChannelPspListResource:
      title: ChannelPspListResource
      type: object
      properties:
        page_info:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
        payment_service_providers:
          type: array
          description: enabled
          items:
            $ref: '#/components/schemas/ChannelPspResource'
    ChannelPspResource:
      title: ChannelPspResource
      type: object
      properties:
        business_name:
          type: string
          description: business name of the payment service provider
        enabled:
          type: boolean
          description: enabled
          example: false
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
        psp_code:
          type: string
          description: Code of the payment service provider
    ChannelResource:
      title: ChannelResource
      type: object
      properties:
        broker_description:
          type: string
          description: Broker description. Read only field
        channel_code:
          type: string
          description: Channel code
        enabled:
          type: boolean
    ChannelsResource:
      title: ChannelsResource
      required:
        - channels
        - page_info
      type: object
      properties:
        channels:
          type: array
          description: list of psp and ec channels
          items:
            $ref: '#/components/schemas/ChannelResource'
        page_info:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
    CreditorInstitutionAddressDto:
      title: CreditorInstitutionAddressDto
      required:
        - city
        - countryCode
        - location
        - taxDomicile
        - zipCode
      type: object
      properties:
        city:
          type: string
          description: Creditor Institution's city
        countryCode:
          type: string
          description: Creditor Institution's country code
        location:
          type: string
          description: Creditor Institution's physical address
        taxDomicile:
          type: string
          description: Creditor Institution's tax domicile
        zipCode:
          type: string
          description: Creditor Institution's zip code
    CreditorInstitutionAddressResource:
      title: CreditorInstitutionAddressResource
      required:
        - city
        - countryCode
        - location
        - taxDomicile
        - zipCode
      type: object
      properties:
        city:
          type: string
          description: Creditor Institution's city
        countryCode:
          type: string
          description: Creditor Institution's country code
        location:
          type: string
          description: Creditor Institution's physical address
        taxDomicile:
          type: string
          description: Creditor Institution's tax domicile
        zipCode:
          type: string
          description: Creditor Institution's zip code
    CreditorInstitutionDetailsResource:
      title: CreditorInstitutionDetailsResource
      required:
        - address
        - businessName
        - creditorInstitutionCode
        - enabled
        - pspPayment
        - reportingFtp
        - reportingZip
      type: object
      properties:
        address:
          description: Creditor Institution's address object
          $ref: '#/components/schemas/CreditorInstitutionAddressResource'
        businessName:
          type: string
          description: Creditor Institution's business name
        creditorInstitutionCode:
          type: string
          description: Creditor Institution's code(Fiscal Code)
        enabled:
          type: boolean
          description: Creditor Institution activation state on ApiConfig
          example: false
        pspPayment:
          type: boolean
          description: Enables the zipping of the content that goes through fstp
          example: false
        reportingFtp:
          type: boolean
          description: Enables the zipping of the content that goes through fstp
          example: false
        reportingZip:
          type: boolean
          description: Enables the zipping of the content that goes through fstp
          example: false
    CreditorInstitutionDto:
      title: CreditorInstitutionDto
      required:
        - address
        - businessName
        - creditorInstitutionCode
        - enabled
        - pspPayment
        - reportingFtp
        - reportingZip
      type: object
      properties:
        address:
          description: Creditor Institution's address object
          $ref: '#/components/schemas/CreditorInstitutionAddressDto'
        businessName:
          type: string
          description: Creditor Institution's business name
        creditorInstitutionCode:
          type: string
          description: Creditor Institution's code(Fiscal Code)
        enabled:
          type: boolean
          description: Creditor Institution activation state on ApiConfig
          example: false
        pspPayment:
          type: boolean
          description: Creditor Institution's is a psp Payment broker
          example: false
        reportingFtp:
          type: boolean
          description: Enables flow towards Creditor Institution in fstp mode
          example: false
        reportingZip:
          type: boolean
          description: Enables the zipping of the content that goes through fstp
          example: false
    CreditorInstitutionResource:
      title: CreditorInstitutionResource
      required:
        - businessName
        - creditorInstitutionCode
        - enabled
      type: object
      properties:
        businessName:
          type: string
          description: Creditor Institution's business name
        creditorInstitutionCode:
          type: string
          description: Creditor Institution's code(Fiscal Code)
        enabled:
          type: boolean
          description: Creditor Institution activation state on ApiConfig
          example: false
    CreditorInstitutionStationDto:
      title: CreditorInstitutionStationDto
      required:
        - stationCode
      type: object
      properties:
        stationCode:
          type: string
          description: Station's unique identifier
    CreditorInstitutionStationEditResource:
      title: CreditorInstitutionStationEditResource
      required:
        - stationCode
      type: object
      properties:
        applicationCode:
          type: integer
          description: Station's application code
          format: int64
        auxDigit:
          type: integer
          description: Station's auxiliary digit
          format: int64
        broadcast:
          type: boolean
          description: Station's broadcast enabled
          example: false
        mod4:
          type: boolean
          description: Station's mod 4 enabled
          example: false
        segregationCode:
          type: integer
          description: Station's segregation code number
          format: int64
        stationCode:
          type: string
          description: Station's unique identifier
    CreditorInstitutionsResource:
      title: CreditorInstitutionsResource
      required:
        - creditor_institutions
        - page_info
      type: object
      properties:
        creditor_institutions:
          type: array
          description: A list of Creditor Institution's
          items:
            $ref: '#/components/schemas/CreditorInstitutionResource'
        page_info:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
    InputStream:
      title: InputStream
      type: object
    InvalidParam:
      title: InvalidParam
      required:
        - name
        - reason
      type: object
      properties:
        name:
          type: string
          description: Invalid parameter name.
        reason:
          type: string
          description: Invalid parameter reason.
    PageInfo:
      title: PageInfo
      type: object
      properties:
        items_found:
          type: integer
          format: int32
        limit:
          type: integer
          format: int32
        page:
          type: integer
          format: int32
        total_pages:
          type: integer
          format: int32
    PaymentServiceProviderDetailsDto:
      title: PaymentServiceProviderDetailsDto
      type: object
      properties:
        abi:
          type: string
        agid_psp:
          type: boolean
        bic:
          type: string
        business_name:
          type: string
        enabled:
          type: boolean
        my_bank_code:
          type: string
        psp_code:
          type: string
        stamp:
          type: boolean
        tax_code:
          type: string
        transfer:
          type: boolean
        vat_number:
          type: string
    PaymentServiceProviderDetailsResource:
      title: PaymentServiceProviderDetailsResource
      required:
        - abi
        - agid_psp
        - bic
        - my_bank_code
        - stamp
        - tax_code
        - transfer
        - vat_number
      type: object
      properties:
        abi:
          type: string
          description: abi of the payment service provider
        agid_psp:
          type: boolean
          description: agid code of the payment service provider
          example: false
        bic:
          type: string
          description: bic of the payment service provider
        business_name:
          type: string
        enabled:
          type: boolean
        my_bank_code:
          type: string
          description: bank code of the payment service provider
        psp_code:
          type: string
        stamp:
          type: boolean
          description: stamp of the payment service provider
          example: false
        tax_code:
          type: string
          description: tax code of the payment service provider
        transfer:
          type: boolean
          description: transfer  of the payment service provider
          example: false
        vat_number:
          type: string
          description: of the payment service provider
    PaymentServiceProviderResource:
      title: PaymentServiceProviderResource
      type: object
      properties:
        business_name:
          type: string
        enabled:
          type: boolean
        psp_code:
          type: string
    PaymentServiceProvidersResource:
      title: PaymentServiceProvidersResource
      type: object
      properties:
        page_info:
          $ref: '#/components/schemas/PageInfo'
        payment_service_providers:
          type: array
          items:
            $ref: '#/components/schemas/PaymentServiceProviderResource'
    PaymentTypeResource:
      title: PaymentTypeResource
      required:
        - description
        - payment_type
      type: object
      properties:
        description:
          type: string
          description: Description of the payment type
        payment_type:
          type: string
          description: Code of payment type
    PaymentTypesResource:
      title: PaymentTypesResource
      required:
        - payment_types
      type: object
      properties:
        payment_types:
          type: array
          description: List of payment types
          items:
            $ref: '#/components/schemas/PaymentTypeResource'
    Problem:
      title: Problem
      required:
        - status
        - title
      type: object
      properties:
        detail:
          type: string
          description: Human-readable description of this specific problem.
        instance:
          type: string
          description: A URI that describes where the problem occurred.
        invalidParams:
          type: array
          description: A list of invalid parameters details.
          items:
            $ref: '#/components/schemas/InvalidParam'
        status:
          type: integer
          description: The HTTP status code.
          format: int32
          example: 500
        title:
          type: string
          description: Short human-readable summary of the problem.
        type:
          type: string
          description: A URL to a page with more details regarding the problem.
      description: A "problem detail" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)
    PspChannelPaymentTypes:
      title: PspChannelPaymentTypes
      type: object
      properties:
        payment_types:
          type: array
          items:
            type: string
    PspChannelPaymentTypesResource:
      title: PspChannelPaymentTypesResource
      required:
        - payment_types
      type: object
      properties:
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
    PspChannelResource:
      title: PspChannelResource
      required:
        - channel_code
        - enabled
        - payment_types
      type: object
      properties:
        channel_code:
          type: string
          description: Channel's unique identifier
        enabled:
          type: boolean
          description: Channel enabled
          example: false
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
    PspChannelsResource:
      title: PspChannelsResource
      required:
        - channels
      type: object
      properties:
        channels:
          type: array
          description: Channel list
          items:
            $ref: '#/components/schemas/PspChannelResource'
    Resource:
      title: Resource
      type: object
      properties:
        description:
          type: string
        file:
          type: string
          format: binary
        filename:
          type: string
        inputStream:
          $ref: '#/components/schemas/InputStream'
        open:
          type: boolean
        readable:
          type: boolean
        uri:
          type: string
          format: uri
        url:
          type: string
          format: url
    StationCodeResource:
      title: StationCodeResource
      required:
        - stationCode
      type: object
      properties:
        stationCode:
          type: string
          description: Station's unique identifier
    StationDetailResource:
      title: StationDetailResource
      required:
        - enabled
        - stationCode
        - stationStatus
      type: object
      properties:
        activationDate:
          type: string
          description: Station's activation date
          format: date-time
        associatedCreditorInstitutions:
          type: integer
          description: Number of station's creditor institutions
          format: int32
        brokerCode:
          type: string
          description: Station's broker code
        brokerDescription:
          type: string
          description: Station broker's description
        brokerDetails:
          description: broker's details
          $ref: '#/components/schemas/BrokerDetailsResource'
        brokerObjId:
          type: integer
          description: Station's broker object id
          format: int64
        createdAt:
          type: string
          description: Station created on
          format: date-time
        enabled:
          type: boolean
          description: Station's activation state
          example: false
        flagOnline:
          type: boolean
          description: Station's online flag
          example: false
        ip:
          type: string
          description: Station's ip address
        ip4Mod:
          type: string
          description: Station's ip v4
        modifiedAt:
          type: string
          description: Station's last modified date
          format: date-time
        newPassword:
          type: string
          description: Station's new password
        password:
          type: string
          description: Station's password
        pofService:
          type: string
          description: Station's pof service
        port:
          type: integer
          description: Station's port
          format: int64
        port4Mod:
          type: integer
          description: Station's v4 port
          format: int64
        primitiveVersion:
          type: integer
          description: Station's primitive version
          format: int32
        protocol:
          type: string
          description: Station's http protocol
          enum:
            - HTTP
            - HTTPS
        protocol4Mod:
          type: string
          description: Station's protocol v4
          enum:
            - HTTP
            - HTTPS
        proxyEnabled:
          type: boolean
          description: Station's proxy enabled variable
          example: false
        proxyHost:
          type: string
          description: Station's proxy host
        proxyPassword:
          type: string
          description: Station's proxy password
        proxyPort:
          type: integer
          description: Station's proxy port
          format: int64
        proxyUsername:
          type: string
          description: Station's proxy username
        redirectIp:
          type: string
          description: Station's redirect Ip
        redirectPath:
          type: string
          description: Station's redirect path
        redirectPort:
          type: integer
          description: Station's redirect port
          format: int64
        redirectProtocol:
          type: string
          description: Station's redirect http protocol
          enum:
            - HTTP
            - HTTPS
        redirectQueryString:
          type: string
          description: Station's redirect query string
        rtInstantaneousDispatch:
          type: boolean
          description: Station's instantaneous rt dispatch
          example: false
        service:
          type: string
          description: Station's service
        service4Mod:
          type: string
          description: Station's service 4
        stationCode:
          type: string
          description: Station's unique identifier
        stationStatus:
          type: string
          description: Station's status
          enum:
            - ACTIVE
            - ON_REVISION
            - TO_BE_CORRECTED
        targetHost:
          type: string
          description: Station's target host
        targetHostPof:
          type: string
          description: Station's target host POF
        targetPath:
          type: string
          description: Station's target path
        targetPathPof:
          type: string
          description: Station's target path POF
        targetPort:
          type: integer
          description: Station target's port
          format: int64
        targetPortPof:
          type: integer
          description: Station's target port POF
          format: int64
        threadNumber:
          type: integer
          description: Station's max thread number
          format: int64
        timeoutA:
          type: integer
          description: Station's timeoutA
          format: int64
        timeoutB:
          type: integer
          description: Station's timeoutB
          format: int64
        timeoutC:
          type: integer
          description: Station's timeoutC
          format: int64
        version:
          type: integer
          description: Station's version
          format: int64
    StationDetails:
      title: StationDetails
      type: object
      properties:
        broker_code:
          type: string
        broker_description:
          type: string
        broker_details:
          $ref: '#/components/schemas/BrokerDetails'
        enabled:
          type: boolean
        flag_online:
          type: boolean
        invio_rt_istantaneo:
          type: boolean
        ip:
          type: string
        ip_4mod:
          type: string
        new_password:
          type: string
        password:
          type: string
        pof_service:
          type: string
        port:
          type: integer
          format: int64
        port_4mod:
          type: integer
          format: int64
        primitive_version:
          type: integer
          format: int32
        protocol:
          type: string
          enum:
            - HTTP
            - HTTPS
        protocol_4mod:
          type: string
          enum:
            - HTTP
            - HTTPS
        proxy_enabled:
          type: boolean
        proxy_host:
          type: string
        proxy_password:
          type: string
        proxy_port:
          type: integer
          format: int64
        proxy_username:
          type: string
        redirect_ip:
          type: string
        redirect_path:
          type: string
        redirect_port:
          type: integer
          format: int64
        redirect_protocol:
          type: string
          enum:
            - HTTP
            - HTTPS
        redirect_query_string:
          type: string
        service:
          type: string
        service_4mod:
          type: string
        station_code:
          type: string
        target_host:
          type: string
        target_host_pof:
          type: string
        target_path:
          type: string
        target_path_pof:
          type: string
        target_port:
          type: integer
          format: int64
        target_port_pof:
          type: integer
          format: int64
        thread_number:
          type: integer
          format: int64
        timeout_a:
          type: integer
          format: int64
        timeout_b:
          type: integer
          format: int64
        timeout_c:
          type: integer
          format: int64
        version:
          type: integer
          format: int64
    StationDetailsDto:
      title: StationDetailsDto
      required:
        - brokerCode
        - primitiveVersion
        - redirectIp
        - redirectPath
        - redirectPort
        - redirectProtocol
        - redirectQueryString
        - stationCode
        - targetHost
        - targetPath
        - targetPort
      type: object
      properties:
        brokerCode:
          type: string
          description: Station's broker code
        brokerDescription:
          type: string
          description: Station broker's description
        brokerObjId:
          type: integer
          description: Station's broker object id
          format: int64
        enabled:
          type: boolean
          description: Station's activation state
          example: false
        flagOnline:
          type: boolean
          description: Station's online flag
          example: false
        ip:
          type: string
          description: Station's ip address
        ip4Mod:
          type: string
          description: Station's ip v4
        newPassword:
          type: string
          description: Station's new password
        note:
          type: string
          description: station note description by operation team
        password:
          type: string
          description: Station's password
        pofService:
          type: string
          description: Station's pof service
        port:
          type: integer
          description: Station's port
          format: int64
        port4Mod:
          type: integer
          description: Station's v4 port
          format: int64
        primitiveVersion:
          type: integer
          description: Station's primitive version
          format: int32
        protocol:
          type: string
          description: Station's http protocol
          enum:
            - HTTP
            - HTTPS
        protocol4Mod:
          type: string
          description: Station's protocol v4
          enum:
            - HTTP
            - HTTPS
        proxyEnabled:
          type: boolean
          description: Station's proxy enabled variable
          example: false
        proxyHost:
          type: string
          description: Station's proxy host
        proxyPassword:
          type: string
          description: Station's proxy password
        proxyPort:
          type: integer
          description: Station's proxy port
          format: int64
        proxyUsername:
          type: string
          description: Station's proxy username
        redirectIp:
          type: string
          description: Station's redirect Ip
        redirectPath:
          type: string
          description: Station's redirect path
        redirectPort:
          type: integer
          description: Station's redirect port
          format: int64
        redirectProtocol:
          type: string
          description: Station's redirect http protocol
          enum:
            - HTTP
            - HTTPS
        redirectQueryString:
          type: string
          description: Station's redirect query string
        rtInstantaneousDispatch:
          type: boolean
          description: Station's instantaneous rt dispatch
          example: false
        service:
          type: string
          description: Station's service
        service4Mod:
          type: string
          description: Station's service 4
        stationCode:
          type: string
          description: Station's unique identifier
        status:
          type: string
          description: Station's status
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        targetHost:
          type: string
          description: Station's target host
        targetPath:
          type: string
          description: Station's target path
        targetPort:
          type: integer
          description: Station target's port
          format: int64
        threadNumber:
          type: integer
          description: Station's max thread number
          format: int64
        timeoutA:
          type: integer
          description: Station's timeoutA
          format: int64
        timeoutB:
          type: integer
          description: Station's timeoutB
          format: int64
        timeoutC:
          type: integer
          description: Station's timeoutC
          format: int64
    StationDetailsResourceList:
      title: StationDetailsResourceList
      required:
        - stations
      type: object
      properties:
        page_info:
          $ref: '#/components/schemas/PageInfo'
        stations:
          type: array
          description: Object that contains List of ec stations
          items:
            $ref: '#/components/schemas/StationDetailResource'
    StationResource:
      title: StationResource
      required:
        - enabled
        - stationCode
        - stationStatus
      type: object
      properties:
        activationDate:
          type: string
          description: Station's activation date
          format: date-time
        associatedCreditorInstitutions:
          type: integer
          description: Number of station's creditor institutions
          format: int32
        brokerDescription:
          type: string
          description: Station broker's description
        createdAt:
          type: string
          description: Station created on
          format: date-time
        enabled:
          type: boolean
          description: Station's activation state
          example: false
        modifiedAt:
          type: string
          description: Station's last modified date
          format: date-time
        stationCode:
          type: string
          description: Station's unique identifier
        stationStatus:
          type: string
          description: Station's status
          enum:
            - ACTIVE
            - ON_REVISION
            - TO_BE_CORRECTED
        version:
          type: integer
          description: Station's version
          format: int64
    StationsResource:
      title: StationsResource
      required:
        - pageInfo
        - stationsList
      type: object
      properties:
        pageInfo:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
        stationsList:
          type: array
          description: List of ec stations
          items:
            $ref: '#/components/schemas/StationResource'
    UpdateCreditorInstitutionDto:
      title: UpdateCreditorInstitutionDto
      required:
        - address
        - businessName
        - creditorInstitutionCode
        - enabled
        - pspPayment
        - reportingFtp
        - reportingZip
      type: object
      properties:
        address:
          description: Creditor Institution's address object
          $ref: '#/components/schemas/CreditorInstitutionAddressDto'
        businessName:
          type: string
          description: Creditor Institution's business name
        creditorInstitutionCode:
          type: string
          description: Creditor Institution's code(Fiscal Code)
        enabled:
          type: boolean
          description: Creditor Institution activation state on ApiConfig
          example: false
        pspPayment:
          type: boolean
          description: Creditor Institution's is a psp Payment broker
          example: false
        reportingFtp:
          type: boolean
          description: Enables flow towards Creditor Institution in fstp mode
          example: false
        reportingZip:
          type: boolean
          description: Enables the zipping of the content that goes through fstp
          example: false
    WfespPluginConf:
      title: WfespPluginConf
      type: object
      properties:
        id_bean:
          type: string
        id_serv_plugin:
          type: string
        pag_const_string_profile:
          type: string
        pag_rpt_xpath_profile:
          type: string
        pag_soap_rule_profile:
          type: string
    WfespPluginConfs:
      title: WfespPluginConfs
      type: object
      properties:
        wfesp_plugin_confs:
          type: array
          items:
            $ref: '#/components/schemas/WfespPluginConf'
    WrapperChannelDetailsDto:
      title: WrapperChannelDetailsDto
      type: object
      properties:
        broker_description:
          type: string
          description: Broker description. Read only field
        broker_psp_code:
          type: string
          description: 'psp code '
        channel_code:
          type: string
          description: Channel code
        note:
          type: string
          description: channel note description by operation team
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
        redirect_ip:
          type: string
          description: redirect ip
        redirect_path:
          type: string
          description: redirect path
        redirect_port:
          type: integer
          description: redirect port
          format: int64
        redirect_protocol:
          type: string
          description: redirect protocol
          enum:
            - HTTP
            - HTTPS
        redirect_query_string:
          type: string
          description: redirect query string
        status:
          type: string
          description: channel's validation status
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        target_host:
          type: string
          description: target host
        target_path:
          type: string
          description: target path's
        target_port:
          type: integer
          description: target port
          format: int64
    WrapperChannelDetailsResource:
      title: WrapperChannelDetailsResource
      type: object
      properties:
        agid:
          type: boolean
          description: agid
          example: false
        broker_description:
          type: string
          description: Broker description. Read only field
        broker_psp_code:
          type: string
          description: 'psp code '
        card_chart:
          type: boolean
          description: card chart
          example: false
        channel_code:
          type: string
          description: Channel code
        created_at:
          type: string
          description: creation date
          format: date-time
        digital_stamp_brand:
          type: boolean
          description: digital stamp brand
          example: false
        enabled:
          type: boolean
        flag_io:
          type: boolean
          description: flag io
          example: false
        id:
          type: string
          description: entities id(mongodb)
        ip:
          type: string
          description: channel's ip
        modified_at:
          type: string
          description: modification date
          format: date-time
        modified_by:
          type: string
          description: modified by
        modified_by_opt:
          type: string
          description: modified byoperator
        new_fault_code:
          type: boolean
          description: new fault code
          example: false
        new_password:
          type: string
          description: channel's new password
        nmp_service:
          type: string
          description: nmp service
        note:
          type: string
          description: channel note description by operation team
        on_us:
          type: boolean
          description: on us
          example: false
        password:
          type: string
          description: channel's password
        payment_model:
          type: string
          description: payment model
          enum:
            - ACTIVATED_AT_PSP
            - DEFERRED
            - IMMEDIATE
            - IMMEDIATE_MULTIBENEFICIARY
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
        port:
          type: integer
          description: channel's port
          format: int64
        primitive_version:
          type: string
          description: primitive version
        protocol:
          type: string
          description: channel's protocol
          enum:
            - HTTP
            - HTTPS
        proxy_enabled:
          type: boolean
          description: proxy Enabled
          example: false
        proxy_host:
          type: string
          description: proxy Host
        proxy_password:
          type: string
          description: proxy Password
        proxy_port:
          type: integer
          description: proxy Port
          format: int64
        proxy_username:
          type: string
          description: proxy Username
        recovery:
          type: boolean
          description: recovery
          example: false
        redirect_ip:
          type: string
          description: redirect ip
        redirect_path:
          type: string
          description: redirect path
        redirect_port:
          type: integer
          description: redirect port
          format: int64
        redirect_protocol:
          type: string
          description: redirect protocol
          enum:
            - HTTP
            - HTTPS
        redirect_query_string:
          type: string
          description: redirect query string
        rt_push:
          type: boolean
          description: rt Push
          example: false
        serv_plugin:
          type: string
          description: service plugin
        service:
          type: string
          description: channel's service
        target_host:
          type: string
          description: target host
        target_host_nmp:
          type: string
          description: target host NMP
        target_path:
          type: string
          description: target path's
        target_path_nmp:
          type: string
          description: target path NMP
        target_port:
          type: integer
          description: target port
          format: int64
        target_port_nmp:
          type: string
          description: target port NMP
        thread_number:
          type: integer
          description: thread number
          format: int64
        timeout_a:
          type: integer
          description: timeout A
          format: int64
        timeout_b:
          type: integer
          description: timeout B
          format: int64
        timeout_c:
          type: integer
          description: timeout C
          format: int64
        type:
          type: string
          description: entities type
          enum:
            - CHANNEL
            - STATION
    WrapperChannelResource:
      title: WrapperChannelResource
      required:
        - wrapperStatus
      type: object
      properties:
        broker_description:
          type: string
          description: Broker description. Read only field
        channel_code:
          type: string
          description: Channel code
        createdAt:
          type: string
          description: creation date
          format: date-time
        enabled:
          type: boolean
        modifiedAt:
          type: string
          description: modification date
          format: date-time
        wrapperStatus:
          type: string
          description: channel's validation status
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
    WrapperChannelsResource:
      title: WrapperChannelsResource
      required:
        - channels
        - page_info
      type: object
      properties:
        channels:
          type: array
          description: list of psp and ec channels
          items:
            $ref: '#/components/schemas/WrapperChannelResource'
        page_info:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
    WrapperEntitiesList:
      title: WrapperEntitiesList
      type: object
      properties:
        page_info:
          $ref: '#/components/schemas/PageInfo'
        wrapper_entities:
          type: array
          items:
            $ref: '#/components/schemas/WrapperEntitiesOperationsOfobject'
    WrapperEntitiesOperations:
      title: WrapperEntitiesOperations
      type: object
      properties:
        brokerCode:
          type: string
        createdAt:
          type: string
          format: date-time
        createdBy:
          type: string
        id:
          type: string
        modifiedAt:
          type: string
          format: date-time
        modifiedBy:
          type: string
        modifiedByOpt:
          type: string
        note:
          type: string
        status:
          type: string
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        type:
          type: string
          enum:
            - CHANNEL
            - STATION
        wrapperEntityOperationsSortedList:
          type: array
          items:
            $ref: '#/components/schemas/WrapperEntityOperationsOfobject'
    WrapperEntitiesOperationsOfStationDetails:
      title: WrapperEntitiesOperationsOfStationDetails
      type: object
      properties:
        brokerCode:
          type: string
        createdAt:
          type: string
          format: date-time
        createdBy:
          type: string
        id:
          type: string
        modifiedAt:
          type: string
          format: date-time
        modifiedBy:
          type: string
        modifiedByOpt:
          type: string
        note:
          type: string
        status:
          type: string
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        type:
          type: string
          enum:
            - CHANNEL
            - STATION
        wrapperEntityOperationsSortedList:
          type: array
          items:
            $ref: '#/components/schemas/WrapperEntityOperationsOfStationDetails'
    WrapperEntitiesOperationsOfobject:
      title: WrapperEntitiesOperationsOfobject
      type: object
      properties:
        brokerCode:
          type: string
        createdAt:
          type: string
          format: date-time
        createdBy:
          type: string
        id:
          type: string
        modifiedAt:
          type: string
          format: date-time
        modifiedBy:
          type: string
        modifiedByOpt:
          type: string
        note:
          type: string
        status:
          type: string
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        type:
          type: string
          enum:
            - CHANNEL
            - STATION
        wrapperEntityOperationsSortedList:
          type: array
          items:
            $ref: '#/components/schemas/WrapperEntityOperationsOfobject'
    WrapperEntityOperationsOfStationDetails:
      title: WrapperEntityOperationsOfStationDetails
      type: object
      properties:
        createdAt:
          type: string
          format: date-time
        entity:
          $ref: '#/components/schemas/StationDetails'
        id:
          type: string
        modifiedAt:
          type: string
          format: date-time
        modifiedBy:
          type: string
        modifiedByOpt:
          type: string
        note:
          type: string
        status:
          type: string
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        type:
          type: string
          enum:
            - CHANNEL
            - STATION
    WrapperEntityOperationsOfobject:
      title: WrapperEntityOperationsOfobject
      type: object
      properties:
        createdAt:
          type: string
          format: date-time
        entity:
          type: object
        id:
          type: string
        modifiedAt:
          type: string
          format: date-time
        modifiedBy:
          type: string
        modifiedByOpt:
          type: string
        note:
          type: string
        status:
          type: string
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        type:
          type: string
          enum:
            - CHANNEL
            - STATION
    WrapperStationDetailsDto:
      title: WrapperStationDetailsDto
      required:
        - primitiveVersion
        - redirectIp
        - redirectPath
        - redirectPort
        - redirectProtocol
        - redirectQueryString
        - stationCode
        - targetHost
        - targetPath
        - targetPort
      type: object
      properties:
        brokerCode:
          type: string
          description: Station's broker code
        note:
          type: string
          description: station note description by operation team
        primitiveVersion:
          type: integer
          description: Station's primitive version
          format: int32
        redirectIp:
          type: string
          description: Station's redirect Ip
        redirectPath:
          type: string
          description: Station's redirect path
        redirectPort:
          type: integer
          description: Station's redirect port
          format: int64
        redirectProtocol:
          type: string
          description: Station's redirect http protocol
          enum:
            - HTTP
            - HTTPS
        redirectQueryString:
          type: string
          description: Station's redirect query string
        stationCode:
          type: string
          description: Station's unique identifier
        status:
          type: string
          description: Station's status
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
        targetHost:
          type: string
          description: Station's target host
        targetPath:
          type: string
          description: Station's target path
        targetPort:
          type: integer
          description: Station target's port
          format: int64
    WrapperStationResource:
      title: WrapperStationResource
      required:
        - enabled
        - stationCode
        - stationStatus
        - wrapperStatus
      type: object
      properties:
        activationDate:
          type: string
          description: Station's activation date
          format: date-time
        associatedCreditorInstitutions:
          type: integer
          description: Number of station's creditor institutions
          format: int32
        brokerDescription:
          type: string
          description: Station broker's description
        createdAt:
          type: string
          description: Station created on
          format: date-time
        enabled:
          type: boolean
          description: Station's activation state
          example: false
        modifiedAt:
          type: string
          description: Station's last modified date
          format: date-time
        stationCode:
          type: string
          description: Station's unique identifier
        stationStatus:
          type: string
          description: Station's status
          enum:
            - ACTIVE
            - ON_REVISION
            - TO_BE_CORRECTED
        version:
          type: integer
          description: Station's version
          format: int64
        wrapperStatus:
          type: string
          description: Station's status
          enum:
            - APPROVED
            - TO_CHECK
            - TO_CHECK_UPDATE
            - TO_FIX
    WrapperStationsResource:
      title: WrapperStationsResource
      required:
        - pageInfo
        - stationsList
      type: object
      properties:
        pageInfo:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
        stationsList:
          type: array
          description: List of ec stations
          items:
            $ref: '#/components/schemas/WrapperStationResource'
  securitySchemes:
    bearerAuth:
      type: http
      description: A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
