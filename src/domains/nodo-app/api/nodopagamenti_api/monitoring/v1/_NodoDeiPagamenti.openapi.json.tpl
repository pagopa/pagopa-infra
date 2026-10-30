{
        "info": {
                "description": "Api and Models",
                "title": "_NodoDeiPagamenti",
                "version": "1.0"
        },
        "openapi": "3.0.1",
        "paths": {
                "/*": {
                        "delete": {
                                "operationId": "del",
                                "responses": {
                                        "200": {
                                                "description": ""
                                        }
                                },
                                "summary": "del"
                        },
                        "get": {
                                "operationId": "get",
                                "responses": {
                                        "200": {
                                                "description": ""
                                        }
                                },
                                "summary": "get"
                        },
                        "head": {
                                "operationId": "head",
                                "responses": {
                                        "200": {
                                                "description": ""
                                        }
                                },
                                "summary": "head"
                        },
                        "options": {
                                "operationId": "opt",
                                "responses": {
                                        "200": {
                                                "description": ""
                                        }
                                },
                                "summary": "opt"
                        },
                        "post": {
                                "operationId": "post",
                                "responses": {
                                        "200": {
                                                "description": ""
                                        }
                                },
                                "summary": "post"
                        },
                        "put": {
                                "operationId": "put",
                                "responses": {
                                        "200": {
                                                "description": ""
                                        }
                                },
                                "summary": "put"
                        }
                },
                "/cache/version": {
                        "get": {
                                "operationId": "cache-version",
                                "responses": {
                                        "200": {
                                                "description": ""
                                        }
                                },
                                "summary": "cache/version"
                        }
                }
        },
        "servers": [
                {
                        "url": "https://${host}"
                }
        ]
}