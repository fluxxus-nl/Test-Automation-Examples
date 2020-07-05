Feature 'Extended Text on assembly order/Add item line' {
    Scenario 0001 'Add to assembly order line for item with "Automatic Ext. Texts"disabled and extended text enabled' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order'
        When 'Add item line to assembly order page'
        Then 'No extended text lines are added to assembly order' 
    }
    
    Scenario 0002 'Add to assembly order line for item with "Automatic Ext. Texts" enabled and extended text enabled' {
        Given 'Item with "Automatic Ext. Texts" enabled and extended text enabled for assembly order'
        Given 'Assembly order'
        When 'Add item line to assembly order page'
        Then 'Extended text lines are added to assembly order' 
    }

    Scenario 0067 'Add to assembly order line for item with "Automatic Ext. Texts" enabled and extended text disabled' {
        Given 'Item with "Automatic Ext. Texts" enabled and extended text disabled for assembly order'
        Given 'Assembly order'
        When 'Add item line to assembly order page'
        Then 'No extended text lines are added to assembly order' 
    }

    Scenario 0003 'Insert extended texts for item with extended texts on assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order with item line'
        When 'Insert extended text'
        Then 'Extended text lines are added to assembly order' 
    }

    Scenario 0004 'Insert extended texts for item with no extended texts on assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text disabled for assembly order'
        Given 'Assembly order with item line'
        When 'Insert extended text'
        Then 'No extended text lines are added to assembly order'
    }

    Scenario 0019 'Insert extended texts twice for item with extended texts on assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order with item line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to assembly order' 
    }

    Scenario 0020 'Replace item with extended texts by item without extended texts on assembly order line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Item with no extended text'
        Given 'Assembly order with item line and extended text inserted'
        When 'Replace item by item with no extended text'
        Then 'Item is replaced and extended text lines are removed'
    } 
}

Feature 'Extended Text on assembly order/Delete item line' {
    Scenario 0005 'Delete item line with extended text' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order with item line and extended text inserted'
        When 'Delete item line from assembly order'
        Then 'Item  and extended text lines are removed'
    }
}