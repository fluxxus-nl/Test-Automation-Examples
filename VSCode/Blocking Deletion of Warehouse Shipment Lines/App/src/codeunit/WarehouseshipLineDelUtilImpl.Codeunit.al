codeunit 75644 "WhsShipmentLineDelUtilImplFLX" implements IWarehouseShipmentLineDeleteUtilFLX
{
    // It seems that making this a TryFunction does not work
    procedure CheckAllowedToDeleteWhsShipmentLine(IFactory: interface IFactoryFLX)
    var
        NotAlllowedToDeleteSystemCreatedLinesErr: Label 'You are not allowed to delete system-created warehouse shipment lines on current location.';
        DeleteThisSystemCreatedLineQst: Label 'Are you sure you want to delete this system-created line?';
    begin
        if IFactory.GetWarehouseShipmentLine().GetSystemCreated() then
            if not IFactory.GetWarehouseSetup().GetUnblockDeletionOfShptLine() then begin
                if not IFactory.GetWarehouseEmployee().GetAllowedToDeleteShptLine() then
                    Error(NotAlllowedToDeleteSystemCreatedLinesErr);

                if Confirm(DeleteThisSystemCreatedLineQst, false) = false then
                    Error('');
            end;
    end;
}