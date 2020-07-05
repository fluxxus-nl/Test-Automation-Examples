Feature 'Extended Text on blanket assembly order/Add item line' {
    Scenario 0011 'Add to blanket assembly order line for item with "Automatic Ext. Texts"disabled and extended text enabled' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly blanket blanket order'
        Given 'Blanket assembly order'
        When 'Add item line to blanket assembly order page'
        Then 'No extended text lines are added to blanket assembly order' 
    }

    Scenario 0012 'Add to blanket assembly order line for item with "Automatic Ext. Texts" enabled and extended text enabled' {
        Given 'Item with "Automatic Ext. Texts" enabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order'
        When 'Add item line to blanket assembly order page'
        Then 'Extended text lines are added to blanket assembly order'
    }

    Scenario 0069 'Add to blanket assembly order line for item with "Automatic Ext. Texts" enabled and extended text disabled' {
        Given 'Item with "Automatic Ext. Texts" enabled and extended text disabled for blanket assembly order'
        Given 'Blanket assembly order'
        When 'Add item line to blanket assembly order page'
        Then 'No extended text lines are added to blanket assembly order'
    }

    Scenario 0013 'Insert extended texts for item with extended texts on blanket assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order with item line'
        When 'Insert extended text'
        Then 'Extended text lines are added to blanket assembly order' 
    }

    Scenario 0014 'Insert extended texts for item with no extended texts on blanket assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text disabled for blanket assembly order'
        Given 'Blanket assembly order with item line'
        When 'Insert extended text'
        Then 'No extended text lines are added to blanket assembly order' 
    }

    Scenario 0023 'Insert extended texts twice for item with extended texts on blanket assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order with item line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to blanket assembly order'
    }

    Scenario 0024 'Replace item with extended texts by item without extended texts on blanket assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Item with no extended text'
        Given 'Blanket assembly order with item line and extended text inserted'
        When 'Replace item by item with no extended text'
        Then 'Item is replaced and extended text lines are removed' 
    } 
}

Feature 'Extended Text on blanket assembly order/Delete item line' {
    Scenario 0015 'Delete item line with extended text' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Blanket assembly order with item line and extended text inserted'
        When 'Delete item line from blanket assembly order'
        Then 'Item  and extended text lines are removed' 
    }
}