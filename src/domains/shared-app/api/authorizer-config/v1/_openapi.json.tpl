{
  "openapi": "3.0.1",
  "info": {
  "title": "platform-authorizer-config-crud",
  "description": "A microservice that provides a set of APIs to manage authorization records for the Authorizer system.",
  "termsOfService": "https://www.pagopa.gov.it/",
  "version": "0.2.14"
  },
  "servers": [
  {
  "url": "{host}",
  "description": "Generated server url"
  }
  ],
  "tags": [
  {
  "name": "Cached Authorizations",
  "description": "Everything about cached authorizations"
  },
  {
  "name": "Authorizations",
  "description": "Everything about authorizations"
  }
  ],
  "paths": {
  "/authorizations/{authorizationId}": {
  "get": {
  "tags": [
  "Authorizations"
  ],
  "summary": "Get authorization by identifier",
  "operationId": "getAuthorization",
  "parameters": [
  {
  "name": "authorizationId",
  "in": "path",
  "description": "The identifier of the stored authorization.",
  "required": true,
  "schema": {
  "type": "string"
  }
  }
  ],
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "404": {
  "description": "Not found",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/AuthorizationList"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  },
  "put": {
  "tags": [
  "Authorizations"
  ],
  "summary": "Update existing authorization",
  "operationId": "updateAuthorization",
  "parameters": [
  {
  "name": "authorizationId",
  "in": "path",
  "description": "The identifier of the stored authorization.",
  "required": true,
  "schema": {
  "type": "string"
  }
  }
  ],
  "requestBody": {
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/Authorization"
  }
  }
  },
  "required": true
  },
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "404": {
  "description": "Not found",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/AuthorizationList"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  },
  "delete": {
  "tags": [
  "Authorizations"
  ],
  "summary": "Delete existing authorization",
  "operationId": "deleteAuthorization",
  "parameters": [
  {
  "name": "authorizationId",
  "in": "path",
  "description": "The identifier of the stored authorization.",
  "required": true,
  "schema": {
  "type": "string"
  }
  },
  {
  "name": "customKeyFormat",
  "in": "query",
  "description": "Custom key for cache used by APIM",
  "required": false,
  "schema": {
  "type": "string",
  "default": ""
  }
  }
  ],
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "404": {
  "description": "Not found",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "403": {
  "description": "Forbidden"
  },
  "200": {
  "description": "OK"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  }
  },
  "/cachedauthorizations/{domain}/refresh": {
  "post": {
  "tags": [
  "Cached Authorizations"
  ],
  "summary": "Refresh cached authorizations by domain and owner",
  "operationId": "refreshCachedAuthorizations",
  "parameters": [
  {
  "name": "domain",
  "in": "path",
  "description": "The domain on which the authorizations will be filtered.",
  "required": true,
  "schema": {
  "type": "string"
  }
  },
  {
  "name": "ownerId",
  "in": "query",
  "description": "The identifier of the authorizations' owner.",
  "required": false,
  "schema": {
  "type": "string"
  }
  }
  ],
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "401": {
  "description": "Unauthorized"
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {}
  }
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  }
  },
  "/authorizations": {
  "get": {
  "tags": [
  "Authorizations"
  ],
  "summary": "Get authorization list",
  "operationId": "getAuthorizations_1",
  "parameters": [
  {
  "name": "domain",
  "in": "query",
  "description": "The domain on which the authorizations will be filtered.",
  "required": true,
  "schema": {
  "type": "string"
  }
  },
  {
  "name": "ownerId",
  "in": "query",
  "description": "The identifier of the authorizations' owner.",
  "required": false,
  "schema": {
  "type": "string"
  }
  },
  {
  "name": "limit",
  "in": "query",
  "description": "The number of elements to be included in the page.",
  "required": true,
  "schema": {
  "maximum": 999,
  "type": "integer",
  "format": "int32",
  "default": 10
  }
  },
  {
  "name": "page",
  "in": "query",
  "description": "The index of the page, starting from 0.",
  "required": true,
  "schema": {
  "minimum": 0,
  "type": "integer",
  "format": "int32",
  "default": 0
  }
  }
  ],
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/AuthorizationList"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  },
  "post": {
  "tags": [
  "Authorizations"
  ],
  "summary": "Create new authorization",
  "operationId": "createAuthorization",
  "requestBody": {
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/Authorization"
  }
  }
  },
  "required": true
  },
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/AuthorizationList"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "409": {
  "description": "Conflict",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  }
  },
  "/info": {
  "get": {
  "tags": [
  "Home"
  ],
  "summary": "Return OK if application is started",
  "operationId": "healthCheck",
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "400": {
  "description": "Bad Request",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/AppInfo"
  }
  }
  }
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  }
  },
  "/cachedauthorizations": {
  "get": {
  "tags": [
  "Cached Authorizations"
  ],
  "summary": "Get cached authorizations",
  "operationId": "getAuthorizations",
  "parameters": [
  {
  "name": "domain",
  "in": "query",
  "description": "The domain on which the authorizations will be filtered.",
  "required": true,
  "schema": {
  "type": "string"
  }
  },
  {
  "name": "ownerId",
  "in": "query",
  "description": "The identifier of the authorizations' owner.",
  "required": false,
  "schema": {
  "type": "string"
  }
  },
  {
  "name": "formatTTL",
  "in": "query",
  "description": "The identifier of the authorizations' owner.",
  "required": false,
  "schema": {
  "type": "boolean",
  "default": true
  }
  },
  {
  "name": "customKeyFormat",
  "in": "query",
  "description": "Custom key for cache used by APIM",
  "required": false,
  "schema": {
  "type": "string",
  "default": ""
  }
  }
  ],
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/CachedAuthorizationList"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  }
  },
  "/authorizations/subkey/{subscriptionKey}": {
  "get": {
  "tags": [
  "Authorizations"
  ],
  "summary": "Get authorization by subscription key",
  "operationId": "getAuthorizationBySubscriptionKey",
  "parameters": [
  {
  "name": "subscriptionKey",
  "in": "path",
  "description": "The subscription key related to the stored authorization.",
  "required": true,
  "schema": {
  "type": "string"
  }
  }
  ],
  "responses": {
  "429": {
  "description": "Too many requests"
  },
  "404": {
  "description": "Not found",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  },
  "200": {
  "description": "OK",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/AuthorizationList"
  }
  }
  }
  },
  "401": {
  "description": "Unauthorized"
  },
  "403": {
  "description": "Forbidden"
  },
  "500": {
  "description": "Service unavailable",
  "content": {
  "application/json": {
  "schema": {
  "$ref": "#/components/schemas/ProblemJson"
  }
  }
  }
  }
  },
  "security": [
  {
  "ApiKey": []
  }
  ]
  }
  }
  },
  "components": {
  "schemas": {
  "Authorization": {
  "required": [
  "authorized_entities",
  "domain",
  "other_metadata",
  "owner",
  "subscription_key"
  ],
  "type": "object",
  "properties": {
  "id": {
  "type": "string",
  "description": "The identifier of the saved authorization, automatically generated during creation as UUID."
  },
  "domain": {
  "type": "string",
  "description": "The domain to which the authorization belongs, within which it has validity. Typically, it is defined by choosing from a pool of tags that already exist and are used by the various membership domains."
  },
  "subscription_key": {
  "type": "string",
  "description": "The value of the subscription key to be associated with the stored authorization. This key is assigned to an entity that wants to interface with a pagoPA service via APIM, and is the pivotal element on which the Authorizer system will make its evaluations. No two authorizations can exist with the same domain-subscription_key value pair."
  },
  "description": {
  "type": "string",
  "description": "An optional description useful to add more information about the scope of the authorization, defining information also impossible to include in the other tags."
  },
  "owner": {
  "$ref": "#/components/schemas/AuthorizationOwner"
  },
  "authorized_entities": {
  "type": "array",
  "description": "The authorized entity list, which are the resource identifiers that the caller includes in requests that define which objects the entity is authorized to operate on. It consists of a key-value map in which the entity name and its identifier are defined, respectively, in order to make maintenance easier.",
  "items": {
  "$ref": "#/components/schemas/AuthorizationEntity"
  }
  },
  "other_metadata": {
  "type": "array",
  "description": "The list of authorization metadata, useful for performing other types of computation after the authorization process.",
  "items": {
  "$ref": "#/components/schemas/AuthorizationMetadata"
  }
  },
  "inserted_at": {
  "type": "string",
  "description": "The date of authorization entry. This value is set only in authorization creation operations.",
  "readOnly": true
  },
  "last_update": {
  "type": "string",
  "description": "The date of last authorization update. It is only visible as output in read requests.",
  "readOnly": true
  },
  "last_forced_refresh": {
  "type": "string",
  "description": "The date of last forced refresh of the authorization. It is updated only when the forced refresh API is executed.",
  "readOnly": true
  }
  },
  "description": "The list of authorization retrieved from search."
  },
  "AuthorizationEntity": {
  "required": [
  "name",
  "value",
  "values"
  ],
  "type": "object",
  "properties": {
  "name": {
  "type": "string",
  "description": "The name or the description associated to the authorization entity in order to reference it in a more human-readable mode."
  },
  "value": {
  "type": "string",
  "description": "The single simple value related to an entity to be authorized to access within an authorization. Only one between 'value' and 'values' tag at a time can exists in this object."
  },
  "values": {
  "type": "array",
  "description": "The multiple composite sub-values which concatenation forms a complex entity to be authorized to access within an authorization. Only one between 'value' and 'values' tag at a time can exists in this object.",
  "items": {
  "type": "string",
  "description": "The multiple composite sub-values which concatenation forms a complex entity to be authorized to access within an authorization. Only one between 'value' and 'values' tag at a time can exists in this object."
  }
  }
  },
  "description": "The authorized entity list, which are the resource identifiers that the caller includes in requests that define which objects the entity is authorized to operate on. It consists of a key-value map in which the entity name and its identifier are defined, respectively, in order to make maintenance easier."
  },
  "AuthorizationGenericKeyValue": {
  "required": [
  "key",
  "value",
  "values"
  ],
  "type": "object",
  "properties": {
  "key": {
  "type": "string",
  "description": "The key used to reference the metadata into the related map."
  },
  "value": {
  "type": "string",
  "description": "The single simple value related to the metadata. Only one between 'value' and 'values' tag at a time can exists in this object."
  },
  "values": {
  "type": "array",
  "description": "The set of values related to the metadata. Only one between 'value' and 'values' tag at a time can exists in this object.",
  "items": {
  "type": "string",
  "description": "The set of values related to the metadata. Only one between 'value' and 'values' tag at a time can exists in this object."
  }
  }
  },
  "description": "A key-value map that defines the actual content of the metadata to be stored."
  },
  "AuthorizationMetadata": {
  "required": [
  "content",
  "name",
  "short_key"
  ],
  "type": "object",
  "properties": {
  "name": {
  "type": "string",
  "description": "A description that defines the full name of the metadata."
  },
  "short_key": {
  "pattern": "_[a-zA-Z0-9]{1,3}",
  "type": "string",
  "description": "The key that defines an abbreviation by which it will be identified in cached maps."
  },
  "content": {
  "type": "array",
  "description": "A key-value map that defines the actual content of the metadata to be stored.",
  "items": {
  "$ref": "#/components/schemas/AuthorizationGenericKeyValue"
  }
  }
  },
  "description": "The list of authorization metadata, useful for performing other types of computation after the authorization process."
  },
  "AuthorizationOwner": {
  "required": [
  "id",
  "name",
  "type"
  ],
  "type": "object",
  "properties": {
  "id": {
  "type": "string",
  "description": "The identifier of the authorization owner. This can be the fiscal code of the entity/intermediary or other information that uniquely identifies that entity."
  },
  "name": {
  "type": "string",
  "description": "The name of the authorization owner, useful in order to make an authorization more human-readable. It can be the entity's business name or any other information that helps its recognition."
  },
  "type": {
  "type": "string",
  "description": "The authorization owner type, useful both for adding an additional recognizable 'label' to the subject and for use as a search filter.",
  "enum": [
  "BROKER",
  "CI",
  "OTHER",
  "PSP"
  ]
  }
  },
  "description": "The information about the owner of the authorization. These information are required in order to make maintenance easier and performs some kind of search operations."
  },
  "ProblemJson": {
  "type": "object",
  "properties": {
  "title": {
  "type": "string",
  "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
  },
  "status": {
  "maximum": 600,
  "minimum": 100,
  "type": "integer",
  "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
  "format": "int32",
  "example": 200
  },
  "detail": {
  "type": "string",
  "description": "A human readable explanation specific to this occurrence of the problem.",
  "example": "There was an error processing the request"
  }
  }
  },
  "AuthorizationList": {
  "required": [
  "authorizations",
  "page_info"
  ],
  "type": "object",
  "properties": {
  "authorizations": {
  "type": "array",
  "description": "The list of authorization retrieved from search.",
  "items": {
  "$ref": "#/components/schemas/Authorization"
  }
  },
  "page_info": {
  "$ref": "#/components/schemas/PageInfo"
  }
  }
  },
  "PageInfo": {
  "required": [
  "items_found",
  "limit",
  "page",
  "total_pages"
  ],
  "type": "object",
  "properties": {
  "page": {
  "type": "integer",
  "description": "The page number",
  "format": "int32"
  },
  "limit": {
  "type": "integer",
  "description": "The required maximum number of items per page",
  "format": "int32"
  },
  "items_found": {
  "type": "integer",
  "description": "The number of items found. (The last page may have fewer elements than required)",
  "format": "int32"
  },
  "total_pages": {
  "type": "integer",
  "description": "The total number of pages",
  "format": "int32"
  }
  },
  "description": "The information related to the paginated results."
  },
  "AppInfo": {
  "type": "object",
  "properties": {
  "name": {
  "type": "string"
  },
  "version": {
  "type": "string"
  },
  "environment": {
  "type": "string"
  },
  "dbConnection": {
  "type": "string"
  }
  }
  },
  "CachedAuthorization": {
  "required": [
  "ttl"
  ],
  "type": "object",
  "properties": {
  "description": {
  "type": "string",
  "description": "The description that is associated with particular noteworthy items to be added to the list of cached information."
  },
  "owner": {
  "type": "string",
  "description": "The identifier of the authorization owner. This can be the fiscal code of the entity/intermediary or other information that uniquely identifies that entity."
  },
  "subscription_key": {
  "type": "string",
  "description": "The value of the subscription key associated with the cached authorization."
  },
  "ttl": {
  "type": "string",
  "description": "The remaining Time-to-Live related to the cached authorization. This can be formatted either in seconds format or in a particular format that follows the structure 'XXh YYm ZZs'."
  }
  },
  "description": "The list of authorization cached in Authorizer system."
  },
  "CachedAuthorizationList": {
  "required": [
  "cached_authorizations"
  ],
  "type": "object",
  "properties": {
  "cached_authorizations": {
  "type": "array",
  "description": "The list of authorization cached in Authorizer system.",
  "items": {
  "$ref": "#/components/schemas/CachedAuthorization"
  }
  }
  }
  }
  },
  "securitySchemes": {
  "ApiKey": {
  "type": "apiKey",
  "description": "The API key to access this function app.",
  "name": "Ocp-Apim-Subscription-Key",
  "in": "header"
  }
  }
  }
  }
