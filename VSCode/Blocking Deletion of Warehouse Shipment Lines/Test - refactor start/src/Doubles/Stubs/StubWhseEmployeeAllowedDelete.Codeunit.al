codeunit 75656 "StubWhseEmployeeAllowedDelete" implements IWarehouseEmployee
{
    procedure GetAllowedToDeleteShptLineFLX(): Boolean;
    begin
        exit(true);
    end;
}