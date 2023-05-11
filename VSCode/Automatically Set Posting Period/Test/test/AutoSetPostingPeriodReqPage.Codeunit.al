codeunit 80465 "AutoSetPostingPeriodReqPageFLX"
{
    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Request Page
    end;

    [Test]
    [HandlerFunctions('UpdateAllowPostingRequestPageHandler')]
    procedure SetStartingDateAndEndingDateForCurrentPeriod()
    // [FEATURE] Request Page
    var
        RequestPageXml: Text;
    begin
        // [SCENARIO #0001] Set "Starting Date" and "Ending Date" for current period
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();

        // [WHEN] Disable "Use Next Period" on Request Page
        RequestPageXml := DisableUseNextPeriodOnRequestPage();

        // [THEN] "Current Accounting Period" equals start date of current accounting period
        VerifyCurrentAccountingPeriodEqualsStartDateOfCurrentAccountingPeriod(RequestPageXml);
        // [THEN] "Starting Date" equals first date of current accounting period
        VerifyStartingDateEqualsFirstDateOfCurrentAccountingPeriod(RequestPageXml);
        // [THEN] "Ending Date" equals first date of next accounting period minus one day
        VerifyEndingDateEqualsFirstDateOfNextAccountingPeriodMinusOneDay(RequestPageXml);
    end;

    [Test]
    [HandlerFunctions('UpdateAllowPostingRequestPageHandler')]
    procedure SetStartingDateAndEndingDateForNextPeriod()
    // [FEATURE] Request Page
    var
        RequestPageXml: Text;
    begin
        // [SCENARIO #0002] Set "Starting Date" and "Ending Date" for next period
        Initialize();

        // [GIVEN] Accounting periods for current fiscal year related to system date
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        // [GIVEN] Accounting periods for next fiscal year related to system date
        CreateAccountingPeriodsForNextFiscalYearRelatedToSystemDate();

        // [WHEN] Enable "Use Next Period" on Request Page
        RequestPageXml := EnableUseNextPeriodOnRequestPage();

        // [THEN] "Current Accounting Period" equals start date of current accounting period
        VerifyCurrentAccountingPeriodEqualsStartDateOfCurrentAccountingPeriod(RequestPageXml);
        // [THEN] "Starting Date" equals first date of next accounting period
        VerifyStartingDateEqualsFirstDateOfNextAccountingPeriod(RequestPageXml);
        // [THEN] "Ending Date" equals first date of accounting period after next account period minus one day
        VerifyEndingDateEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay(RequestPageXml);
    end;

    [Test]
    [HandlerFunctions('UpdateAllowPostingRequestPageHandler')]
    procedure SetStartingDateAndEndingDateForNonExistingNextAccountingPeriod()
    // [FEATURE] Request Page
    var
        RequestPageXml: Text;
    begin
        // [SCENARIO #0003] Set "Starting Date" and "Ending Date" for non-existing next accounting period
        Initialize();

        // [GIVEN] No next accounting period related to system date
        CreateNoNextAccountingPeriodRelatedToSystemDate();

        // [WHEN] Open request page
        RequestPageXml := OpenRequestPage();

        // [THEN] Error on non-existing next accounting period
        VerifyErrorOnNonExistingNextAccountingPeriod(RequestPageXml);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::AutoSetPostingPeriodReqPageFLX);

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::AutoSetPostingPeriodReqPageFLX);
        DeleteAllAccountingPeriods();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::AutoSetPostingPeriodReqPageFLX);
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

    local procedure CreateNoNextAccountingPeriodRelatedToSystemDate()
    begin
        CreateAccountingPeriodsForCurrentFiscalYearRelatedToSystemDate();
        DeleteAccountingPeriodsAfterDate(Today);
    end;

    local procedure DeleteAccountingPeriodsAfterDate(BaseDate: Date);
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        if BaseDate <> 0D then
            AccountingPeriod.SetFilter("Starting Date", '>%1', BaseDate);
        if AccountingPeriod.IsEmpty() then
            exit;
        AccountingPeriod.DeleteAll();
        Commit();
    end;

    local procedure DisableUseNextPeriodOnRequestPage(): Text;
    var
        UpdateAllowPosting: Report UpdateAllowPostingFLX;
    begin
        Commit(); //Write transactions happened, so commit
        LibraryVariableStorage.Enqueue(false);
        exit(UpdateAllowPosting.RunRequestPage());
    end;

    local procedure EnableUseNextPeriodOnRequestPage(): Text;
    var
        UpdateAllowPosting: Report UpdateAllowPostingFLX;
    begin
        Commit(); //Write transactions happened, so commit
        LibraryVariableStorage.Enqueue(true);
        exit(UpdateAllowPosting.RunRequestPage());
    end;

    local procedure OpenRequestPage() RequestPageXml: Text;
    var
        UpdateAllowPosting: Report UpdateAllowPostingFLX;
    begin
        LibraryVariableStorage.Enqueue(false);
        asserterror RequestPageXml := UpdateAllowPosting.RunRequestPage();
    end;

    local procedure VerifyCurrentAccountingPeriodEqualsStartDateOfCurrentAccountingPeriod(RequestPageXml: Text)
    var
        RequestPageFieldValue: Text;
        CurrAccPeriodDateOnReqPage: Date;
    begin
        CurrAccPeriodDateOnReqPage := GetDateValueFromRequestPage(RequestPageXml, 'CurrPeriodStartingDate');
        Assert.AreEqual(CurrAccPeriodDateOnReqPage, LibraryFiscalYear.GetAccountingPeriodDate(Today), CurrAccPeriodDateOnReqPageCaptionTxt);
    end;

    local procedure VerifyEndingDateEqualsFirstDateOfAccountingPeriodAfterNextAccountPeriodMinusOneDay(RequestPageXml: Text)
    var
        RequestPageFieldValue: Text;
        PeriodEndDateOnReqPage: Date;
    begin
        PeriodEndDateOnReqPage := GetDateValueFromRequestPage(RequestPageXml, 'PeriodEndingDate');
        Assert.AreEqual(PeriodEndDateOnReqPage,
            GetNextAccountingPeriodEndForDate(Today), PeriodEndingDateOnReqPageCaptionTxt);
    end;

    local procedure VerifyEndingDateEqualsFirstDateOfNextAccountingPeriodMinusOneDay(RequestPageXml: Text)
    var
        RequestPageFieldValue: Text;
        PeriodEndDateOnReqPage: Date;
    begin
        PeriodEndDateOnReqPage := GetDateValueFromRequestPage(RequestPageXml, 'PeriodEndingDate');
        Assert.AreEqual(PeriodEndDateOnReqPage, GetAccountingPeriodEndForDate(Today), PeriodEndingDateOnReqPageCaptionTxt);
    end;

    local procedure VerifyErrorOnNonExistingNextAccountingPeriod(RequestPageXml: Text)
    var
        UpdateAllowPosting: Report UpdateAllowPostingFLX;
    begin
        LibraryVariableStorage.Enqueue(true);
        asserterror RequestPageXml := UpdateAllowPosting.RunRequestPage(RequestPageXml);
    end;

    local procedure VerifyStartingDateEqualsFirstDateOfCurrentAccountingPeriod(RequestPageXml: Text)
    var
        RequestPageFieldValue: Text;
        PeriodStartDateOnReqPage: Date;
    begin
        PeriodStartDateOnReqPage := GetDateValueFromRequestPage(RequestPageXml, 'PeriodStartingDate');
        Assert.AreEqual(PeriodStartDateOnReqPage, LibraryFiscalYear.GetAccountingPeriodDate(Today), PeriodStartingDateOnReqPageCaptionTxt);
    end;

    local procedure VerifyStartingDateEqualsFirstDateOfNextAccountingPeriod(RequestPageXml: Text)
    var
        RequestPageFieldValue: Text;
        PeriodStartDateOnReqPage: Date;
    begin
        PeriodStartDateOnReqPage := GetDateValueFromRequestPage(RequestPageXml, 'PeriodStartingDate');
        Assert.AreEqual(PeriodStartDateOnReqPage, GetNextAccountingPeriodStartForDate(Today), PeriodStartingDateOnReqPageCaptionTxt);
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

    procedure GetDateValueFromRequestPage(RequestPageXml: Text; FieldName: Text) DateValue: Date;
    var
        RequestPageFieldValue: Text;
    begin
        RequestPageFieldValue := GetValueFromRequestPageXmlAsText(RequestPageXml, FieldName);
        Evaluate(DateValue, RequestPageFieldValue, 9);
    end;

    local procedure GetValueFromRequestPageXmlAsText(RequestPageXml: Text; FieldName: Text): Text;
    var
        XmlDoc: XmlDocument;
        XmlSingleNode: XmlNode;
    begin
        XmlDocument.ReadFrom(RequestPageXml, XmlDoc);
        XmlDoc.SelectSingleNode(StrSubstNo('//Field[@name=''%1'']', FieldName), XmlSingleNode);
        exit(XmlSingleNode.AsXmlElement().InnerText());
    end;

    [RequestPageHandler]
    procedure UpdateAllowPostingRequestPageHandler(var UpdateAllowPostingRequestPage: TestRequestPage UpdateAllowPostingFLX);
    begin
        UpdateAllowPostingRequestPage.UseNextPeriod.SetValue(LibraryVariableStorage.DequeueBoolean());
        UpdateAllowPostingRequestPage.Ok.Invoke();
    end;

    var
        Assert: Codeunit Assert;
        LibraryFiscalYear: Codeunit "Library - Fiscal Year";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        IsInitialized: Boolean;
        CurrAccPeriodDateOnReqPageCaptionTxt: Label 'Current Account Period Date';
        PeriodEndingDateOnReqPageCaptionTxt: Label 'Period Ending Date';
        PeriodStartingDateOnReqPageCaptionTxt: Label 'Period Starting Date';
}