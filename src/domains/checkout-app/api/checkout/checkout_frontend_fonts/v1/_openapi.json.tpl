{
    "openapi": "3.0.0",
    "info": {
        "version": "1.0.0",
        "title": "Checkout Frontend Fonts Proxy",
        "description": "APIM proxy for checkout frontend font assets. Dedicated API to expose fonts to NPG SDK origin via CORS."
    },
    "servers": [
        {
            "url": "https://${host}"
        }
    ],
    "tags": [
        {
            "name": "checkoutFrontendFonts",
            "description": "Proxy for checkout frontend font assets"
        }
    ],
    "paths": {
        "/*": {
            "get": {
                "operationId": "checkoutFrontendFontsCatchAllGet",
                "tags": ["checkoutFrontendFonts"],
                "summary": "Proxy GET requests for font assets",
                "description": "Catch-all route for font asset requests",
                "responses": {
                    "200": {
                        "description": "Font asset"
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
                "operationId": "checkoutFrontendFontsCatchAllOptions",
                "tags": ["checkoutFrontendFonts"],
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
