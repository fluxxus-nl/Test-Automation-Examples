tableextension 75642 "WarehouseShipmentLine Ext FLX" extends "Warehouse Shipment Line" //7321
{
    fields
    {
        field(75640; "System-Created FLX"; Boolean)
        {
            Caption = 'System-Created';
            DataClassification = ToBeClassified;
        }
    }

    trigger OnBeforeDelete()
    begin
        CheckDeletionAllowed();
    end;

    procedure CheckDeletionAllowed()
    var
        WarehouseEmployee: Record "Warehouse Employee";
    begin
        if "System-Created FLX" then begin
            WarehouseEmployee.Get(UserId(), Rec."Location Code");
            WarehouseEmployee.CheckAllowedToDeleteWhsShipmentLine();
        end;
    end;
}