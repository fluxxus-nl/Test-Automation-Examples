& "./atdd.scenarios/Extended TextSetup.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76450 `
        -CodeunitName 'Extended Text Setup FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\Cod75650.ExtendedTextSetupFLX_2.al'