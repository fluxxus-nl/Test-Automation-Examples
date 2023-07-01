interface "IFactory"
{
    procedure GetWarehouseSetup(): Interface IWarehouseSetup;
    procedure GetWarehouseShipmentLine(): Interface IWarehouseShipmentLine;
    procedure GetWarehouseEmployee(): Interface IWarehouseEmployee;
    procedure GetWarehouseShipmentLineDeleteUtil(): Interface IWarehouseShipmentLineDeleteUtil;
}