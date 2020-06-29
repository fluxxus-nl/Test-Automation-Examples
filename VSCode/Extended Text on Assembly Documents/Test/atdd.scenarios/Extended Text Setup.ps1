Feature 'Extended Text/Setup' {
    Scenario 0016 '"Assembly Quote" on Extended Text card page for item' {
        Given 'Item with extended text'
        When 'Open Extended Text card page'
        Then '"Assembly Quote" is not set on Extended Text card page'
    }
    Scenario 0017 '"Assembly Blanket Order" on Extended Text card page for item' {
        Given 'Item with extended text'
        When 'Open Extended Text card page'
        Then '"Assembly Blanket Order" is not set on Extended Text card page' 
    }
    Scenario 0018 '"Assembly Order" on Extended Text card page for item' {
        Given 'Item with extended text'
        When 'Open Extended Text card page'
        Then '"Assembly Order" is not set on Extended Text card page'
    } 
}