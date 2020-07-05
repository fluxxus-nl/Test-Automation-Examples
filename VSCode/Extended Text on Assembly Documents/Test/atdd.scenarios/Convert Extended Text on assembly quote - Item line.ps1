& "./atdd.scenarios/Extended Text on assembly quote - Item line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76452 `
        -CodeunitName 'Extended Text AQ Item Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\Cod76452.ExtendedTextAQItemLineFLX_2.al'