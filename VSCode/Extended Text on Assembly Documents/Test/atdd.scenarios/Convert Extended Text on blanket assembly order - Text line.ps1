& "./atdd.scenarios/Extended Text on blanket assembly order - Text line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76459 `
        -CodeunitName 'Extend. Text BAO Text Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\ExtendedTextBAOTextLine_2.Codeunit.al'