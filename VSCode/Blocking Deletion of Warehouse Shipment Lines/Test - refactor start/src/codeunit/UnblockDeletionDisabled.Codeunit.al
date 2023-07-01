codeunit 75651 "Unblock Deletion Disabled FLX"
{
    // Generated on 24-3-2020 at 13:53 by Luc van Vugt

    SubType = Test;

    trigger OnRun()
    begin
        // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    end;

    [Test]
    procedure DeleteByUserWithNoAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0005] Delete by user with no allowance manually created whse. shpt. line
        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        // [GIVEN] Location with require shipment
        Initialize();

        // [GIVEN] Warehouse employee for current user with no allowance
        CreateWarehouseEmployeeForCurrentUser(NoAllowance(), LocationCode);
        // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line
        DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Warehouse shipment line is deleted
        VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    end;

    [Test]
    procedure DeleteByUserWithNoAllowanceAutomaticallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0006] Delete by user with no allowance automatically created whse. shpt. line
        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        // [GIVEN] Location with require shipment
        Initialize();

        // [GIVEN] Warehouse employee for current user with no allowance
        CreateWarehouseEmployeeForCurrentUser(NoAllowance(), LocationCode);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line
        asserterror DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Error disallowing deletion
        VerifyErrorDisallowingDeletion();
    end;

    [Test]
    procedure DeleteByUserWithAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0007] Delete by user with allowance manually created whse. shpt. line
        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        // [GIVEN] Location with require shipment
        Initialize();

        // [GIVEN] Warehouse employee for current user with allowance
        CreateWarehouseEmployeeForCurrentUser(WithAllowance(), LocationCode);
        // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line
        DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Warehouse shipment line is deleted
        VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    end;

    [Test]
    [HandlerFunctions('ConfirmHandlerYes')]
    procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLineWithConfirmation()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0008] Delete  by user with allowance automatically created whse. shpt. line with confirmation
        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        // [GIVEN] Location with require shipment
        Initialize();

        // [GIVEN] Warehouse employee for current user with allowance
        CreateWarehouseEmployeeForCurrentUser(WithAllowance(), LocationCode);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line and select yes in confirmation
        //        Confirm handled by ConfirmHandlerYes
        DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Warehouse shipment line is deleted
        VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    end;

    [Test]
    [HandlerFunctions('ConfirmHandlerNo')]
    procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLineWithNoConfirmation()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0011] Delete by user with allowance automatically created whse. shpt. line with no confirmation
        // [GIVEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        // [GIVEN] Location with require shipment
        Initialize();

        // [GIVEN] Warehouse employee for current user with allowance
        CreateWarehouseEmployeeForCurrentUser(WithAllowance(), LocationCode);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line and select no in confirm
        //        Confirm handled by ConfirmHandlerNo
        asserterror DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Empty error occurred
        VerifyEmptyErrorOccurred();
    end;

    [Test]
    procedure AllowedToDeleteShptLineIsEditableOnWarehouseEmployeesPage()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line disabled
    begin
        // [SCENARIO #0010] "Allowed to Delete Shpt. Line" is editable on warehouse employees page
        // [GIVEN] Location with require shipment
        Initialize();

        // [GIVEN] Warehouse employee for current user
        CreateWarehouseEmployeeForCurrentUser(NoAllowance(), LocationCode);

        // [WHEN] Disable "Unblock Deletion of Shpt. Line" on warehouse setup
        DisableUnblockDeletionOfShptLineOnWarehouseSetup();

        // [THEN] Allowed to Delete Shpt. Line is editable on warehouse employees page
        VerifyAllowedToDeleteShptLineIsEditableOnWarehouseEmployeesPage(LocationCode);
    end;


}