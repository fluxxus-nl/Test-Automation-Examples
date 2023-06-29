codeunit 75643 "WarehouseEmployeeImpl" implements IWarehouseEmployee
{
    var
        _AllowedToDeleteShptLineFLX: Boolean;

    procedure Initialize(AllowedToDeleteShptLineFLX: Boolean)
    begin
        _AllowedToDeleteShptLineFLX := AllowedToDeleteShptLineFLX;
    end;


    procedure GetAllowedToDeleteShptLineFLX(): Boolean;
    begin
        exit(_AllowedToDeleteShptLineFLX);
    end;

    procedure CheckAllowedToDeleteWhsShipmentLine(IFactory: interface IFactory): Boolean
    var
        NotAlllowedToDeleteSystemCreatedLinesErr: Label 'You are not allowed to delete system-created warehouse shipment lines on current location.';
        DeleteThisSystemCreatedLineQst: Label 'Are you sure you want to delete this system-created line?';
    begin
        if not IFactory.GetWarehouseSetup().GetUnblockDeletionOfShptLineFLX() then begin
            if not _AllowedToDeleteShptLineFLX then
                Error(NotAlllowedToDeleteSystemCreatedLinesErr);

            if Confirm(DeleteThisSystemCreatedLineQst, false) = false then
                Error('');
        end;
    end;
}