codeunit 75656 "StubWhseEmployeeDisAllowDelete" implements IWarehouseEmployee
{
    procedure GetAllowedToDeleteShptLineFLX(): Boolean;
    begin
        exit(true);
    end;
}