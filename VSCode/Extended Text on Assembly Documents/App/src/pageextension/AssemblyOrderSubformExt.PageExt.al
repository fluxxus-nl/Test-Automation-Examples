pageextension 76400 "Assembly Order Subform Ext FLX" extends "Assembly Order Subform" //901
{
    layout
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                NoOnAfterValidate();
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                NoOnAfterValidate();
            end;
        }
    }

    actions
    {
        addlast("F&unctions")
        {
            action("Insert &Ext. TextsASDFLX")
            {
                AccessByPermission = tabledata "Extended Text Header" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Insert &Ext. Texts';
                Image = Text;
                ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                trigger OnAction()
                begin
                    InsertExtendedText(true);
                end;
            }
        }
    }

    local procedure InsertExtendedText(Unconditionally: Boolean)
    var
        TransferExtendedText: Codeunit "Transfer Extended Text FLX";
    begin
        OnBeforeInsertExtendedText(Rec);
        if TransferExtendedText.AssemblyCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord();
            Commit();
            TransferExtendedText.InsertAssemblyExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            CurrPage.Update(true);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertExtendedText(var AssemblyLine: Record "Assembly Line")
    begin
    end;
}