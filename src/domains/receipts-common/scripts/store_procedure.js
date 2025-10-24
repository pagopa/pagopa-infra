function resolver(incomingItem, existingItem, isTombstone, conflictingItems) {
    var collection = getContext().getCollection();

    // Config
    var MAX_ITEMS = 5000; // safety guard - adjust as needed

    // Helpers
    function getCartIdValidElseReturnEmpty(doc) {
        if (!doc || !doc.payload || !Array.isArray(doc.payload.cart)) return [];
        return doc.payload.cart;
    }

    function initializePayloadIfNotExist(doc) {
        if (!doc.payload) doc.payload = {};
    }

    // Build map keyed by bizEventId. We'll index in order:
    // 1) existingItem (older committed)
    // 2) conflictingItems (other committed variants)
    // 3) incomingItem (incoming should override any previous item with same key)
    var indexedCartItems = Object.create(null);
    var bizEventIds = [];

    function indexCartItem(items) {
    if (!items || !Array.isArray(items)) return;
    for (var i = 0; i < items.length; i++) {
        var it = items[i];
        if (!it) continue;
        var key = it.bizEventId;
        if (!key) continue;
        if (!indexedCartItems.hasOwnProperty(key)) {
            bizEventIds.push(key);
        }
        indexedCartItems[key] = it; // later indexing (incoming) overwrites earlier
      }
    }


    // ------- START CONFLICT RESOLUTION --------

    // If incoming is null => It is a delete operation so delete the existing committed doc (if any)
    if (!incomingItem) {
        if (existingItem) {
            collection.deleteDocument(existingItem._self, {}, function(err, resp) {
                if (err) throw err;
            });
        }
        return;
    }

    // If incoming conflicts with a tombstone (previously deleted) -> delete wins
    if (isTombstone) {
        // do nothing (delete takes precedence)
        return;
    }

    // Index cartItems in committed document
    indexCartItem(getCartIdValidElseReturnEmpty(existingItem));

    // Index cartItems in all committed conflictingItems
    if (Array.isArray(conflictingItems)) {
        for (var ci = 0; ci < conflictingItems.length; ci++) {
            indexCartItem(getCartIdValidElseReturnEmpty(conflictingItems[ci]));
        }
    }

    // Index cartItems in incoming last so it has precedence for same keys
    indexCartItem(getCartIdValidElseReturnEmpty(incomingItem));

    // Build merged array preserving insertion order
    var merged = [];
    for (var ki = 0; ki < bizEventIds.length; ki++) {
        var k = bizEventIds[ki];
        if (indexedCartItems.hasOwnProperty(k)) {
            merged.push(indexed[k]);
        }
    }

    // Safety: limit merged size to avoid runaway RU/time costs
    if (merged.length > MAX_ITEMS) {
        throw new Error("Merged cart size exceeds limit: " + merged.length);
    }

    // Assign merged cart into incomingItem payload
    initializePayloadIfNotExist(incomingItem);
    incomingItem.payload.cart = merged;

    // Delete all conflicting documents iteratively, then replace/create the resolved incoming doc
    var toDelete = Array.isArray(conflictingItems) ? conflictingItems.slice() : [];

    tryDelete(toDelete, incomingItem, existingItem);

    function tryDelete(documents, incoming, existing) {
        if (documents.length > 0) {
            collection.deleteDocument(documents[0]._self, {}, function (err, responseOptions) {
                if (err) throw err;
                documents.shift();
                tryDelete(documents, incoming, existing);
            });
        } else if (existing) {
            collection.replaceDocument(existing._self, incoming, function (err, documentCreated) {
                if (err) throw err;
            });
        } else {
            collection.createDocument(collection.getSelfLink(), incoming, function (err, documentCreated) {
                if (err) throw err;
            });
        }
    }
}
