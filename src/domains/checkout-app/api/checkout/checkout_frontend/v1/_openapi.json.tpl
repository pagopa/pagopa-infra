{
    "openapi": "3.0.0",
    "info": {
        "version": "1.0.0",
        "title": "Checkout Frontend Proxy",
        "description": "APIM proxy for checkout frontend via App Gateway. Used during CDN migration and retained as fallback path for Front Door CDN."
    },
    "servers": [
        {
            "url": "https://${host}"
        }
    ],
    "tags": [
        {
            "name": "checkoutFrontend",
            "description": "Proxy for checkout frontend served by Front Door CDN"
        }
    ],
    "paths": {
        "/*": {
            "get": {
                "operationId": "checkoutFrontendCatchAllGet",
                "tags": ["checkoutFrontend"],
                "summary": "Proxy GET requests to checkout frontend",
                "description": "Catch-all route for all frontend requests (pages and static assets)",
                "responses": {
                    "200": {
                        "description": "Proxied response from Front Door"
                    },
                    "304": {
                        "description": "Not modified"
                    },
                    "404": {
                        "description": "Not found"
                    }
                }
            },
            "post": {
                "operationId": "checkoutFrontendCatchAllPost",
                "tags": ["checkoutFrontend"],
                "summary": "Proxy POST requests to checkout frontend",
                "description": "Catch-all route for POST requests",
                "responses": {
                    "200": {
                        "description": "Proxied response from Front Door"
                    },
                    "404": {
                        "description": "Not found"
                    }
                }
            },
            "head": {
                "operationId": "checkoutFrontendCatchAllHead",
                "tags": ["checkoutFrontend"],
                "summary": "Proxy HEAD requests to checkout frontend",
                "description": "Catch-all route for HEAD requests",
                "responses": {
                    "200": {
                        "description": "Proxied response from Front Door"
                    },
                    "304": {
                        "description": "Not modified"
                    },
                    "404": {
                        "description": "Not found"
                    }
                }
            },
            "options": {
                "operationId": "checkoutFrontendCatchAllOptions",
                "tags": ["checkoutFrontend"],
                "summary": "CORS preflight requests",
                "description": "Catch-all route for OPTIONS preflight requests required by CORS.",
                "responses": {
                    "200": {
                        "description": "CORS preflight response"
                    },
                    "204": {
                        "description": "No content"
                    }
                }
            }
        }
    }
}
