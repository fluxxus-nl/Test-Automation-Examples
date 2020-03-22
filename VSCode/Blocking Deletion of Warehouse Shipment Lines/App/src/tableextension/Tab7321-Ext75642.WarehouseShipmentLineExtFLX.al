tableextension 75642 "WarehouseShipmentLineExtFLX" extends "Warehouse Shipment Line" //7321
{
    fields
    {
        field(75640; "System-Created"; Boolean)
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
        if "System-Created" then begin
            WarehouseEmployee.Get(UserId(), "Location Code");
            WarehouseEmployee.CheckAllowedToDeleteWhsShipmentLine();
        end;
    end;
}