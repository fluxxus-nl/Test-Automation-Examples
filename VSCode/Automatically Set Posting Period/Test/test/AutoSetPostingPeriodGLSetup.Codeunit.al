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
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();
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
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();
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

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::AutoSetPostingPeriodGLSetupFLX);
    end;

    local procedure DeleteAllAccountingPeriods();
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        if AccountingPeriod.IsEmpty() then
            exit;
        AccountingPeriod.DeleteAll();
        Commit();
    end;

    local procedure CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate()
    var
        CreateFiscalYear: Report "Create Fiscal Year";
        PeriodLength: DateFormula;
    begin
        Evaluate(PeriodLength, '<1M>');

        CreateFiscalYear.UseRequestPage(false);
        CreateFiscalYear.InitializeRequest(12, PeriodLength, GetStartOfYear(Today));
        CreateFiscalYear.HideConfirmationDialog(true);
        CreateFiscalYear.RunModal();
        Commit();
    end;

    local procedure CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate()
    var
        CreateFiscalYear: Report "Create Fiscal Year";
        PeriodLength: DateFormula;
    begin
        Evaluate(PeriodLength, '<1M>');

        CreateFiscalYear.UseRequestPage(false);
        CreateFiscalYear.InitializeRequest(12, PeriodLength, GetStartOfYear(CalcDate('<+1Y>', Today)));
        CreateFiscalYear.HideConfirmationDialog(true);
        CreateFiscalYear.RunModal();
        Commit();
    end;

    procedure GetStartOfYear(BaseDate: Date): Date;
    begin
        exit(CalcDate('<-CY>', BaseDate));
    end;

    local procedure DisableUseNextPeriodOnRequestPage()
    begin
        LibraryVariableStorage.Enqueue(false);
    end;

    local procedure EnableUseNextPeriodOnRequestPage() RequestPageXml: Text;
    begin
        LibraryVariableStorage.Enqueue(true);
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
        VerifyAllowPostingFromOnGLSetup(LibraryFiscalYear.GetAccountingPeriodDate(Today));
    end;

    local procedure VerifyAllowPostingFromOnGLSetupEqualsFirstDateOfNextAccountingPeriod()
    begin
        VerifyAllowPostingFromOnGLSetup(GetNextAccountingPeriodStartForDate(Today));
    end;

    local procedure VerifyAllowPostingToOnGLSetupEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay()
    begin
        VerifyAllowPostingToOnGLSetup(GetNextAccountingPeriodEndForDate(Today));
    end;

    local procedure VerifyAllowPostingToOnGLSetupEqualsFirstDateOfNextAccountingPeriodMinusOneDay()
    begin
        VerifyAllowPostingToOnGLSetup(GetAccountingPeriodEndForDate(Today));
    end;

    procedure GetNextAccountingPeriodStartForDate(DateInPeriod: Date): Date;
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        if not AccountingPeriod.Get(LibraryFiscalYear.GetAccountingPeriodDate(DateInPeriod)) then
            exit;
        FindNextAccountingPeriod(AccountingPeriod);
        exit(AccountingPeriod."Starting Date");
    end;

    local procedure FindNextAccountingPeriod(var AccountingPeriod: Record "Accounting Period");
    begin
        if AccountingPeriod.Next() = 0 then
            Assert.AssertRecordNotFound();
    end;

    procedure GetAccountingPeriodEndForDate(DateInPeriod: Date): Date;
    begin
        exit(GetNextAccountingPeriodStartForDate(DateInPeriod) - 1);
    end;

    procedure GetNextAccountingPeriodEndForDate(DateInPeriod: Date): Date;
    begin
        exit(GetNextAccountingPeriodStartForDate(GetNextAccountingPeriodStartForDate(DateInPeriod)) - 1);
    end;

    local procedure VerifyAllowPostingFromOnGLSetup(ExpectedDate: Date);
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        Assert.AreEqual(ExpectedDate, GLSetup."Allow Posting From",
            StrSubstNo(TableAndFieldErrorTxt, GLSetup.TableCaption(), GLSetup.FieldCaption("Allow Posting From")));
    end;

    local procedure VerifyAllowPostingToOnGLSetup(ExpectedDate: Date);
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        Assert.AreEqual(ExpectedDate, GLSetup."Allow Posting To",
            StrSubstNo(TableAndFieldErrorTxt, GLSetup.TableCaption(), GLSetup.FieldCaption("Allow Posting To")));
    end;

    var
        Assert: Codeunit Assert;
        LibraryFiscalYear: Codeunit "Library - Fiscal Year";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        IsInitialized: Boolean;
        TableAndFieldErrorTxt: Label 'Table %1: Field "%2"', comment = '%1 = table caption, %2 = field caption';
}