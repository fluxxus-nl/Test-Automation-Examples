Feature 'Extended Text on assembly order/Add resource line' {
    Scenario 0025 'Add to assembly order line for resource with "Automatic Ext. Texts"disabled and extended text enabled' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order'
        When 'Add resource line to assembly order page'
        Then 'No extended text lines are added to assembly order' 
    }
    
    Scenario 0026 'Add to assembly order line for resource with "Automatic Ext. Texts" enabled and extended text enabled' {
        Given 'Resource with "Automatic Ext. Texts" enabled and extended text enabled for assembly order'
        Given 'Assembly order'
        When 'Add resource line to assembly order page'
        Then 'Extended text lines are added to assembly order' 
    }

    Scenario 0070 'Add to assembly order line for resource with "Automatic Ext. Texts" enabled and extended text disabled' {
        Given 'Resource with "Automatic Ext. Texts" enabled and extended text disabled for assembly order'
        Given 'Assembly order'
        When 'Add resource line to assembly order page'
        Then 'No extended text lines are added to assembly order'
    }

    Scenario 0027 'Insert extended texts for resource with extended texts on assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order with resource line'
        When 'Insert extended text'
        Then 'Extended text lines are added to assembly order'
    }

    Scenario 0028 'Insert extended texts for resource with no extended texts on assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text disabled for assembly order'
        Given 'Assembly order with resource line'
        When 'Insert extended text'
        Then 'No extended text lines are added to assembly order' 
    }

    Scenario 0029 'Insert extended texts twice for resource with extended texts on assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order with resource line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to assembly order' 
    }

    Scenario 0030 'Replace resource with extended texts by resource without extended texts on assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Resource with no extended text'
        Given 'Assembly order with resource line and extended text inserted'
        When 'Replace resource by resource with no extended text'
        Then 'Resource is replaced and extended text lines are removed' 
    } 
}

Feature 'Extended Text on assembly order/Delete resource line' {
    Scenario 0031 'Delete resource line with extended text' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order'
        Given 'Assembly order with resource line and extended text inserted'
        When 'Delete resource line from assembly order'
        Then 'Resource  and extended text lines are removed'
    } 
}