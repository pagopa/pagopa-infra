openapi: 3.0.0
info:
  version: 1.0.0
  title: Pagopa authService endpoints used by the checkout authenticated payment flow

  description: This microservice that expose authService services to allow authenticaded flow.
servers:
  - url: https://${host}
tags:
  - name: authService
    description: Api's used as interface towards the identity provider, it provides Login, Logout, Self information and token validation


    externalDocs:
      url: https://pagopa.atlassian.net/wiki/spaces/I/pages/1443463171/DR+-+Autenticazione+in+Checkout+-+Fase+1
      description: Technical specifications

paths:
  /auth/login:
    get:
      tags:
        - authService
      operationId: authLogin
      summary: Login endpoint
      description: 'GET login endpoint with reCAPTCHA code'
      parameters:
        - in: query
          name: recaptcha
          required: true
          description: reCAPTCHA code
          schema:
            type: string
      responses:
        '200':
          description: Successful login
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/LoginResponse'
        '400':
          description: Formally invalid input
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '404':
          description: User not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '500':
          description: Internal server error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
  /auth/users:
    get:
      tags:
        - authService
      operationId: authUsers
      summary: Get user information
      description: 'GET user information'
      security:
        - bearerAuth: []
      responses:
        '200':
          description: Successful retrieval of user information
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserInfoResponse'
        '400':
          description: Formally invalid input
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '401':
          description: Unauthorized
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '404':
          description: User not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '500':
          description: Internal server error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
  /auth/logout:
    post:
      tags:
        - authService
      operationId: authLogout
      summary: Logout endpoint
      description: 'GET logout endpoint'
      security:
        - bearerAuth: []
      responses:
        '204':
          description: Successful logout
        '400':
          description: Formally invalid input
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '401':
          description: Unauthorized
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '404':
          description: User not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '500':
          description: Internal server error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
  /auth/token:
    post:
      tags:
        - authService
      operationId: authenticateWithAuthToken
      summary: Authentication endpoint
      description: 'POST authentication endpoint with auth code'
      requestBody:
        $ref: '#/components/requestBodies/AuthRequest'
      responses:
        '200':
          description: Successful authentication
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthResponse'
        '400':
          description: Formally invalid input
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '401':
          description: Unauthorized
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '404':
          description: User not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '500':
          description: Internal server error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
  /auth/validate:
    get:
      tags:
        - authService
      operationId: validateToken
      summary: Validate a token
      description: 'GET endpoint to validate a token'
      security:
        - bearerAuth: []
      responses:
        '200':
          description: Token is valid
        '400':
          description: Invalid token
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '401':
          description: Unauthorized
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'
        '500':
          description: Internal server error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProblemJson'

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
  schemas:
    LoginResponse:
      type: object
      properties:
        urlRedirect:
          type: string
    ProblemJson:
      type: object
      properties:
        type:
          type: string
          format: uri
          description: |-
            An absolute URI that identifies the problem type. When dereferenced,
            it SHOULD provide human-readable documentation for the problem type
            (e.g., using HTML).
          default: about:blank
          example: https://example.com/problem/constraint-violation
        title:
          type: string
          description: |-
            A short, summary of the problem type. Written in english and readable
            for engineers (usually not suited for non technical stakeholders and
            not localized); example: Service Unavailable
        status:
          $ref: '#/components/schemas/HttpStatusCode'
        detail:
          type: string
          description: |-
            A human readable explanation specific to this occurrence of the
            problem.
          example: There was an error processing the request
        instance:
          type: string
          format: uri
          description: |-
            An absolute URI that identifies the specific occurrence of the problem.
            It may or may not yield further information if dereferenced.
    HttpStatusCode:
      type: integer
      format: int32
      description: |-
        The HTTP status code generated by the origin server for this occurrence
        of the problem.
      minimum: 100
      maximum: 600
      exclusiveMaximum: true
      example: 200
    UserInfoResponse:
      type: object
      properties:
        userInfo:
          type: object
          properties:
            userId:
              type: string
            firstName:
              type: string
            lastName:
              type: string
            email:
              type: string
    AuthResponse:
      type: object
      properties:
        authToken:
          type: string
  requestBodies:
    AuthRequest:
      required: true
      content:
        application/json:
          schema:
            type: object
            properties:
              authCode:
                type: string
