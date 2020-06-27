& "./atdd.scenarios/AutomaticallySetPostingPeriodRequestPage.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 80465 `
        -CodeunitName 'AutoSetPostingPeriodReqPageFLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\AutoSetPostingPeriodReqPageFLX.Codeunit_2.al'