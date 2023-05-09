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

        // [GIVEN] Accounting periods for current fiscal year related to system date
        // [GIVEN] Accounting periods for next fiscal year related to system date
        Initialize();
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

        // [GIVEN] Accounting periods for current fiscal year related to system date
        // [GIVEN] Accounting periods for next fiscal year related to system date
        Initialize();
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

        // [GIVEN] Accounting periods for current fiscal year related to system date
        // [GIVEN] Accounting periods for next fiscal year related to system date
        Initialize();
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

        // [GIVEN] Accounting periods for current fiscal year related to system date
        // [GIVEN] Accounting periods for next fiscal year related to system date
        Initialize();
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

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::AutoSetPostingPeriodUsrSetpFLX);
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

    local procedure CreateFirstUserSetupRecordWithAutomaticUpdatePostingPeriodEnabled()
    begin
        LibraryAutoSetPostPeriod.CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(1);
    end;

    local procedure CreateSecondUserSetupRecordWithAutomaticUpdatePostingPeriodDisabled()
    begin
        LibraryAutoSetPostPeriod.CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(1);
    end;

    local procedure CreateThirdUserSetupRecordWithAutomaticUpdatePostingPeriodEnabled()
    begin
        LibraryAutoSetPostPeriod.CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(1);
    end;

    local procedure CreateFourthUserSetupRecordWithAutomaticUpdatePostingPeriodDisabled()
    begin
        LibraryAutoSetPostPeriod.CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(1);
    end;

    local procedure CreateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodDisabled()
    begin
        LibraryAutoSetPostPeriod.CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(4);
    end;

    local procedure CreateFourUserSetupRecordsWithAutomaticUpdatePostingPeriodEnabled()
    begin
        LibraryAutoSetPostPeriod.CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(4);
    end;

    local procedure CreateUserSetup()
    begin
        LibraryAutoSetPostPeriod.CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(1);
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
        UserSetup.SetRange("Autom. Update Posting Period", AutomaticUpdateDisabled());
        Assert.RecordCount(UserSetup, 4);
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(BlankDate(), AutomaticUpdateDisabled());
    end;

    local procedure VerifyAllowPostingFromOnAllUserSetupRecordsEqualsFirstDateOfCurrentAccountingPeriod()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(LibraryAutoSetPostPeriod.GetAccountingPeriodStartForDate(Today), AutomaticUpdateEnabled());
    end;

    local procedure VerifyAllowPostingFromOnAllUserSetupRecordsEqualsFirstDateOfNextAccountingPeriod()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(LibraryAutoSetPostPeriod.GetNextAccountingPeriodStartForDate(Today), AutomaticUpdateEnabled());
    end;

    local procedure VerifyAllowPostingFromOnFirstAndThirdUserSetupRecordsEqualsFirstDateOfCurrentAccountingPeriod()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(LibraryAutoSetPostPeriod.GetAccountingPeriodStartForDate(Today), AutomaticUpdateEnabled());
    end;

    local procedure VerifyAllowPostingToOnFirstAndThirdUserSetupRecordsEqualsFirstDateOfNextAccountingPeriodMinusOneDay()
    begin
        CheckIfAllowPostingToDateAndAutomaticUpdateSettingOnUserSetup(LibraryAutoSetPostPeriod.GetAccountingPeriodEndForDate(Today), AutomaticUpdateEnabled());
    end;

    local procedure VerifyAllowPostingFromOnSecondAndFourthUserSetupRecordsIsEmpty()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(BlankDate(), AutomaticUpdateDisabled());
    end;

    local procedure VerifyAllowPostingToOnSecondAndFourthUserSetupRecordsIsEmpty()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(BlankDate(), AutomaticUpdateDisabled());
    end;

    local procedure VerifyAllowPostingToOnAllUserSetupRecordsIsEmpty()
    begin
        CheckIfAllowPostingFromDateAndAutomaticUpdateSettingOnUserSetup(BlankDate(), AutomaticUpdateDisabled());
    end;

    local procedure VerifyAllowPostingToOnAllUserSetupRecordsEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay()
    begin
        CheckIfAllowPostingToDateAndAutomaticUpdateSettingOnUserSetup(LibraryAutoSetPostPeriod.GetNextAccountingPeriodEndForDate(Today), AutomaticUpdateEnabled());
    end;

    local procedure VerifyAllowPostingToOnAllUserSetupRecordsEqualsFirstDateOfNextAccountingPeriodMinusOneDay()
    begin
        CheckIfAllowPostingToDateAndAutomaticUpdateSettingOnUserSetup(LibraryAutoSetPostPeriod.GetAccountingPeriodEndForDate(Today), AutomaticUpdateEnabled());
    end;

    local procedure VerifyAutomaticUpdatePostingPeriodFieldIsEditable(var UserSetup: TestPage "User Setup")
    var
        UserSetupRec: Record "User Setup";
    begin
        Assert.IsTrue(UserSetup."Autom. Update Posting Period".Editable(),
            LibraryAutoSetPostPeriod.CreateTableAndFieldErrorMsg(UserSetup.Caption(), UserSetupRec.FieldCaption("Autom. Update Posting Period")));
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

    local procedure AutomaticUpdateEnabled(): Boolean;
    begin
        exit(true);
    end;

    local procedure AutomaticUpdateDisabled(): Boolean;
    begin
        exit(false);
    end;

    local procedure BlankDate(): Date;
    begin
        exit(0D);
    end;

    local procedure DeleteUserSetups();
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.DeleteAll();
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
                            LibraryAutoSetPostPeriod.CreateTableAndFieldErrorMsg(UserSetup.TableCaption(), UserSetup.FieldCaption("Allow Posting From")));
                    UserSetup.FieldNo("Allow Posting To"):
                        Assert.AreEqual(ExpectedDate, UserSetup."Allow Posting To",
                            LibraryAutoSetPostPeriod.CreateTableAndFieldErrorMsg(UserSetup.TableCaption(), UserSetup.FieldCaption("Allow Posting To")));
                    else
                        LibraryAutoSetPostPeriod.UnhandledValue(FieldNoToCheck, CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetupTxt);
                end;
            until UserSetup.Next() = 0;
    end;

    var
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibraryAutoSetPostPeriod: Codeunit LibraryAutoSetPostPeriod;
        Assert: Codeunit Assert;
        IsInitialized: Boolean;
        CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetupTxt: Label 'CheckIfAllowPostingDateAndAutomaticUpdateSettingOnUserSetup', Locked = true;
}
