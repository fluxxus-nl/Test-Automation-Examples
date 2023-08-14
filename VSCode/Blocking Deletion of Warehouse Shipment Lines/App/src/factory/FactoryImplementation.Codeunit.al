codeunit 75641 "FactoryImplementationFLX" implements IFactoryFLX
{
    #region WarehouseSetup
    var
        _WarehouseSetup: Interface IWarehouseSetupFLX;
        _WarehouseSetupIsDefined: Boolean;

    procedure GetWarehouseSetup(): Interface IWarehouseSetupFLX
    var
        WarehouseSetup: Record "Warehouse Setup";
        DefaultImplementationCodeunit: Codeunit WarehouseSetupImplFLX;
    begin
        if not _WarehouseSetupIsDefined then begin
            WarehouseSetup.Get();
            DefaultImplementationCodeunit.Initialize(WarehouseSetup."Unblock Deletion of Shpt. Line FLX");
            SetWarehouseSetup(DefaultImplementationCodeunit);
        end;

        exit(_WarehouseSetup);
    end;

    procedure SetWarehouseSetup(IWarehouseSetup: Interface IWarehouseSetupFLX)
    begin
        _WarehouseSetup := IWarehouseSetup;
        _WarehouseSetupIsDefined := true;
    end;
    #endregion WarehouseSetup

    #region WarehouseShipmentLine
    var
        _WarehouseShipmentLine: Interface IWarehouseShipmentLineFLX;
        _WarehouseShipmentLineIsDefined: Boolean;

    procedure GetWarehouseShipmentLine(): Interface IWarehouseShipmentLineFLX
    var
        DefaultImplementationCodeunit: Codeunit WarehouseShipmentLineImplFLX;
    begin
        if not _WarehouseShipmentLineIsDefined then
            SetWarehouseShipmentLine(DefaultImplementationCodeunit);

        exit(_WarehouseShipmentLine);
    end;

    procedure SetWarehouseShipmentLine(IWarehouseShipmentLine: Interface IWarehouseShipmentLineFLX)
    begin
        _WarehouseShipmentLine := IWarehouseShipmentLine;
        _WarehouseShipmentLineIsDefined := true;
    end;
    #endregion WarehouseShipmentLine

    #region WarehouseEmployee
    var
        _WarehouseEmployee: Interface IWarehouseEmployeeFLX;
        _WarehouseEmployeeIsDefined: Boolean;

    procedure GetWarehouseEmployee(): Interface IWarehouseEmployeeFLX
    var
        DefaultImplementationCodeunit: Codeunit WarehouseEmployeeImplFLX;
    begin
        if not _WarehouseEmployeeIsDefined then
            SetWarehouseEmployee(DefaultImplementationCodeunit);

        exit(_WarehouseEmployee);
    end;

    procedure SetWarehouseEmployee(IWarehouseEmployee: Interface IWarehouseEmployeeFLX)
    begin
        _WarehouseEmployee := IWarehouseEmployee;
        _WarehouseEmployeeIsDefined := true;
    end;
    #endregion WarehouseEmployee
    #region WarehouseShipmentLineDeleteUtil
    var
        _WarehouseShipmentLineDeleteUtil: Interface IWarehouseShipmentLineDeleteUtilFLX;
        _WarehouseShipmentLineDeleteUtilIsDefined: Boolean;

    procedure GetWarehouseShipmentLineDeleteUtil(): Interface IWarehouseShipmentLineDeleteUtilFLX
    var
        DefaultImplementationCodeunit: Codeunit "WhsShipmentLineDelUtilImplFLX";
    begin
        if not _WarehouseShipmentLineDeleteUtilIsDefined then
            SetWarehouseShipmentLineDeleteUtil(DefaultImplementationCodeunit);

        exit(_WarehouseShipmentLineDeleteUtil);
    end;

    procedure SetWarehouseShipmentLineDeleteUtil(IWarehouseShipmentLineDeleteUtil: Interface IWarehouseShipmentLineDeleteUtilFLX)
    begin
        _WarehouseShipmentLineDeleteUtil := IWarehouseShipmentLineDeleteUtil;
        _WarehouseShipmentLineDeleteUtilIsDefined := true;
    end;
    #endregion WarehouseShipmentLineDeleteUtil
}