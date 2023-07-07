codeunit 75654 "StubWhseEmpAllowDelete" implements IWarehouseEmployee
{
    procedure GetAllowedToDeleteShptLineFLX(): Boolean;
    begin
        exit(false);
    end;
}