codeunit 80499 "Test Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SetupTestSuite();
    end;

    local procedure SetupTestSuite()
    var
        ALTestSuite: Record "AL Test Suite";
        TestSuiteMgt: Codeunit "Test Suite Mgt.";
        SuiteName: Code[10];
        MyModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(MyModuleInfo);
        SuiteName := 'DEFAULT';

        if ALTestSuite.Get(SuiteName) then
            ALTestSuite.Delete(true);

        TestSuiteMgt.CreateTestSuite(SuiteName);
        ALTestSuite.Get(SuiteName);
        TestSuiteMgt.SelectTestMethodsByExtension(ALTestSuite, MyModuleInfo.id());
    end;
}