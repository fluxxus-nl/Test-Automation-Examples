codeunit 75650 "Unblock Deletion Enabled FLX"
{
    // Generated on 22-3-2020 at 16:04 by Luc van Vugt

    SubType = Test;

    trigger OnRun()
    begin
        // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    end;

    [Test]
    procedure DeleteByUserWithNoAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        FactoryImplementation: Codeunit FactoryImplementation;
        WarehouseEmployeeImpl: Codeunit "StubWhseEmpAllowDelete";
        StubWarehouseSetupHasUnblock: Codeunit StubWarehouseSetupHasUnblock;
        WarehouseShipmentLineImpl: Codeunit StubWarehouseSLNotSystem;
        result: Boolean;
    begin
        // [SCENARIO #0001] Delete by user with no allowance manually created whse. shpt. line

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupHasUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with no allowance
        FactoryImplementation.SetWarehouseEmployee(WarehouseEmployeeImpl);
        // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
        FactoryImplementation.SetWarehouseShipmentLine(WarehouseShipmentLineImpl);

        // [WHEN] Delete warehouse shipment line
        result := FactoryImplementation.GetWarehouseShipmentLineDeleteUtil().CheckAllowedToDeleteWhsShipmentLine(FactoryImplementation);

        // [THEN] Warehouse shipment line is deleted
        Assert.AreEqual(true, result, '//TODO');
    end;

    [Test]
    procedure DeleteByUserWithNoAllowanceAutomaticallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        FactoryImplementation: Codeunit FactoryImplementation;
        WarehouseEmployeeImpl: Codeunit WarehouseEmployeeImpl;
        StubWarehouseSetupHasUnblock: Codeunit StubWarehouseSetupHasUnblock;
        WarehouseShipmentLineImpl: Codeunit WarehouseShipmentLineImpl;
        result: Boolean;
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
        // DeleteWarehouseShipmentLine(WarehouseShipmentNo);
        result := FactoryImplementation.GetWarehouseShipmentLine().CheckDeletionAllowed(FactoryImplementation);

        // [THEN] Warehouse shipment line is deleted
        // VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
        Assert.AreEqual(false, result);
    end;

    [Test]
    procedure DeleteByUserWithAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        LocationCode: Code[10];
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0003] Delete by user with allowance manually created whse. shpt. line
        Initialize();

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        EnableUnblockDeletionOfShptLineOnWarehouseSetup();
        // [GIVEN] Location with require shipment
        LocationCode := CreateLocationWithRequireShipment();
        // [GIVEN] Warehouse employee for current user with allowance
        CreateWarehouseEmployeeForCurrentUserWithAllowance(LocationCode);
        // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line
        DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Warehouse shipment line is deleted
        VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    end;

    [Test]
    procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        LocationCode: Code[10];
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0004] Delete by user with allowance automatically created whse. shpt. line
        Initialize();

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        EnableUnblockDeletionOfShptLineOnWarehouseSetup();
        // [GIVEN] Location with require shipment
        LocationCode := CreateLocationWithRequireShipment();
        // [GIVEN] Warehouse employee for current user with allowance
        CreateWarehouseEmployeeForCurrentUserWithAllowance(LocationCode);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line
        DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Warehouse shipment line is deleted
        VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    end;

    [Test]
    procedure AllowedToDeleteShptLineIsNotEditableOnWarehouseEmployeesPage()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        LocationCode: Code[10];
    begin
        // [SCENARIO #0009] "Allowed to Delete Shpt. Line" is not editable on warehouse employees page
        // Initialize();

        // [GIVEN] Location with require shipment
        // LocationCode := CreateLocationWithRequireShipment();
        // [GIVEN] Warehouse employee for current user
        // CreateWarehouseEmployeeForCurrentUserWithNoAllowance(LocationCode);

        // [WHEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        EnableUnblockDeletionOfShptLineOnWarehouseSetup();

        // [THEN] Allowed to Delete Shpt. Line is not editable on warehouse employees page
        VerifyAllowedToDeleteShptLineIsNotEditableOnWarehouseEmployeesPage(LocationCode);
    end;

    var
        Assert: Codeunit Assert;
}