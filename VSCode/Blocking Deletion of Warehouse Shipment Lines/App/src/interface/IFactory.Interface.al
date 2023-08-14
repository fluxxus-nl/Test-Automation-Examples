interface "IFactoryFLX"
{
    procedure GetWarehouseSetup(): Interface IWarehouseSetupFLX;
    procedure GetWarehouseShipmentLine(): Interface IWarehouseShipmentLineFLX;
    procedure GetWarehouseEmployee(): Interface IWarehouseEmployeeFLX;
    procedure GetWarehouseShipmentLineDeleteUtil(): Interface IWarehouseShipmentLineDeleteUtilFLX;
}