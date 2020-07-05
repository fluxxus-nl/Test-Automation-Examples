Feature 'Extended Text on blanket assembly order/Add resource line' {
    Scenario 0039 'Add to blanket assembly order line for resource with "Automatic Ext. Texts"disabled and extended text enabled' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order'
        When 'Add resource line to blanket assembly order page'
        Then 'No extended text lines are added to blanket assembly order'
    }

    Scenario 0040 'Add to blanket assembly order line for resource with "Automatic Ext. Texts" enabled and extended text enabled' {
        Given 'Resource with "Automatic Ext. Texts" enabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order'
        When 'Add resource line to blanket assembly order page'
        Then 'Extended text lines are added to blanket assembly order' 
    }

    Scenario 0072 'Add to blanket assembly order line for resource with "Automatic Ext. Texts" enabled and extended text disabled' {
        Given 'Resource with "Automatic Ext. Texts" enabled and extended text disabled for blanket assembly order'
        Given 'Blanket assembly order'
        When 'Add resource line to blanket assembly order page'
        Then 'No extended text lines are added to blanket assembly order' 
    }

    Scenario 0041 'Insert extended texts for resource with extended texts on blanket assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order with resource line'
        When 'Insert extended text'
        Then 'Extended text lines are added to blanket assembly order'
    }

    Scenario 0042 'Insert extended texts for resource with no extended texts on blanket assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text disabled for blanket assembly order'
        Given 'Blanket assembly order with resource line'
        When 'Insert extended text'
        Then 'No extended text lines are added to blanket assembly order' 
    }

    Scenario 0043 'Insert extended texts twice for resource with extended texts on blanket assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order with resource line and extended text inserted'
        When 'Insert extended text'
        Then 'No additional extended text lines are added to blanket assembly order' 
    }

    Scenario 0044 'Replace resource with extended texts by resource without extended texts on blanket assembly order line' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Resource with no extended text'
        Given 'Blanket assembly order with resource line and extended text inserted'
        When 'Replace resource by resource with no extended text'
        Then 'Resource is replaced and extended text lines are removed' 
    } 
}

Feature 'Extended Text on blanket assembly order/Delete resource line' {
    Scenario 0045 'Delete resource line with extended text' {
        Given 'Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order'
        Given 'Blanket assembly order with resource line and extended text inserted'
        When 'Delete resource line from blanket assembly order'
        Then 'Resource  and extended text lines are removed' 
    }
}