& "./atdd.scenarios/Extended Text on assembly order - Resource line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76454 `
        -CodeunitName 'Extended Text AO Res. Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\ExtendedTextAOResourceLine_2.Codeunit.al'