codeunit 75656 "StubWhseEmpAllowDeleteFLX" implements IWarehouseEmployeeFLX
{
    procedure GetAllowedToDeleteShptLine(): Boolean;
    begin
        exit(true);
    end;
}