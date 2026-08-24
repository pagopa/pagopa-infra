{
    "openapi": "3.0.0",
    "info": {
        "version": "1.0.0",
        "title": "Wallet Frontend Proxy",
        "description": "APIM proxy for wallet frontend via App Gateway. Used during CDN migration and retained as fallback path for Front Door CDN."
    },
    "servers": [
        {
            "url": "https://${host}"
        }
    ],
    "tags": [
        {
            "name": "walletFrontend",
            "description": "Proxy for wallet frontend served by Front Door CDN"
        }
    ],
    "paths": {
        "/fonts/*": {
            "get": {
                "operationId": "walletFrontendGetFonts",
                "tags": ["walletFrontend"],
                "summary": "Proxy GET requests for font assets",
                "description": "Route for font asset requests - allows NPG SDK origin via CORS",
                "responses": {
                    "200": {
                        "description": "Font asset"
                    },
                    "304": {
                        "description": "Not modified"
                    },
                    "403": {
                        "description": "Forbidden - non-.ttf request from NPG origin"
                    },
                    "404": {
                        "description": "Not found"
                    }
                }
            },
            "options": {
                "operationId": "walletFrontendFontsCorsOptions",
                "tags": ["walletFrontend"],
                "summary": "CORS preflight for font assets",
                "description": "OPTIONS preflight for font asset requests from NPG SDK origin",
                "responses": {
                    "200": {
                        "description": "CORS preflight response"
                    },
                    "204": {
                        "description": "No content"
                    }
                }
            }
        },
        "/*": {
            "get": {
                "operationId": "walletFrontendCatchAllGet",
                "tags": ["walletFrontend"],
                "summary": "Proxy GET requests to wallet frontend",
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
                "operationId": "walletFrontendCatchAllPost",
                "tags": ["walletFrontend"],
                "summary": "Proxy POST requests to wallet frontend",
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
                "operationId": "walletFrontendCatchAllHead",
                "tags": ["walletFrontend"],
                "summary": "Proxy HEAD requests to wallet frontend",
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
                "operationId": "walletFrontendCatchAllOptions",
                "tags": ["walletFrontend"],
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
