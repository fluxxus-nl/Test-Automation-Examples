Feature 'Extended Text on assembly quote/Add item line' {
    Scenario 0006 'Add to assembly quote line for item with "Automatic Ext. Texts"disabled and extended text enabled' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Assembly quote'
        When 'Add item line to assembly quote page'
        Then 'No extended text lines are added to assembly quote' 
    }

    Scenario 0007 'Add to assembly quote line for item with "Automatic Ext. Texts" enabled and extended text enabled' {
        Given 'Item with "Automatic Ext. Texts" enabled and extended text enabled for assembly quote'
        Given 'Assembly quote'
        When 'Add item line to assembly quote page'
        Then 'Extended text lines are added to assembly quote' 
    }

    Scenario 0068 'Add to assembly quote line for item with "Automatic Ext. Texts" enabled and extended text disabled' {
        Given 'Item with "Automatic Ext. Texts" enabled and extended text disabled for assembly quote'
        Given 'Assembly quote'
        When 'Add item line to assembly quote page'
        Then 'No extended text lines are added to assembly quote' 
    }

    Scenario 0008 'Insert extended texts for item with extended texts on assembly quote line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Assembly quote with item line'
        When 'Insert extended text'
        Then 'Extended text lines are added to assembly quote'
    }

    Scenario 0009 'Insert extended texts for item with no extended texts on assembly quote line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text disabled for assembly quote'
        Given 'Assembly quote with item line'
        When 'Insert extended text'
        Then 'No extended text lines are added to assembly quote' 
    }

    Scenario 0021 'Insert extended texts twice for item with extended texts on assembly quote line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Assembly quote with item line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to assembly quote'
    }

    Scenario 0022 'Replace item with extended texts by item without extended texts on assembly quote line' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Item with no extended text'
        Given 'Assembly quote with item line and extended text inserted'
        When 'Replace item by item with no extended text'
        Then 'Item is replaced and extended text lines are removed'
    }
}

Feature 'Extended Text on assembly quote/Delete item line' {
    Scenario 0010 'Delete item line with extended text' {
        Given 'Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly quote with item line and extended text inserted'
        When 'Delete item line from assembly quote'
        Then 'Item  and extended text lines are removed'
    }
}
    