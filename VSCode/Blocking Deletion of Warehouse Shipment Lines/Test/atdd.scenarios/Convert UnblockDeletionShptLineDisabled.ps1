& "./atdd.scenarios/UnblockDeletionShptLineDisabled.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 75651 `
        -CodeunitName 'Unblock Deletion Disabled FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\COD75651.UnblockDeletionDisabledFLX_2.al'