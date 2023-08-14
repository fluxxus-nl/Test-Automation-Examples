codeunit 75642 "WarehouseShipmentLineImplFLX" implements IWarehouseShipmentLineFLX
{
    var
        _SystemCreated: Boolean;

    procedure Initialize(SystemCreated: Boolean)
    begin
        _SystemCreated := SystemCreated;
    end;

    procedure GetSystemCreated(): Boolean;
    begin
        exit(_SystemCreated);
    end;
}