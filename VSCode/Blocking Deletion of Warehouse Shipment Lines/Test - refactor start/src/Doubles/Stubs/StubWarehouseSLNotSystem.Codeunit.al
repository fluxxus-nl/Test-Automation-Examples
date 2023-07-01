codeunit 75657 "StubWarehouseSLNotSystem" implements IWarehouseShipmentLine
{


    procedure GetSystemCreatedFLX(): Boolean;
    begin
        exit(false);
    end;
}