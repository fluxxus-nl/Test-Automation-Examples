& "./atdd.scenarios/Extended Text on assembly order - Item line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76451 `
        -CodeunitName 'Extended Text AO Item Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\Cod76451.ExtendedTextAOItemLineFLX_2.al'