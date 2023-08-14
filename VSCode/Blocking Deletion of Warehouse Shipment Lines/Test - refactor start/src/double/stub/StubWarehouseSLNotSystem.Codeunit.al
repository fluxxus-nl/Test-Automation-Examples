codeunit 75657 "StubWarehouseSLNotSystemFLX" implements IWarehouseShipmentLineFLX
{
    procedure GetSystemCreated(): Boolean;
    begin
        exit(false);
    end;
}