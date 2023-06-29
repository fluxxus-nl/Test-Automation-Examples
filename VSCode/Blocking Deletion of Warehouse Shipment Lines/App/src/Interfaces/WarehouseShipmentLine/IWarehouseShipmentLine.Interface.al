interface "IWarehouseShipmentLine"
{
    procedure Initialize(SystemCreatedFLX: Boolean);
    procedure GetSystemCreatedFLX(): Boolean;
    procedure CheckDeletionAllowed(IFactory: Interface IFactory): Boolean;
}