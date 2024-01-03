function resolver(incomingItem, existingItem, isTombstone, conflictingItems) {
    var collection = getContext().getCollection();
    if (!incomingItem) {
        if (existingItem) {
            collection.deleteDocument(existingItem._self, {},
                function (err, responseOptions) {
                    if (err) throw err;
                });
        }
    } else if (isTombstone) {
        // delete always wins.
    } else {
        var mergedData = incomingItem.cartPaymentId;
        if (existingItem && existingItem.cartPaymentId) {
            mergedData = mergedData.concat(existingItem.cartPaymentId);
            mergedData = mergedData.filter((item, pos) => mergedData.indexOf(item) === pos);
        }
        var i;
        for (i = 0; i < conflictingItems.length; i++) {
            mergedData = mergedData.concat(conflictingItems[i].cartPaymentId);
            mergedData = mergedData.filter((item, pos) => mergedData.indexOf(item) === pos);
        }
        incomingItem.cartPaymentId = mergedData;
        tryDelete(conflictingItems, incomingItem, existingItem);
    }

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