& "./atdd.scenarios/Extended Text on blanket assembly order - Resource line.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 76456 `
        -CodeunitName 'Extend. Text BAO Res. Line FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\Cod76456.ExtendedTextBAOResourceLineFLX_2.al'