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
}