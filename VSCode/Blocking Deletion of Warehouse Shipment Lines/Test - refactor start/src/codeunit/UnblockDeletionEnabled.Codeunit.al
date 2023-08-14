codeunit 75650 "Unblock Deletion Enabled FLX"
{
    // Generated on 1-7-2023 at 12:53 by Luc van Vugt and Christoffer Anderson

    SubType = Test;

    trigger OnRun()
    begin
        // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    end;

    [Test]
    procedure DeleteByUserWithNoAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupHasUnblock: Codeunit StubWhsSetupHasUnblockFLX;
        StubWhseEmplDisAllowDelete: Codeunit StubWhseEmplDisAllowDeleteFLX;
        StubWarehouseSLNotSystem: Codeunit StubWarehouseSLNotSystemFLX;
        // Why do we use stubs here for WarehouseEmployeeImpl and WarehouseShipmentLineImpl and not in DeleteByUserWithNoAllowanceAutomaticallyCreatedWhseShptLine?
        Deleted: Boolean;
    begin
        // [SCENARIO #0001] Delete by user with no allowance manually created whse. shpt. line

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupHasUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with no allowance
        FactoryImplementation.SetWarehouseEmployee(StubWhseEmplDisAllowDelete);
        // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
        FactoryImplementation.SetWarehouseShipmentLine(StubWarehouseSLNotSystem);

        // [WHEN] Delete warehouse shipment line
        Deleted := FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);

        // [THEN] Warehouse shipment line is deleted
        Assert.AreEqual(true, Deleted, '//TODO');
    end;

    [Test]
    procedure DeleteByUserWithNoAllowanceAutomaticallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupHasUnblock: Codeunit StubWhsSetupHasUnblockFLX;
        WarehouseEmployeeImpl: Codeunit WarehouseEmployeeImplFLX;
        WarehouseShipmentLineImpl: Codeunit WarehouseShipmentLineImplFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0002] Delete by user with no allowance automatically created whse. shpt. line

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupHasUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with no allowance
        WarehouseEmployeeImpl.Initialize(false);
        FactoryImplementation.SetWarehouseEmployee(WarehouseEmployeeImpl);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentLineImpl.Initialize(true);
        FactoryImplementation.SetWarehouseShipmentLine(WarehouseShipmentLineImpl);

        // [WHEN] Delete warehouse shipment line
        Deleted := FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);

        // [THEN] Warehouse shipment line is deleted
        Assert.AreEqual(true, Deleted, '//TODO');
    end;

    [Test]
    procedure DeleteByUserWithAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupHasUnblock: Codeunit StubWhsSetupHasUnblockFLX;
        StubWhseEmpAllowDelete: Codeunit StubWhseEmpAllowDeleteFLX;
        StubWarehouseSLNotSystem: Codeunit StubWarehouseSLNotSystemFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0003] Delete by user with allowance manually created whse. shpt. line

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupHasUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with allowance
        FactoryImplementation.SetWarehouseEmployee(StubWhseEmpAllowDelete);
        // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
        FactoryImplementation.SetWarehouseShipmentLine(StubWarehouseSLNotSystem);

        // [WHEN] Delete warehouse shipment line
        Deleted := FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);

        // [THEN] Warehouse shipment line is deleted
        Assert.AreEqual(true, Deleted, '//TODO');
    end;

    [Test]
    procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupHasUnblock: Codeunit StubWhsSetupHasUnblockFLX;
        StubWhseEmpAllowDelete: Codeunit StubWhseEmpAllowDeleteFLX;
        StubWarehouseSLIsSystem: Codeunit StubWarehouseSLIsSystemFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0004] Delete by user with allowance automatically created whse. shpt. line

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupHasUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with allowance
        FactoryImplementation.SetWarehouseEmployee(StubWhseEmpAllowDelete);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        FactoryImplementation.SetWarehouseShipmentLine(StubWarehouseSLIsSystem);

        // [WHEN] Delete warehouse shipment line
        Deleted := FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);

        // [THEN] Warehouse shipment line is deleted
        Assert.AreEqual(true, Deleted, '//TODO');
    end;

    [Test]
    procedure AllowedToDeleteShptLineIsNotEditableOnWarehouseEmployeesPage() // seems altogther useless test in current setup
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupHasUnblock: Codeunit StubWhsSetupHasUnblockFLX;
        StubWhseEmplDisAllowDelete: Codeunit StubWhseEmplDisAllowDeleteFLX;
        StubWarehouseSLNotSystem: Codeunit StubWarehouseSLNotSystemFLX;
    begin
        // [SCENARIO #0009] "Allowed to Delete Shpt. Line" is not editable on warehouse employees page

        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with allowance
        FactoryImplementation.SetWarehouseEmployee(StubWhseEmplDisAllowDelete);

        // [WHEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupHasUnblock);

        // [THEN] Allowed to Delete Shpt. Line is not editable on warehouse employees page
        Assert.AreEqual(true, StubWarehouseSetupHasUnblock.GetUnblockDeletionOfShptLine(), '//TODO');
    end;

    var
        Assert: Codeunit Assert;
}