& "./atdd.scenarios/AutomaticallySetPostingPeriodOnGLSetup.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 80466 `
        -CodeunitName 'AutoSetPostingPeriodGLSetupFLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\AutoSetPostingPeriodGLSetupFLX.Codeunit_2.al'