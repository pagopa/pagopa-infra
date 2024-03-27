openapi: 3.0.3
info:
  title: pagopa-selfcare-ms-backoffice
  description: PagoPa backoffice API documentation
  version: 0.3.10
servers:
  - url:  'https://${host}/${basePath}'
tags:
  - name: channels
    description: Api config channels operations
  - name: stations
    description: Api config stations operations
paths:
  /channels/getBrokersPsp:
    get:
      tags:
        - channels
      summary: getBrokersPsp
      description: Get list of psp brokers
      operationId: getBrokersPspUsingGET
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
          description: Broker's code
          required: false
          style: form
          schema:
            type: string
        - name: name
          in: query
          description: Broker's name
          required: false
          style: form
          schema:
            type: string
        - name: orderby
          in: query
          description: Order by column name
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
                $ref: '#/components/schemas/BrokersPspResource'
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
  /stations/brokers-EC:
    get:
      tags:
        - stations
      summary: getBrokersEC
      description: Get paginated list of creditor brokers
      operationId: getBrokersECUsingGET
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
          description: code
          required: false
          style: form
          schema:
            type: string
        - name: name
          in: query
          description: name
          required: false
          style: form
          schema:
            type: string
        - name: orderby
          in: query
          description: order by name or code, default = CODE
          required: false
          style: form
          schema:
            type: string
            enum:
              - CODE
              - NAME
        - name: ordering
          in: query
          description: ordering
          required: false
          style: form
          schema:
            type: string
            enum:
              - ASC
              - DESC
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BrokersResource'
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
components:
  schemas:
    BrokerOrPspDetailsResource:
      title: BrokerOrPspDetailsResource
      type: object
      properties:
        brokerPspDetailsResource:
          $ref: '#/components/schemas/BrokerPspDetailsResource'
        paymentServiceProviderDetailsResource:
          $ref: '#/components/schemas/PaymentServiceProviderDetailsResource'
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
    BrokerPspResource:
      title: BrokerPspResource
      type: object
      properties:
        broker_psp_code:
          type: string
        description:
          type: string
        enabled:
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
    BrokersPspResource:
      title: BrokersPspResource
      type: object
      properties:
        brokers_psp:
          type: array
          description: Psp's broker
          items:
            $ref: '#/components/schemas/BrokerPspResource'
        page_info:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
    BrokersResource:
      title: BrokersResource
      type: object
      properties:
        brokers:
          type: array
          items:
            $ref: '#/components/schemas/BrokerResource'
    IbanCreateRequestDto:
      title: IbanCreateRequestDto
      required:
        - active
        - creditorInstitutionCode
        - dueDate
        - iban
        - validityDate
      type: object
      properties:
        active:
          type: boolean
          description: True if the iban is active
          example: false
        creditorInstitutionCode:
          type: string
          description: Creditor Institution's code(Fiscal Code)
        description:
          type: string
          description: The description the Creditor Institution gives to the iban about its usage
        dueDate:
          type: string
          description: The date on which the iban will expire
          format: date-time
        iban:
          type: string
          description: The iban code
        labels:
          type: array
          description: The labels array associated with the iban
          items:
            $ref: '#/components/schemas/IbanLabel'
        validityDate:
          type: string
          description: The date the Creditor Institution wants the iban to be used for its payments
          format: date-time
    IbanLabel:
      title: IbanLabel
      required:
        - description
        - name
      type: object
      properties:
        description:
          type: string
          description: Label description
        name:
          type: string
          description: Label name
    IbanResource:
      title: IbanResource
      required:
        - active
        - dueDate
        - ecOwner
        - iban
        - publicationDate
        - validityDate
      type: object
      properties:
        active:
          type: boolean
          description: True if the iban is active
          example: false
        companyName:
          type: string
          description: The Creditor Institution company name
        description:
          type: string
          description: The description the Creditor Institution gives to the iban about its usage
        dueDate:
          type: string
          description: The date on which the iban will expire
          format: date-time
        ecOwner:
          type: string
          description: Fiscal code of the Creditor Institution who owns the iban
        iban:
          type: string
          description: The iban code
        labels:
          type: array
          description: The labels array associated with the iban
          items:
            $ref: '#/components/schemas/IbanLabel'
        publicationDate:
          type: string
          description: The date on which the iban has been inserted in the system
          format: date-time
        validityDate:
          type: string
          description: The date the Creditor Institution wants the iban to be used for its payments
          format: date-time
    IbansResource:
      title: IbansResource
      required:
        - ibanList
      type: object
      properties:
        ibanList:
          type: array
          description: Creditor Institution's address object
          items:
            $ref: '#/components/schemas/IbanResource'
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
    PaymentServiceProviderDetailsResource:
      title: PaymentServiceProviderDetailsResource
      required:
        - abi
        - agid_psp
        - bic
        - my_bank_code
        - stamp
        - tax_code
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
        vat_number:
          type: string
          description: of the payment service provider
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
  securitySchemes:
    bearerAuth:
      type: http
      description: A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
