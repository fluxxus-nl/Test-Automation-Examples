& "./atdd.scenarios/UnblockDeletionShptLineEnabled.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 75650 `
        -CodeunitName 'Unblock Deletion Enabled FLX' `
        -InitializeFunction `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '.\src\codeunit\COD75650.UnblockDeletionEnabledFLX_2.al'