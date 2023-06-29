codeunit 75652 "StubWarehouseSetupNoUnblock" implements IWarehouseSetup
{


    procedure GetUnblockDeletionOfShptLineFLX(): Boolean;
    begin
        exit(false);
    end;
}