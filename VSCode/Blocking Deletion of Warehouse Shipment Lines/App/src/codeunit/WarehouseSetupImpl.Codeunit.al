codeunit 75640 "WarehouseSetupImplFLX" implements IWarehouseSetupFLX
{
    var
        _UnblockDeletionOfShptLine: Boolean;

    procedure Initialize(UnblockDeletionOfShptLine: Boolean)
    begin
        _UnblockDeletionOfShptLine := UnblockDeletionOfShptLine;
    end;

    procedure GetUnblockDeletionOfShptLine(): Boolean;
    begin
        exit(_UnblockDeletionOfShptLine);
    end;
}