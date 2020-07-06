Feature 'Extended Text on assembly order/Add text line' {
    Scenario 0046 'Add to assembly order line for text with extended text enabled' {
        Given 'Standard text with extended text enabled for assembly order'
        Given 'Assembly order'
        When 'Add text line to assembly order page'
        Then 'Extended text lines are added to assembly order' 
    }

    Scenario 0073 'Add to assembly order line for text with extended text disabled' {
        Given 'Standard text with extended text disabled for assembly order'
        Given 'Assembly order'
        When 'Add text line to assembly order page'
        Then 'No extended text lines are added to assembly order'
    }

    Scenario 0048 'Insert extended texts for text with extended texts on assembly order line' {
        Given 'Standard text with extended text disabled for assembly order'
        Given 'Assembly order with text line'
        When 'Insert extended text'
        Then 'Extended text lines are added to assembly order' 
    }

    Scenario 0049 'Insert extended texts for text with no extended texts on assembly order line' {
        Given 'Standard text with extended text disabled for assembly order'
        Given 'Assembly order with text line'
        When 'Insert extended text'
        Then 'No extended text lines are added to assembly order' 
    }

    Scenario 0050 'Insert extended texts twice for text with extended texts on assembly order line' {
        Given 'Standard text with extended text enabled for assembly order'
        Given 'Assembly order with text line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to assembly order'
    }

    Scenario 0051 'Replace text with extended texts by text without extended texts on assembly order line' {
        Given 'Standard text with extended text enabled for assembly order'
        Given 'Standard text with no extended text'
        Given 'Assembly order with text line and extended text inserted'
        When 'Replace text by text with no extended text'
        Then 'Text is replaced and extended text lines are removed'
    }
}

Feature 'Extended Text on assembly order/Delete text line' {
    Scenario 0052 'Delete text line with extended text' {
        Given 'Standard text with extended text enabled for assembly order'
        Given 'Assembly order with text line and extended text inserted'
        When 'Delete text line from assembly order'
        Then 'Text  and extended text lines are removed' 
    }
}    