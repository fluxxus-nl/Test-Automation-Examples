codeunit 75654 "StubWhseEmpDisallowDelete" implements IWarehouseEmployee
{
    procedure GetAllowedToDeleteShptLineFLX(): Boolean;
    begin
        exit(false);
    end;
}