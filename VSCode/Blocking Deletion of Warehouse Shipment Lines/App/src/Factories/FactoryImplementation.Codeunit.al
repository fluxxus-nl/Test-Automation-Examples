codeunit 75641 "FactoryImplementation" implements IFactory
{
    #region WarehouseSetup
    var
        _WarehouseSetup: Interface IWarehouseSetup;
        _WarehouseSetupIsDefined: Boolean;

    procedure GetWarehouseSetup(): Interface IWarehouseSetup
    var
        WarehouseSetup: Record "Warehouse Setup";
        DefaultImplementationCodeunit: Codeunit WarehouseSetupImpl;
    begin
        if not _WarehouseSetupIsDefined then begin
            WarehouseSetup.Get();
            DefaultImplementationCodeunit.Initialize(WarehouseSetup."Unblock Deletion of Shpt. Line FLX");
            SetWarehouseSetup(DefaultImplementationCodeunit);
        end;

        exit(_WarehouseSetup);
    end;

    procedure SetWarehouseSetup(IWarehouseSetup: Interface IWarehouseSetup)
    begin
        _WarehouseSetup := IWarehouseSetup;
        _WarehouseSetupIsDefined := true;
    end;
    #endregion WarehouseSetup

    #region WarehouseShipmentLine
    var
        _WarehouseShipmentLine: Interface IWarehouseShipmentLine;
        _WarehouseShipmentLineIsDefined: Boolean;

    procedure GetWarehouseShipmentLine(): Interface IWarehouseShipmentLine
    var
        DefaultImplementationCodeunit: Codeunit WarehouseShipmentLineImpl;
    begin
        if not _WarehouseShipmentLineIsDefined then
            SetWarehouseShipmentLine(DefaultImplementationCodeunit);

        exit(_WarehouseShipmentLine);
    end;

    procedure SetWarehouseShipmentLine(IWarehouseShipmentLine: Interface IWarehouseShipmentLine)
    begin
        _WarehouseShipmentLine := IWarehouseShipmentLine;
        _WarehouseShipmentLineIsDefined := true;
    end;
    #endregion WarehouseShipmentLine

    #region WarehouseEmployee
    var
        _WarehouseEmployee: Interface IWarehouseEmployee;
        _WarehouseEmployeeIsDefined: Boolean;

    procedure GetWarehouseEmployee(): Interface IWarehouseEmployee
    var
        DefaultImplementationCodeunit: Codeunit WarehouseEmployeeImpl;
    begin
        if not _WarehouseEmployeeIsDefined then
            SetWarehouseEmployee(DefaultImplementationCodeunit);

        exit(_WarehouseEmployee);
    end;

    procedure SetWarehouseEmployee(IWarehouseEmployee: Interface IWarehouseEmployee)
    begin
        _WarehouseEmployee := IWarehouseEmployee;
        _WarehouseEmployeeIsDefined := true;
    end;
    #endregion WarehouseEmployee
}