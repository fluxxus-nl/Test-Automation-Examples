Feature 'Extended Text on blanket assembly order/Add text line' {
    Scenario 0060 'Add to blanket assembly order line for text with extended text enabled' {
        Given 'Standard text with extended text enabled for blanket assembly order'
        Given 'Blanket blanket assembly order'
        When 'Add text line to blanket assembly order page'
        Then 'Extended text lines are added to blanket assembly order'
    }

    Scenario 0075 'Add to blanket assembly order line for text with extended text disabled' {
        Given 'Standard text with extended text disabled for blanket assembly order'
        Given 'Blanket blanket assembly order'
        When 'Add text line to blanket assembly order page'
        Then 'No extended text lines are added to blanket assembly order'
    }

    Scenario 0062 'Insert extended texts for text with extended texts on blanket assembly order line' {
        Given 'Standard text with extended text disabled for blanket assembly order'
        Given 'Blanket blanket assembly order with text line'
        When 'Insert extended text'
        Then 'Extended text lines are added to blanket assembly order' 
    }

    Scenario 0063 'Insert extended texts for text with no extended texts on blanket assembly order line' {
        Given 'Standard text with extended text disabled for blanket assembly order'
        Given 'Blanket blanket assembly order with text line'
        When 'Insert extended text'
        Then 'No extended text lines are added to blanket assembly order' 
    }

    Scenario 0064 'Insert extended texts twice for text with extended texts on blanket assembly order line' {
        Given 'Standard text with extended text enabled for blanket assembly order'
        Given 'Blanket blanket assembly order with text line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to blanket assembly order'
    }
 
    Scenario 0065 'Replace text with extended texts by text without extended texts on blanket assembly order line' {
        Given 'Standard text with extended text enabled for blanket assembly order'
        Given 'Standard text with no extended text'
        Given 'Blanket blanket assembly order with text line and extended text inserted'
        When 'Replace text by text with no extended text'
        Then 'Text is replaced and extended text lines are removed'
    }
}

Feature 'Extended Text on blanket assembly order/Delete text line' {
    Scenario 0066 'Delete text line with extended text' {
        Given 'Standard text with extended text enabled for blanket assembly order'
        Given 'Blanket assembly order with text line and extended text inserted'
        When 'Delete text line from blanket assembly order'
        Then 'Text  and extended text lines are removed'
    }  
}    