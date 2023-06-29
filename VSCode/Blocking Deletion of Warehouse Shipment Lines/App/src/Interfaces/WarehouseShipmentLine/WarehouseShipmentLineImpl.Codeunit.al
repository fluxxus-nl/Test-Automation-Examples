codeunit 75642 "WarehouseShipmentLineImpl" implements IWarehouseShipmentLine
{
    var
        _SystemCreatedFLX: Boolean;

    procedure Initialize(SystemCreatedFLX: Boolean)
    begin
        _SystemCreatedFLX := SystemCreatedFLX;
    end;

    procedure GetSystemCreatedFLX(): Boolean;
    begin
        exit(_SystemCreatedFLX);
    end;

    procedure CheckDeletionAllowed(IFactory: Interface IFactory): Boolean;
    var
        FactoryImplementation: Codeunit FactoryImplementation;
    begin
        if _SystemCreatedFLX then
            exit(FactoryImplementation.GetWarehouseEmployee().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation));
    end;
}