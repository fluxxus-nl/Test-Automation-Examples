codeunit 75653 "StubWhsSetupHasUnblockFLX" implements IWarehouseSetupFLX
{
    procedure GetUnblockDeletionOfShptLine(): Boolean;
    begin
        exit(true);
    end;
}