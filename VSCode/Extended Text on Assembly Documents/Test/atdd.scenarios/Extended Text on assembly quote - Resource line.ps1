Feature 'Extended Text on assembly quote/Add resource line' {
    Scenario 0032 'Add to assembly quote line for resource with "Automatic Ext. Texts"disabled and extended text enabled' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Assembly quote'
        When 'Add resource line to assembly quote page'
        Then 'No extended text lines are added to assembly quote' 
    }

    Scenario 0033 'Add to assembly quote line for resource with "Automatic Ext. Texts" enabled and extended text enabled' {
        Given 'Resource with "Automatic Ext. Texts" enabled and extended text enabled for assembly quote'
        Given 'Assembly quote'
        When 'Add resource line to assembly quote page'
        Then 'Extended text lines are added to assembly quote' 
    }

    Scenario 0071 'Add to assembly quote line for resource with "Automatic Ext. Texts" enabled and extended text disabled' {
        Given 'Resource with "Automatic Ext. Texts" enabled and extended text disabled for assembly quote'
        Given 'Assembly quote'
        When 'Add resource line to assembly quote page'
        Then 'No extended text lines are added to assembly quote' 
    }

    Scenario 0034 'Insert extended texts for resource with extended texts on assembly quote line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Assembly quote with resource line'
        When 'Insert extended text'
        Then 'Extended text lines are added to assembly quote' 
    }

    Scenario 0035 'Insert extended texts for resource with no extended texts on assembly quote line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text disabled for assembly quote'
        Given 'Assembly quote with resource line'
        When 'Insert extended text'
        Then 'No extended text lines are added to assembly quote' 
    }

    Scenario 0036 'Insert extended texts twice for resource with extended texts on assembly quote line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Assembly quote with resource line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to assembly quote' 
    }

    Scenario 0037 'Replace resource with extended texts by resource without extended texts on assembly quote line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Resource with no extended text'
        Given 'Assembly quote with resource line and extended text inserted'
        When 'Replace resource by resource with no extended text'
        Then 'Resource is replaced and extended text lines are removed' 
    }
}

Feature 'Extended Text on assembly quote/Delete resource line' {
    Scenario 0038 'Delete resource line with extended text' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote'
        Given 'Assembly quote with resource line and extended text inserted'
        When 'Delete resource line from assembly quote'
        Then 'Resource  and extended text lines are removed'
    } 
}    