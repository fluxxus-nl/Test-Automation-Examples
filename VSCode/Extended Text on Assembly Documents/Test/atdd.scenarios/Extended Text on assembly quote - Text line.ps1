Feature 'Extended Text on assembly quote/Add text line' {
    Scenario 0053 'Add to assembly quote line for text with extended text enabled' {
        Given 'Standard text with extended text enabled for assembly quote'
        Given 'Assembly quote'
        When 'Add text line to assembly quote page'
        Then 'Extended text lines are added to assembly quote'
    }

    Scenario 0074 'Add to assembly quote line for text with extended text disabled' {
        Given 'Standard text with extended text disabled for assembly quote'
        Given 'Assembly quote'
        When 'Add text line to assembly quote page'
        Then 'No extended text lines are added to assembly quote'
    }

    Scenario 0055 'Insert extended texts for text with extended texts on assembly quote line' {
        Given 'Standard text with extended text disabled for assembly quote'
        Given 'Assembly quote with text line'
        When 'Insert extended text'
        Then 'Extended text lines are added to assembly quote' 
    }

    Scenario 0056 'Insert extended texts for text with no extended texts on assembly quote line' {
        Given 'Standard text with extended text disabled for assembly quote'
        Given 'Assembly quote with text line'
        When 'Insert extended text'
        Then 'No extended text lines are added to assembly quote' 
    }

    Scenario 0057 'Insert extended texts twice for text with extended texts on assembly quote line' {
        Given 'Standard text with extended text enabled for assembly quote'
        Given 'Assembly quote with text line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to assembly quote'
    }
 
    Scenario 0058 'Replace text with extended texts by text without extended texts on assembly quote line' {
        Given 'Standard text with extended text enabled for assembly quote'
        Given 'Standard text with no extended text'
        Given 'Assembly quote with text line and extended text inserted'
        When 'Replace text by text with no extended text'
        Then 'Text is replaced and extended text lines are removed'
    } 
}

Feature 'Extended Text on assembly quote/Delete text line' {
    Scenario 0059 'Delete text line with extended text' {
        Given 'Standard text with extended text enabled for assembly quote'
        Given 'Assembly quote with text line and extended text inserted'
        When 'Delete text line from assembly quote'
        Then 'Text  and extended text lines are removed'
    }
}    