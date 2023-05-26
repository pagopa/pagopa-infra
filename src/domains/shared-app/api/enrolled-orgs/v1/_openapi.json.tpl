{
	"openapi": "3.0.1",
	"info": {
		"title": "OpenAPI definition - Enrolled EC",
		"version": "0.0.1"
	},
	"servers": [
		{
			"url": "${host}",
			"description": "Generated server url"
		}
	],
	"paths": {
		"/organizations/domains/{domain}": {
			"get": {
				"tags": [
					"Enrolled EC API"
				],
				"summary": "Get EC list enrolled to a domain.",
				"operationId": "getEnrolledEC",
				"parameters": [
					{
						"name": "domain",
						"in": "path",
						"description": "The subscribing domain.",
						"required": true,
						"schema": {
							"type": "string"
						}
					}
				],
				"responses": {
					"200": {
						"description": "Operation executed successfully.",
						"content": {
							"application/json": {}
						}
					},
					"429": {
						"description": "Too many requests"
					},
					"500": {
						"description": "Service unavailable.",
						"content": {
							"application/json": {}
						}
					}
				}
			}
		}
	}
}