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
        FactoryImplementation: Codeunit FactoryImplementation;
        IWarehouseShipmentLine: Interface IWarehouseShipmentLine;
        IWarehouseEmployee: Interface IWarehouseEmployee;
    begin
        if "System-Created FLX" then begin
            WarehouseEmployee.Get(UserId(), Rec."Location Code");
            IWarehouseEmployee := FactoryImplementation.GetWarehouseEmployee();
            IWarehouseEmployee.Initialize(WarehouseEmployee."Allowed to Delete Shpt. Line FLX");

            IWarehouseShipmentLine := FactoryImplementation.GetWarehouseShipmentLine();
            IWarehouseShipmentLine.Initialize(Rec."System-Created FLX");
            IWarehouseShipmentLine.CheckDeletionAllowed(FactoryImplementation);
        end;
    end;
}