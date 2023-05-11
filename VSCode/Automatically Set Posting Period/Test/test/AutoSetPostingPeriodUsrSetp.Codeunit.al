codeunit 80467 "AutoSetPostingPeriodUsrSetpFLX"
{
    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] User Setup
    end;

    [Test]
    procedure UpdateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodEnabledAndUseNextPeriodOnRequestPageEnabled()
    // [FEATURE] User Setup
    begin
        // [SCENARIO #0006] Update Four User Setup records with "Automatic Update Posting Period" enabled and "Use Next Period" on Request Page enabled
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();
        // [GIVEN] Four User Setup records with "Automatic Update Posting Period" enabled
        CreateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodEnabled();
        // [GIVEN] Enable "Use Next Period" on Request Page
        EnableUseNextPeriodOnRequestPage();

        // [WHEN] Run batch report
        RunBatchReport();

        // [THEN] "Allow Posting From" on all User Setup records equals first date of current accounting period
        VerifyAllowPostingFromOnAllUserSetupRecordsEqualsFirstDateOfNextAccountingPeriod();
        // [THEN] "Allow Posting to"  on all User Setup records equals first date of next accounting period minus one day
        VerifyAllowPostingToOnAllUserSetupRecordsEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay();
    end;

    [Test]
    procedure UpdateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodEnabledAndUseNextPeriodOnRequestPageDisabled()
    // [FEATURE] User Setup
    begin
        // [SCENARIO #0007] Update Four User Setup records with "Automatic Update Posting Period" enabled and "Use Next Period" on Request Page disabled
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();
        // [GIVEN] Four User Setup records with "Automatic Update Posting Period" enabled
        CreateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodEnabled();
        // [GIVEN] Disable "Use Next Period" on Request Page
        DisableUseNextPeriodOnRequestPage();

        // [WHEN] Run batch report
        RunBatchReport();

        // [THEN] "Allow Posting From" on all User Setup records equals first date of next accounting period
        VerifyAllowPostingFromOnAllUserSetupRecordsEqualsFirstDateOfCurrentAccountingPeriod();
        // [THEN] "Allow Posting to" on all User Setup records equals first date of accounting period after next account period minus one day
        VerifyAllowPostingToOnAllUserSetupRecordsEqualsFirstDateOfNextAccountingPeriodMinusOneDay()
    end;

    [Test]
    procedure UpdateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodDisabled()
    // [FEATURE] User Setup
    begin
        // [SCENARIO #0008] Update Four User Setup records with "Automatic Update Posting Period" disabled
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();
        // [GIVEN] Four User Setup records with "Automatic Update Posting Period" disabled
        CreateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodDisabled();
        // [GIVEN] Enable "Use Next Period" on Request Page
        EnableUseNextPeriodOnRequestPage();

        // [WHEN] Run batch report
        RunBatchReport();

        // [THEN] "Allow Posting From" on all User Setup records is empty
        VerifyAllowPostingFromOnAllUserSetupRecordsIsEmpty();
        // [THEN] "Allow Posting to" on all User Setup records is empty
        VerifyAllowPostingToOnAllUserSetupRecordsIsEmpty();
    end;

    [Test]
    procedure UpdateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodAlternatinglyEnabledAndDisabled()
    // [FEATURE] User Setup
    begin
        // [SCENARIO #0009] Update Four User Setup records with " Automatic Update Posting Period" alternatingly enabled and disabled
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();
        // [GIVEN] First User Setup record with "Automatic Update Posting Period" enabled
        CreateFirstUserSetupRecordWithAutomaticUpdatePostingPeriodEnabled();
        // [GIVEN] Second User Setup record with "Automatic Update Posting Period" disabled
        CreateSecondUserSetupRecordWithAutomaticUpdatePostingPeriodDisabled();
        // [GIVEN] Third User Setup record with "Automatic Update Posting Period" enabled
        CreateThirdUserSetupRecordWithAutomaticUpdatePostingPeriodEnabled();
        // [GIVEN] Fourth User Setup record with "Automatic Update Posting Period" disabled
        CreateFourthUserSetupRecordWithAutomaticUpdatePostingPeriodDisabled();
        // [GIVEN] Disable "Use Next Period" on Request Page
        DisableUseNextPeriodOnRequestPage();

        // [WHEN] Run batch report
        RunBatchReport();

        // [THEN] "Allow Posting From" on first and third User Setup records equals first date  of current accounting period
        VerifyAllowPostingFromOnFirstAndThirdUserSetupRecordsEqualsFirstDateOfCurrentAccountingPeriod();
        // [THEN] "Allow Posting to"  on first and third User Setup records equals first date of next accounting period minus one day
        VerifyAllowPostingToOnFirstAndThirdUserSetupRecordsEqualsFirstDateOfNextAccountingPeriodMinusOneDay();
        // [THEN] "Allow Posting From" on second and fourth User Setup records is empty
        VerifyAllowPostingFromOnSecondAndFourthUserSetupRecordsIsEmpty();
        // [THEN] "Allow Posting to" on second and fourth User Setup records is empty
        VerifyAllowPostingToOnSecondAndFourthUserSetupRecordsIsEmpty();
    end;

    [Test]
    procedure CheckAutomaticUpdatePostingPeriodFieldExistsOnUserSetupAndIsEditable()
    // [FEATURE] User Setup
    var
        UserSetup: TestPage "User Setup";
    begin
        // [SCENARIO #0010] Check "Automatic Update Posting Period" field exists on User Setup and is editable
        Initialize();

        // [GIVEN] User Setup
        CreateUserSetup();

        // [WHEN] Opening User Setup page in edit mode
        OpeningUserSetupPageInEditMode(UserSetup);

        // [THEN] "Automatic Update Posting Period" field is editable
        VerifyAutomaticUpdatePostingPeriodFieldIsEditable(UserSetup);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::AutoSetPostingPeriodUsrSetpFLX);

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::AutoSetPostingPeriodUsrSetpFLX);
        DeleteAllAccountingPeriods();
        DeleteUserSetups();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::AutoSetPostingPeriodUsrSetpFLX);
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

    local procedure DeleteUserSetups();
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.DeleteAll();
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

    local procedure CreateFirstUserSetupRecordWithAutomaticUpdatePostingPeriodEnabled()
    begin
        CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(1);
    end;

    local procedure CreateSecondUserSetupRecordWithAutomaticUpdatePostingPeriodDisabled()
    begin
        CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(1);
    end;

    local procedure CreateThirdUserSetupRecordWithAutomaticUpdatePostingPeriodEnabled()
    begin
        CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(1);
    end;

    local procedure CreateFourthUserSetupRecordWithAutomaticUpdatePostingPeriodDisabled()
    begin
        CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(1);
    end;

    local procedure CreateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodDisabled()
    begin
        CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(4);
    end;

    local procedure CreateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodEnabled()
    begin
        CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(4);
    end;

    local procedure CreateUserSetup()
    begin
        CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(1);
    end;

    procedure CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(NumberOfUserSetupsToCreate: Integer);
    var
        i: Integer;
    begin
        for i := 1 to NumberOfUserSetupsToCreate do
            CreateUserSetupWithAutomaticPostingPeriod(false);
        Commit();
    end;

    procedure CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(NumberOfUserSetupsToCreate: Integer);
    var
        i: Integer;
    begin
        for i := 1 to NumberOfUserSetupsToCreate do
            CreateUserSetupWithAutomaticPostingPeriod(true);
        Commit();
    end;

    local procedure CreateUserSetupWithAutomaticPostingPeriod(AutomaticUpdatePostingPeriod: Boolean);
    var
        UserSetup: Record "User Setup";
        LibraryRandom: Codeunit "Library - Random";
    begin
        UserSetup.Init();
        UserSetup."User ID" := LibraryRandom.RandText(MaxStrLen(UserSetup."User ID"));
        UserSetup."Autom. Update Posting Period" := AutomaticUpdatePostingPeriod;
        UserSetup.Insert();
    end;

    local procedure OpeningUserSetupPageInEditMode(var UserSetup: TestPage "User Setup")
    begin
        UserSetup.OpenEdit();
    end;

    local procedure RunBatchReport()
    var
        UpdateAllowPosting: Report UpdateAllowPostingFLX;
    begin
        UpdateAllowPosting.SetReportParameters(LibraryVariableStorage.DequeueBoolean());
        UpdateAllowPosting.UseRequestPage := false;
        UpdateAllowPosting.RunModal();
    end;

    local procedure VerifyAllowPostingFromOnAllUserSetupRecordsIsEmpty()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.SetRange("Autom. Update Posting Period", false);
        Assert.RecordCount(UserSetup, 4);
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(0D, false);
    end;

    local procedure VerifyAllowPostingFromOnAllUserSetupRecordsEqualsFirstDateOfCurrentAccountingPeriod()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(LibraryFiscalYear.GetAccountingPeriodDate(Today), true);
    end;

    local procedure VerifyAllowPostingFromOnAllUserSetupRecordsEqualsFirstDateOfNextAccountingPeriod()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(GetNextAccountingPeriodStartForDate(Today), true);
    end;

    local procedure VerifyAllowPostingFromOnFirstAndThirdUserSetupRecordsEqualsFirstDateOfCurrentAccountingPeriod()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(LibraryFiscalYear.GetAccountingPeriodDate(Today), true);
    end;

    local procedure VerifyAllowPostingToOnFirstAndThirdUserSetupRecordsEqualsFirstDateOfNextAccountingPeriodMinusOneDay()
    begin
        CheckIfAllowPostingToDateAndAutomaticUpdateSettingOnUserSetup(GetAccountingPeriodEndForDate(Today), true);
    end;

    local procedure VerifyAllowPostingFromOnSecondAndFourthUserSetupRecordsIsEmpty()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(0D, false);
    end;

    local procedure VerifyAllowPostingToOnSecondAndFourthUserSetupRecordsIsEmpty()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(0D, false);
    end;

    local procedure VerifyAllowPostingToOnAllUserSetupRecordsIsEmpty()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(0D, false);
    end;

    local procedure VerifyAllowPostingToOnAllUserSetupRecordsEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay()
    begin
        CheckIfAllowPostingToDateAndAutomaticUpdateSettingOnUserSetup(GetNextAccountingPeriodEndForDate(Today), true);
    end;

    local procedure VerifyAllowPostingToOnAllUserSetupRecordsEqualsFirstDateOfNextAccountingPeriodMinusOneDay()
    begin
        CheckIfAllowPostingToDateAndAutomaticUpdateSettingOnUserSetup(GetAccountingPeriodEndForDate(Today), true);
    end;

    local procedure VerifyAutomaticUpdatePostingPeriodFieldIsEditable(var UserSetup: TestPage "User Setup")
    var
        UserSetupRec: Record "User Setup";
    begin
        Assert.IsTrue(UserSetup."Autom. Update Posting Period".Editable(),
            StrSubstNo(TableAndFieldErrorTxt, UserSetup.Caption(), UserSetupRec.FieldCaption("Autom. Update Posting Period")));
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

    local procedure CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(ExpectedDate: Date; ExpectedAutomaticUpdateSetting: Boolean);
    var
        UserSetup: Record "User Setup";
    begin
        CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetup(ExpectedDate, UserSetup.FieldNo("Allow Posting From"), ExpectedAutomaticUpdateSetting);
    end;

    local procedure CheckIfAllowPostingToDateAndAutomaticUpdateSettingOnUserSetup(ExpectedDate: Date; ExpectedAutomaticUpdateSetting: Boolean);
    var
        UserSetup: Record "User Setup";
    begin
        CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetup(ExpectedDate, UserSetup.FieldNo("Allow Posting To"), ExpectedAutomaticUpdateSetting);
    end;

    local procedure CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetup(ExpectedDate: Date; FieldNoToCheck: Integer; ExpectedAutomaticUpdateSetting: Boolean);
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.SetRange("Autom. Update Posting Period", ExpectedAutomaticUpdateSetting);
        if UserSetup.FindSet() then
            repeat
                case FieldNoToCheck of
                    UserSetup.FieldNo("Allow Posting From"):
                        Assert.AreEqual(ExpectedDate, UserSetup."Allow Posting From",
                            StrSubstNo(TableAndFieldErrorTxt, UserSetup.TableCaption(), UserSetup.FieldCaption("Allow Posting From")));
                    UserSetup.FieldNo("Allow Posting To"):
                        Assert.AreEqual(ExpectedDate, UserSetup."Allow Posting To",
                            StrSubstNo(TableAndFieldErrorTxt, UserSetup.TableCaption(), UserSetup.FieldCaption("Allow Posting To")));
                    else
                        UnhandledValue(FieldNoToCheck, CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetupTxt);
                end;
            until UserSetup.Next() = 0;
    end;

    procedure UnhandledValue(UnexpectedValue: variant; UnexpectedValueCaption: Text);
    begin
        Error(UnexpectedValueErr, UnexpectedValueCaption, UnexpectedValue);
    end;

    var
        Assert: Codeunit Assert;
        LibraryFiscalYear: Codeunit "Library - Fiscal Year";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        IsInitialized: Boolean;
        CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetupTxt: Label 'CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetup', Locked = true;
        UnexpectedValueErr: Label 'Unhandled value for %1: %2', comment = '%1 = the offending value, %2 = the test process in which it occurred.';
        TableAndFieldErrorTxt: Label 'Table %1: Field "%2"', comment = '%1 = table caption, %2 = field caption';
}
