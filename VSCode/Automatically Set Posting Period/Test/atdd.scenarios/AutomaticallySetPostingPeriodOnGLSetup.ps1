Feature 'G/L Setup' {
    Scenario 0004 'Update G/L Setup with "Use Next Period" on Request Page disabled' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        Given 'Disable "Use Next Period" on Request Page'
        When 'Run batch report'
        Then '"Allow Posting From" on G/L Setup equals first date of current accounting period'
        Then '"Allow Posting to" on G/L Setup equals first date of next accounting period minus one day'
    }

    Scenario 0005 'Update G/L Setup with "Use Next Period" on Request Page enabled' {
        Given 'Accounting periods for current fiscal year related to system date'
        Given 'Accounting periods for next fiscal year related to system date'
        Given 'Enable "Use Next Period" on Request Page'
        When 'Run batch report'
        Then '"Allow Posting From" on G/L Setup equals first date of next accounting period'
        Then '"Allow Posting to" on G/L Setup equals first date of accounting period after next account period minus one day'
    }
}