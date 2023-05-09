codeunit 80466 "AutoSetPostingPeriodGLSetupFLX"
{
    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] G/L Setup
    end;

    [Test]
    procedure UpdateGLSetupWithUseNextPeriodOnRequestPageDisabled()
    // [FEATURE] G/L Setup
    begin
        // [SCENARIO #0004] Update G/L Setup with "Use Next Period" on Request Page disabled

        // [GIVEN] Accounting periods for current fiscal year related to system date
        // [GIVEN] Accounting periods for next fiscal year related to system date
        Initialize();
        // [GIVEN] Disable "Use Next Period" on Request Page
        DisableUseNextPeriodOnRequestPage();

        // [WHEN] Run batch report
        RunBatchReport();

        // [THEN] "Allow Posting From" on G/L Setup equals first date of current accounting period
        VerifyAllowPostingFromOnGLSetupEqualsFirstDateOfCurrentAccountingPeriod();
        // [THEN] "Allow Posting to" on G/L Setup equals first date of next accounting period minus one day
        VerifyAllowPostingToOnGLSetupEqualsFirstDateOfNextAccountingPeriodMinusOneDay();

    end;

    [Test]
    procedure UpdateGLSetupWithUseNextPeriodOnRequestPageEnabled()
    // [FEATURE] G/L Setup
    begin
        // [SCENARIO #0005] Update G/L Setup with "Use Next Period" on Request Page enabled

        // [GIVEN] Accounting periods for current fiscal year related to system date
        // [GIVEN] Accounting periods for next fiscal year related to system date
        Initialize();
        // [GIVEN] Ensable "Use Next Period" on Request Page
        EnableUseNextPeriodOnRequestPage();

        // [WHEN] Run batch report
        RunBatchReport();

        // [THEN] "Allow Posting From" on G/L Setup equals first date of next accounting period
        VerifyAllowPostingFromOnGLSetupEqualsFirstDateOfNextAccountingPeriod();
        // [THEN] "Allow Posting to" on G/L Setup equals first date of accounting period after next account period minus one day
        VerifyAllowPostingToOnGLSetupEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay();
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::AutoSetPostingPeriodGLSetupFLX);

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::AutoSetPostingPeriodGLSetupFLX);
        DeleteAllAccountingPeriods();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::AutoSetPostingPeriodGLSetupFLX);
    end;

    local procedure CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate()
    begin
        LibraryAutoSetPostPeriod.CreateFiscalYearForDate(Today);
    end;

    local procedure CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate()
    begin
        LibraryAutoSetPostPeriod.CreateFiscalYearForDate(CalcDate('<+1Y>', Today));
    end;

    local procedure DisableUseNextPeriodOnRequestPage()
    begin
        LibraryVariableStorage.Enqueue(DoNotUseNextPeriodOnRequestPage());
    end;

    local procedure EnableUseNextPeriodOnRequestPage() RequestPageXml: Text;
    begin
        LibraryVariableStorage.Enqueue(UseNextPeriodOnRequestPage());
    end;

    local procedure RunBatchReport()
    var
        UpdateAllowPosting: Report UpdateAllowPostingFLX;
    begin
        UpdateAllowPosting.SetReportParameters(LibraryVariableStorage.DequeueBoolean());
        UpdateAllowPosting.UseRequestPage := false;
        UpdateAllowPosting.RunModal();
    end;

    local procedure VerifyAllowPostingFromOnGLSetupEqualsFirstDateOfCurrentAccountingPeriod()
    begin
        VerifyAllowPostingFromOnGLSetup(LibraryAutoSetPostPeriod.GetAccountingPeriodStartForDate(Today));
    end;

    local procedure VerifyAllowPostingFromOnGLSetupEqualsFirstDateOfNextAccountingPeriod()
    begin
        VerifyAllowPostingFromOnGLSetup(LibraryAutoSetPostPeriod.GetNextAccountingPeriodStartForDate(Today));
    end;

    local procedure VerifyAllowPostingToOnGLSetupEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay()
    begin
        VerifyAllowPostingToOnGLSetup(LibraryAutoSetPostPeriod.GetNextAccountingPeriodEndForDate(Today));
    end;

    local procedure VerifyAllowPostingToOnGLSetupEqualsFirstDateOfNextAccountingPeriodMinusOneDay()
    begin
        VerifyAllowPostingToOnGLSetup(LibraryAutoSetPostPeriod.GetAccountingPeriodEndForDate(Today));
    end;

    local procedure DeleteAllAccountingPeriods();
    begin
        LibraryAutoSetPostPeriod.DeleteAccountingPeriodsFromDate(0D);
    end;

    local procedure UseNextPeriodOnRequestPage(): Boolean;
    begin
        exit(true);
    end;

    local procedure DoNotUseNextPeriodOnRequestPage(): Boolean;
    begin
        exit(false);
    end;

    local procedure VerifyAllowPostingFromOnGLSetup(ExpectedDate: Date);
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        Assert.AreEqual(ExpectedDate, GLSetup."Allow Posting From",
            LibraryAutoSetPostPeriod.CreateTableAndFieldErrorMsg(GLSetup.TableCaption(), GLSetup.FieldCaption("Allow Posting From")));
    end;

    local procedure VerifyAllowPostingToOnGLSetup(ExpectedDate: Date);
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        Assert.AreEqual(ExpectedDate, GLSetup."Allow Posting To",
            LibraryAutoSetPostPeriod.CreateTableAndFieldErrorMsg(GLSetup.TableCaption(), GLSetup.FieldCaption("Allow Posting To")));
    end;

    var
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibraryAutoSetPostPeriod: Codeunit LibraryAutoSetPostPeriod;
        Assert: Codeunit Assert;
        IsInitialized: Boolean;
}
