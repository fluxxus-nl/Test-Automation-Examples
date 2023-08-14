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
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        WarehouseShipmentLine: Codeunit WarehouseShipmentLineImplFLX;
        WarehouseEmployeeIMpl: Codeunit WarehouseEmployeeImplFLX;
    begin
        if "System-Created FLX" then begin
            WarehouseEmployee.Get(UserId(), Rec."Location Code");
            FactoryImplementation.SetWarehouseEmployee(WarehouseEmployeeIMpl);
            WarehouseEmployeeIMpl.Initialize(WarehouseEmployee."Allowed to Delete Shpt. Line FLX");

            FactoryImplementation.SetWarehouseShipmentLine(WarehouseShipmentLine);
            WarehouseShipmentLine.Initialize(Rec."System-Created FLX");
            FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);
        end;
    end;
}