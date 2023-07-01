codeunit 75643 "WarehouseEmployeeImpl" implements IWarehouseEmployee
{
    var
        _AllowedToDeleteShptLineFLX: Boolean;

    procedure Initialize(AllowedToDeleteShptLineFLX: Boolean)
    begin
        _AllowedToDeleteShptLineFLX := AllowedToDeleteShptLineFLX;
    end;


    procedure GetAllowedToDeleteShptLineFLX(): Boolean;
    begin
        exit(_AllowedToDeleteShptLineFLX);
    end;
}