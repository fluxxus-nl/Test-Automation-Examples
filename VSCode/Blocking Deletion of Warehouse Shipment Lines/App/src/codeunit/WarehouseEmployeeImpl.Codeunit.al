codeunit 75643 "WarehouseEmployeeImplFLX" implements IWarehouseEmployeeFLX
{
    var
        _AllowedToDeleteShptLine: Boolean;

    procedure Initialize(AllowedToDeleteShptLine: Boolean)
    begin
        _AllowedToDeleteShptLine := AllowedToDeleteShptLine;
    end;


    procedure GetAllowedToDeleteShptLine(): Boolean;
    begin
        exit(_AllowedToDeleteShptLine);
    end;
}