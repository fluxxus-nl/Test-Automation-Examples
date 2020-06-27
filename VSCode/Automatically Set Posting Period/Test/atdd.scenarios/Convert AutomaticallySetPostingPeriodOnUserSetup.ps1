& "./atdd.scenarios/AutomaticallySetPostingPeriodOnUserSetup.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 80467 `
        -CodeunitName 'AutoSetPostingPeriodUsrSetpFLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\AutoSetPostingPeriodUsrSetpFLX.Codeunit_2.al'