openapi: 3.0.3
info:
  title: pagopa-selfcare-ms-backoffice
  description: PagoPa backoffice API documentation
  version: 0.0.57
servers:
  - url: 'https://${host}/${basePath}'
    description: Inferred Url
tags:
  - name: channels
    description: Api config channels operations
paths:
  '/channels':
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
        - name: X-Request-Id
          in: header
          description: internal request trace id
          required: false
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
      parameters:
        - name: X-Request-Id
          in: header
          description: internal request trace id
          required: false
          schema:
            type: string
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
        npm_service:
          type: string
          description: npm service
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
        port:
          type: integer
          description: channel's port
          format: int64
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
        target_path:
          type: string
          description: 'target path''s '
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
        npm_service:
          type: string
          description: npm service
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
        port:
          type: integer
          description: channel's port
          format: int64
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
        target_path:
          type: string
          description: 'target path''s '
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
