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
        "/": {
            "get": {
                "operationId": "checkoutFrontendRoot",
                "tags": ["checkoutFrontend"],
                "summary": "Proxy root request to checkout frontend",
                "description": "Serves the checkout frontend index page via Front Door CDN.",
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
            }
        },
        "/dona": {
            "get": {
                "operationId": "checkoutFrontendDonate",
                "tags": ["checkoutFrontend"],
                "summary": "Proxy /dona request",
                "description": "Serves the checkout donation page (rewritten to /dona.html).",
                "responses": {
                    "200": {
                        "description": "Proxied response from Front Door"
                    },
                    "404": {
                        "description": "Not found"
                    }
                }
            }
        },
        "/termini-di-servizio": {
            "get": {
                "operationId": "checkoutFrontendTerms",
                "tags": ["checkoutFrontend"],
                "summary": "Proxy /termini-di-servizio request",
                "description": "Serves the checkout terms of service page (rewritten to /terms/it.html).",
                "responses": {
                    "200": {
                        "description": "Proxied response from Front Door"
                    },
                    "404": {
                        "description": "Not found"
                    }
                }
            }
        },
        "/*": {
            "get": {
                "operationId": "checkoutFrontendCatchAll",
                "tags": ["checkoutFrontend"],
                "summary": "Proxy static asset requests",
                "description": "Catch-all route for static assets (JS, CSS, images, etc.) served by Front Door CDN. Matches multi-segment paths like /static/js/main.js.",
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
            }
        }
    }
}
