interface "IWarehouseEmployee"
{
    procedure Initialize(AllowedToDeleteShptLineFLX: Boolean);
    procedure GetAllowedToDeleteShptLineFLX(): Boolean;
    procedure CheckAllowedToDeleteWhsShipmentLine(IFactory: Interface IFactory): Boolean;

}