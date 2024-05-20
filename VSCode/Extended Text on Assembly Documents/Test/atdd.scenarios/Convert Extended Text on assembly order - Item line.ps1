& "./atdd.scenarios/Extended Text on assembly order - Item line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76451 `
        -CodeunitName 'Extended Text AO Item Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\ExtendedTextAOItemLine_2.Codeunit.al'