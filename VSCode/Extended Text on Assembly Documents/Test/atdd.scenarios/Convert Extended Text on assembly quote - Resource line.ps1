& "./atdd.scenarios/Extended Text on assembly quote - Resource line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76455 `
        -CodeunitName 'Extended Text AQ Res. Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\Cod76455.ExtendedTextAQResourceLineFLX_2.al'