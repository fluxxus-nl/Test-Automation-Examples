codeunit 80469 "LibraryAutoSetPostPeriodFLX"
{
    procedure GetDateValueFromRequestPage(RequestPageXml: Text; FieldName: Text) DateValue: Date;
    var
        RequestPageFieldValue: Text;
    begin
        RequestPageFieldValue := GetValueFromRequestPageXmlAsText(RequestPageXml, FieldName);
        Evaluate(DateValue, RequestPageFieldValue, 9);
    end;

    procedure DeleteAccountingPeriodsFromDate(DateForDeletion: Date);
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        if DateForDeletion <> 0D then
            AccountingPeriod.SetFilter("Starting Date", '>%1', DateForDeletion);
        if AccountingPeriod.IsEmpty() then
            exit;
        AccountingPeriod.DeleteAll();
        Commit();
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

    procedure CreateUserSetupsWithAutomaticUpdatePostingPeriodEnabled(NumberOfUserSetupsToCreate: Integer);
    var
        i: Integer;
    begin
        for i := 1 to NumberOfUserSetupsToCreate do
            CreateUserSetupWithAutomaticPostingPeriod(true);
        Commit();
    end;

    procedure CreateUserSetupsWithAutomaticUpdatePostingPeriodDisabled(NumberOfUserSetupsToCreate: Integer);
    var
        i: Integer;
    begin
        for i := 1 to NumberOfUserSetupsToCreate do
            CreateUserSetupWithAutomaticPostingPeriod(false);
        Commit();
    end;

    procedure CreateFiscalYearForDate(BaseDate: Date);
    var
        CreateFiscalYear: Report "Create Fiscal Year";
        PeriodLength: DateFormula;
    begin
        Evaluate(PeriodLength, '<1M>');

        CreateFiscalYear.UseRequestPage(false);
        CreateFiscalYear.InitializeRequest(12, PeriodLength, GetStartOfYear(BaseDate));
        CreateFiscalYear.HideConfirmationDialog(true);
        CreateFiscalYear.RunModal();
        Commit();
    end;

    procedure GetStartOfYear(BaseDate: Date): Date;
    begin
        exit(CalcDate('<-CY>', BaseDate));
    end;

    procedure FindAccountingPeriodForDate(var AccountingPeriod: Record "Accounting Period"; DateInPeriod: Date) RecordFound: Boolean;
    begin
        exit(AccountingPeriod.Get(LibraryFiscalYear.GetAccountingPeriodDate(DateInPeriod)));
    end;

    procedure GetAccountingPeriodStartForDate(DateInPeriod: Date): Date;
    begin
        exit(LibraryFiscalYear.GetAccountingPeriodDate(DateInPeriod));
    end;

    procedure GetNextAccountingPeriodStartForDate(DateInPeriod: Date): Date;
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        if not FindAccountingPeriodForDate(AccountingPeriod, DateInPeriod) then
            exit;
        FindNextAccountingPeriod(AccountingPeriod);
        exit(AccountingPeriod."Starting Date");
    end;

    procedure GetAccountingPeriodEndForDate(DateInPeriod: Date): Date;
    begin
        exit(GetNextAccountingPeriodStartForDate(DateInPeriod) - 1);
    end;

    procedure GetNextAccountingPeriodEndForDate(DateInPeriod: Date): Date;
    begin
        exit(GetNextAccountingPeriodStartForDate(GetNextAccountingPeriodStartForDate(DateInPeriod)) - 1);
    end;

    procedure FindNextAccountingPeriod(var AccountingPeriod: Record "Accounting Period");
    begin
        if AccountingPeriod.Next() = 0 then
            Assert.AssertRecordNotFound();
    end;

    procedure UnhandledValue(UnexpectedValue: variant; UnexpectedValueCaption: Text);
    begin
        Error(UnexpectedValueErr, UnexpectedValueCaption, UnexpectedValue);
    end;

    procedure CreateTableAndFieldErrorMsg(TableCaption: Text; FieldCaption: Text): Text;
    begin
        exit(StrSubstNo(TableAndFieldErrorTxt, TableCaption, FieldCaption));
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

    var
        LibraryFiscalYear: Codeunit "Library - Fiscal Year";
        Assert: Codeunit Assert;
        UnexpectedValueErr: Label 'Unhandled value for %1: %2', comment = '%1 = the offending value, %2 = the test process in which it occurred.';
        TableAndFieldErrorTxt: Label 'Table %1: Field "%2"', comment = '%1 = table caption, %2 = field caption';
}