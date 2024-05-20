& "./atdd.scenarios/Extended Text on assembly order - Text line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76457 `
        -CodeunitName 'Extended Text AO Text Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\ExtendedTextAOTextLine_2.Codeunit.al'