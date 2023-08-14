codeunit 75651 "Unblock Deletion Disabled FLX"
{
    // Generated on 1-7-2023 at 13:53 by Luc van Vugt and Christoffer Anderson

    SubType = Test;

    trigger OnRun()
    begin
        // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    end;

    [Test]
    procedure DeleteByUserWithNoAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupNoUnblock: Codeunit StubWarehouseSetupNoUnblockFLX;
        StubWhseEmplDisAllowDelete: Codeunit StubWhseEmplDisAllowDeleteFLX;
        StubWarehouseSLNotSystem: Codeunit StubWarehouseSLNotSystemFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0005] Delete by user with no allowance manually created whse. shpt. line
        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupNoUnblock);
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
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupNoUnblock: Codeunit StubWarehouseSetupNoUnblockFLX;
        WarehouseEmployeeImpl: Codeunit WarehouseEmployeeImplFLX;
        WarehouseShipmentLineImpl: Codeunit WarehouseShipmentLineImplFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0006] Delete by user with no allowance automatically created whse. shpt. line
        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupNoUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with no allowance
        WarehouseEmployeeImpl.Initialize(false);
        FactoryImplementation.SetWarehouseEmployee(WarehouseEmployeeImpl);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentLineImpl.Initialize(true);
        FactoryImplementation.SetWarehouseShipmentLine(WarehouseShipmentLineImpl);

        // [WHEN] Delete warehouse shipment line
        asserterror Deleted := FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);

        // [THEN] Error disallowing deletion
        Assert.AreEqual(false, Deleted, '//TODO');
    end;

    [Test]
    procedure DeleteByUserWithAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupNoUnblock: Codeunit StubWarehouseSetupNoUnblockFLX;
        StubWhseEmpAllowDelete: Codeunit StubWhseEmpAllowDeleteFLX;
        StubWarehouseSLNotSystem: Codeunit StubWarehouseSLNotSystemFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0007] Delete by user with allowance manually created whse. shpt. line

        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupNoUnblock);
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
    [HandlerFunctions('ConfirmHandlerYes')]
    procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupNoUnblock: Codeunit StubWarehouseSetupNoUnblockFLX;
        StubWhseEmpAllowDelete: Codeunit StubWhseEmpAllowDeleteFLX;
        StubWarehouseSLIsSystem: Codeunit StubWarehouseSLIsSystemFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0008] Delete by user with allowance automatically created whse. shpt. line with confirmation

        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupNoUnblock);
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
    [HandlerFunctions('ConfirmHandlerNo')]
    procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLineWithNoConfirmation()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupNoUnblock: Codeunit StubWarehouseSetupNoUnblockFLX;
        StubWhseEmpAllowDelete: Codeunit StubWhseEmpAllowDeleteFLX;
        StubWarehouseSLIsSystem: Codeunit StubWarehouseSLIsSystemFLX;
        Deleted: Boolean;
    begin
        // [SCENARIO #0011] Delete by user with allowance automatically created whse. shpt. line with no confirmation

        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupNoUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with allowance
        FactoryImplementation.SetWarehouseEmployee(StubWhseEmpAllowDelete);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        FactoryImplementation.SetWarehouseShipmentLine(StubWarehouseSLIsSystem);

        // [WHEN] Delete warehouse shipment line
        asserterror Deleted := FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);

        // [THEN] Empty error occurred
        Assert.AreEqual(false, Deleted, '//TODO');
    end;

    [Test]
    procedure AllowedToDeleteShptLineIsEditableOnWarehouseEmployeesPage() // seems altogther useless test in current setup
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        FactoryImplementation: Codeunit FactoryImplementationFLX;
        StubWarehouseSetupNoUnblock: Codeunit StubWarehouseSetupNoUnblockFLX;
        StubWhseEmplDisAllowDelete: Codeunit StubWhseEmplDisAllowDeleteFLX;
        StubWarehouseSLNotSystem: Codeunit StubWarehouseSLNotSystemFLX;
    begin
        // [SCENARIO #0010] "Allowed to Delete Shpt. Line" is editable on warehouse employees page

        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user 
        FactoryImplementation.SetWarehouseEmployee(StubWhseEmplDisAllowDelete);

        // [WHEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupNoUnblock);

        // [THEN] Allowed to Delete Shpt. Line is editable on warehouse employees page
        Assert.AreEqual(false, StubWarehouseSetupNoUnblock.GetUnblockDeletionOfShptLine(), '//TODO');
    end;

    [ConfirmHandler]
    procedure ConfirmHandlerYes(Qst: Text; var Reply: Boolean)
    begin
        Assert.AreEqual(DeleteThisSystemCreatedLineQst, Qst, '');
        Reply := true;
    end;

    [ConfirmHandler]
    procedure ConfirmHandlerNo(Qst: Text; var Reply: Boolean)
    begin
        Assert.AreEqual(DeleteThisSystemCreatedLineQst, Qst, '');
        Reply := false;
    end;

    var
        Assert: Codeunit Assert;
        DeleteThisSystemCreatedLineQst: Label 'Are you sure you want to delete this system-created line?';
}