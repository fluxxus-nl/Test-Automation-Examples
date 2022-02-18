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
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0001] Delete by user with no allowance manually created whse. shpt. line
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
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0002] Delete by user with no allowance automatically created whse. shpt. line
        Initialize();

        // [GIVEN] Warehouse employee for current user with no allowance
        CreateWarehouseEmployeeForCurrentUser(NoAllowance(), LocationCode);
        // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentNo := CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        // [WHEN] Delete warehouse shipment line
        DeleteWarehouseShipmentLine(WarehouseShipmentNo);

        // [THEN] Warehouse shipment line is deleted
        VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    end;

    [Test]
    procedure DeleteByUserWithAllowanceManuallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0003] Delete by user with allowance manually created whse. shpt. line
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
    procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLine()
    // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    var
        WarehouseShipmentNo: Code[20];
    begin
        // [SCENARIO #0004] Delete by user with allowance automatically created whse. shpt. line
        Initialize();

        // [GIVEN] Warehouse employee for current user with allowance
        CreateWarehouseEmployeeForCurrentUser(WithAllowance(), LocationCode);
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
    begin
        // [SCENARIO #0009] "Allowed to Delete Shpt. Line" is not editable on warehouse employees page
        Initialize();

        // [GIVEN] Warehouse employee for current user
        CreateWarehouseEmployeeForCurrentUser(NoAllowance(), LocationCode);

        // [WHEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        EnableUnblockDeletionOfShptLineOnWarehouseSetup();

        // [THEN] Allowed to Delete Shpt. Line is not editable on warehouse employees page
        VerifyAllowedToDeleteShptLineIsNotEditableOnWarehouseEmployeesPage(LocationCode);
    end;

    var
        LibraryUnblockDeletion: Codeunit "Library - Unblock Deletion FLX";
        IsInitialized: Boolean;
        LocationCode: Code[10];

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Unblock Deletion Enabled FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Unblock Deletion Enabled FLX");

        // [GIVEN] Set sales & receivebales setup
        SetSalesReceivablesSetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();
        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        EnableUnblockDeletionOfShptLineOnWarehouseSetup();
        // [GIVEN] Location with require shipment
        LocationCode := CreateLocationWithRequireShipment();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Unblock Deletion Enabled FLX");
    end;

    local procedure SetSalesReceivablesSetup()
    begin
        LibraryUnblockDeletion.SetOrderNosOnSalesReceivablesSetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryUnblockDeletion.CreateUnitOfMeasure();
    end;

    local procedure EnableUnblockDeletionOfShptLineOnWarehouseSetup()
    begin
        LibraryUnblockDeletion.SetUnblockDeletionOfShptLineOnWarehouseSetup(true);
        LibraryUnblockDeletion.SetWhseShipNosOnWarehouseSetup();
    end;

    local procedure CreateLocationWithRequireShipment(): Code[10]
    begin
        exit(LibraryUnblockDeletion.CreateLocationWithRequireShipment());
    end;

    local procedure CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode: Code[10]): Code[20]
    begin
        exit(LibraryUnblockDeletion.CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode));
    end;

    local procedure CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode: Code[10]): Code[20]
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        WarehouseShipmentNo: Code[20];
    begin
        WarehouseShipmentNo := CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
        WarehouseShipmentLine.ModifyAll("System-Created FLX", true);

        exit(WarehouseShipmentNo);
    end;

    local procedure CreateWarehouseEmployeeForCurrentUser(WithAllowance: Boolean; LocationCode: Code[10])
    begin
        LibraryUnblockDeletion.CreateWarehouseEmployeeForCurrentUser(WithAllowance, LocationCode);
    end;

    local procedure DeleteWarehouseShipmentLine(WarehouseShipmentNo: Code[20])
    begin
        LibraryUnblockDeletion.DeleteWarehouseShipmentLine(WarehouseShipmentNo)
    end;

    local procedure VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo: Code[20])
    begin
        LibraryUnblockDeletion.VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    end;

    local procedure VerifyAllowedToDeleteShptLineIsNotEditableOnWarehouseEmployeesPage(LocationCode: Code[10])
    begin
        LibraryUnblockDeletion.VerifyAllowedToDeleteShptLineOnWarehouseEmployeesPage(false, LocationCode);
    end;

    local procedure NoAllowance(): Boolean
    begin
        exit(false);
    end;

    local procedure WithAllowance(): Boolean
    begin
        exit(true);
    end;
}