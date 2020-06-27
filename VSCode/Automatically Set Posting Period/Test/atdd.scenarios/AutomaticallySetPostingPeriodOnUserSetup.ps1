Feature 'User Setup' {
    Scenario 0006 'Update Four User Setup records with "Automatic Update Posting Period" enabled and "Use Next Period" on Request Page enabled' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        Given 'Four User Setup records with "Automatic Update Posting Period" enabled'
        Given 'Enable "Use Next Period" on Request Page'
        When 'Run batch report'
        Then '"Allow Posting From" on all User Setup records equals first date of current accounting period'
        Then '"Allow Posting to" on all User Setup records equals first date of next accounting period minus one day'
    }

    Scenario 0007 'Update Four User Setup records with "Automatic Update Posting Period" enabled and "Use Next Period" on Request Page disabled' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        Given 'Four User Setup records with "Automatic Update Posting Period" enabled'
        Given 'Disable "Use Next Period" on Request Page'
        When 'Run batch report'
        Then '"Allow Posting From" on all User Setup records equals first date of next accounting period'
        Then '"Allow Posting to" on all User Setup records equals first date of accounting period after next account period minus one day'
    }

    Scenario 0008 'Update Four User Setup records with "Automatic Update Posting Period" disabled' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        Given 'Four User Setup records with "Automatic Update Posting Period" disabled'
        Given 'Enable "Use Next Period" on Request Page'
        When 'Run batch report'
        Then '"Allow Posting From" on all User Setup records is empty'
        Then '"Allow Posting to" on all User Setup records is empty' 
    }

    Scenario 0009 'Update Four User Setup records with " Automatic Update Posting Period" alternatingly enabled and disabled' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        Given 'First User Setup record with "Automatic Update Posting Period" enabled'
        Given 'Second User Setup record with "Automatic Update Posting Period" disabled'
        Given 'Third User Setup record with "Automatic Update Posting Period" enabled'
        Given 'Fourth User Setup record with "Automatic Update Posting Period" disabled'
        Given 'Disable "Use Next Period" on Request Page'
        When 'Run batch report'
        Then '"Allow Posting From" on first and third User Setup records equals first date of current accounting period'
        Then '"Allow Posting to" on first and third User Setup records equals first date of next accounting period minus one day'
        Then '"Allow Posting From" on second and fourth User Setup records is empty'
        Then '"Allow Posting to" on second and fourth User Setup records is empty'
    }

    Scenario 0010 'Check "Automatic Update Posting Period" field exists on User Setup and is editable' {
        Given 'User Setup'
        When 'Opening User Setup page in edit mode'
        Then '"Automatic Update Posting Period" field is editable' 
    }
}   