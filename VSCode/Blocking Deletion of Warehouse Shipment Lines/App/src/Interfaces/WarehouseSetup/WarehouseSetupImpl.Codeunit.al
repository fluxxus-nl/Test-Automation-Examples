codeunit 75640 "WarehouseSetupImpl" implements IWarehouseSetup
{
    var
        _UnblockDeletionOfShptLineFLX: Boolean;

    procedure Initialize(UnblockDeletionOfShptLineFLX: Boolean)
    begin
        _UnblockDeletionOfShptLineFLX := UnblockDeletionOfShptLineFLX;
    end;

    procedure GetUnblockDeletionOfShptLineFLX(): Boolean;
    begin
        exit(_UnblockDeletionOfShptLineFLX);
    end;
}