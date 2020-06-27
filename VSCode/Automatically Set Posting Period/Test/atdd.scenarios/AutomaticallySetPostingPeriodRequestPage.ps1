Feature 'Request Page' {
    Scenario 0001 'Set "Starting Date" and "Ending Date" for current period' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        When 'Disable "Use Next Period" on Request Page'
        Then '"Current Accounting Period" equals start date of current accounting period'
        Then '"Starting Date" equals first date of current accounting period'
        Then '"Ending Date" equals first date of next accounting period minus one day'
    }

    Scenario 0002 'Set "Starting Date" and "Ending Date" for next period' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        When 'Enable "Use Next Period" on Request Page'
        Then '"Current Accounting Period" equals start date of current accounting period'
        Then '"Starting Date" equals first date of next accounting period'
        Then '"Ending Date" equals first date of accounting period after next account period minus one day'
    }

    Scenario 0003 'Set "Starting Date" and "Ending Date" for non-existing next accounting period' {
        Given 'No next accounting period related to system date'
        When 'Open request page'
        Then 'Error on non-existing next accounting period'
    }
}    