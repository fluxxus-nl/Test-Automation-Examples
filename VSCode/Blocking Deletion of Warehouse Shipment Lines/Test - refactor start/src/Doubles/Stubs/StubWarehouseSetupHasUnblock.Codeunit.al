codeunit 75653 "StubWarehouseSetupHasUnblock" implements IWarehouseSetup
{


    procedure GetUnblockDeletionOfShptLineFLX(): Boolean;
    begin
        exit(true);
    end;
}