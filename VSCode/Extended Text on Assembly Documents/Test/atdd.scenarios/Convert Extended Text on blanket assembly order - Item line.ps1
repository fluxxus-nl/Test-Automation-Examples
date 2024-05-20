& "./atdd.scenarios/Extended Text on assembly blanket order - Item line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76453 `
        -CodeunitName 'Extend. Text BAO Item Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\ExtendedTextBAOItemLine_2.Codeunit.al'