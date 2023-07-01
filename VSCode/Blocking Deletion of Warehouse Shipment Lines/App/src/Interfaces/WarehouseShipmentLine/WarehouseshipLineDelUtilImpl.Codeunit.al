codeunit 75644 "WarehouseshipLineDelUtilImpl" implements IWarehouseShipmentLineDeleteUtil
{

    procedure CheckAllowedToDeleteWhsShipmentLine(IFactory: interface IFactory): Boolean
    var
        NotAlllowedToDeleteSystemCreatedLinesErr: Label 'You are not allowed to delete system-created warehouse shipment lines on current location.';
        DeleteThisSystemCreatedLineQst: Label 'Are you sure you want to delete this system-created line?';
    begin
        if IFactory.GetWarehouseShipmentLine().GetSystemCreatedFLX() then
            if not IFactory.GetWarehouseSetup().GetUnblockDeletionOfShptLineFLX() then begin
                if not IFactory.GetWarehouseEmployee().GetAllowedToDeleteShptLineFLX() then
                    Error(NotAlllowedToDeleteSystemCreatedLinesErr);

                if Confirm(DeleteThisSystemCreatedLineQst, false) = false then
                    Error('');
            end;
    end;
}