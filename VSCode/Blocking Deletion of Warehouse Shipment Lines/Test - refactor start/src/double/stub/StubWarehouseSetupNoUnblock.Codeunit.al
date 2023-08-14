codeunit 75652 "StubWarehouseSetupNoUnblockFLX" implements IWarehouseSetupFLX
{
    procedure GetUnblockDeletionOfShptLine(): Boolean;
    begin
        exit(false);
    end;
}