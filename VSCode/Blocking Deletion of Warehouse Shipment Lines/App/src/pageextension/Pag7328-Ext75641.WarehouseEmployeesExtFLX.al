pageextension 75641 "WarehouseEmployeesExtFLX" extends "Warehouse Employees" //7328
{
    layout
    {
        addlast(Control1)
        {
            field("Allowed to Delete Shpt. Line"; "Allowed to Delete Shpt. Line")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether you allow this user to delete system-created warehouse shipment lines on the location selected when Unblock Deletion of Whse. Shpt. Line on Warehouse Setup has been enabled.';
                Editable = AllowToDeleteShptLineEditable;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AllowToDeleteShptLineEditable := DeletionOfShptLineIsBlocked();
    end;

    local procedure DeletionOfShptLineIsBlocked(): Boolean
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        WarehouseSetup.Get();
        exit(WarehouseSetup."Unblock Deletion of Shpt. Line");
    end;

    var
        AllowToDeleteShptLineEditable: Boolean;
}