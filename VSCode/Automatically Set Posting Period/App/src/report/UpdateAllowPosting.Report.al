report 80640 UpdateAllowPostingFLX
{
    Caption = 'Update Allow Posting';
    UsageCategory = Tasks;
    ApplicationArea = All;
    Permissions = TableData 91 = rm, TableData 98 = rm;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Settings)
                {
                    field(UseNextPeriod; UseNextPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Use Next Period';

                        trigger OnValidate();
                        begin
                            SetPeriodDates();
                        end;
                    }
                }
                group(PeriodDetails)
                {
                    Editable = false;
                    field(PeriodStartingDate; PeriodStartingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Period Starting Date';
                    }
                    field(PeriodEndingDate; PeriodEndingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Period Ending Date';
                    }
                    field(CurrPeriodStartingDate; CurrPeriodStartingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Current Period Start Date';
                    }
                }
            }
        }

        trigger OnOpenPage();
        begin
            SetFieldValues();
        end;
    }

    trigger OnPreReport();
    begin
        UpdateAllowPostingOnGLSetup();
        UpdateAllowPostingOnUserSetup();
    end;

    procedure SetReportParameters(NewUseNextPeriod: Boolean);
    begin
        UseNextPeriod := NewUseNextPeriod;
        SetCurrPeriodStartingDate();
        SetPeriodDates();
    end;

    local procedure SetFieldValues();
    begin
        SetCurrPeriodStartingDate();
        SetPeriodDates();
    end;

    local procedure SetCurrPeriodStartingDate();
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.SetFilter("Starting Date", '<=%1', Today);
        if not AccountingPeriod.FindLast() then
            Error(NoAccountingPeriodsSetUpErr);
        CurrPeriodStartingDate := AccountingPeriod."Starting Date";
    end;

    local procedure SetPeriodDates();
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.Get(CurrPeriodStartingDate);
        if UseNextPeriod then
            FindNextAccountingPeriod(AccountingPeriod);

        PeriodStartingDate := AccountingPeriod."Starting Date";
        FindNextAccountingPeriod(AccountingPeriod);
        PeriodEndingDate := AccountingPeriod."Starting Date" - 1;
    end;

    local procedure FindNextAccountingPeriod(var AccountingPeriod: Record "Accounting Period");
    begin
        if AccountingPeriod.Next() = 0 then
            Error(NoAccountingPeriodsSetUpErr);
    end;

    local procedure UpdateAllowPostingOnGLSetup();
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        GLSetup."Allow Posting To" := PeriodEndingDate;
        GLSetup."Allow Posting From" := PeriodStartingDate;
        GLSetup.Modify();
    end;

    local procedure UpdateAllowPostingOnUserSetup();
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.SetRange("Autom. Update Posting Period", true);
        if UserSetup.IsEmpty() then
            exit;
        UserSetup.ModifyAll("Allow Posting To", PeriodEndingDate);
        UserSetup.ModifyAll("Allow Posting From", PeriodStartingDate);
    end;

    var
        UseNextPeriod: Boolean;
        PeriodStartingDate: Date;
        PeriodEndingDate: Date;
        CurrPeriodStartingDate: Date;
        NoAccountingPeriodsSetUpErr: Label 'No accounting periods have been set up to cover the requested period.';
}