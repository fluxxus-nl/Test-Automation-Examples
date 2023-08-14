codeunit 75654 "StubWhseEmplDisAllowDeleteFLX" implements IWarehouseEmployeeFLX
{
    procedure GetAllowedToDeleteShptLine(): Boolean;
    begin
        exit(false);
    end;
}