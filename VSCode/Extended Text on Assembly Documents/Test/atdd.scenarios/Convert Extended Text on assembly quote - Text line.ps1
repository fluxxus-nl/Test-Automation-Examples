& "./atdd.scenarios/Extended Text on assembly quote - Text line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76458 `
        -CodeunitName 'Extended Text AQ Text Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\ExtendedTextAQTextLine_2.Codeunit.al'