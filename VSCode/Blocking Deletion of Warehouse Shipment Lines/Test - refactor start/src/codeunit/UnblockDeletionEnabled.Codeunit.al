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
        WarehouseEmployeeImpl: Codeunit WarehouseEmployeeImpl;
        StubWarehouseSetupHasUnblock: Codeunit StubWarehouseSetupHasUnblock;
        WarehouseShipmentLineImpl: Codeunit WarehouseShipmentLineImpl;
        result: Boolean;
    begin
        // [SCENARIO #0001] Delete by user with no allowance manually created whse. shpt. line

        // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
        FactoryImplementation.SetWarehouseSetup(StubWarehouseSetupHasUnblock);
        // [GIVEN] Location with require shipment
        // [GIVEN] Warehouse employee for current user with no allowance
        WarehouseEmployeeImpl.Initialize(false);
        FactoryImplementation.SetWarehouseEmployee(WarehouseEmployeeImpl);
        // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
        WarehouseShipmentLineImpl.Initialize(false);
        FactoryImplementation.SetWarehouseShipmentLine(WarehouseShipmentLineImpl);

        // [WHEN] Delete warehouse shipment line
        result := FactoryImplementation.GetWarehouseShipmentLine().CheckDeletionAllowed(FactoryImplementation);

        // [THEN] Warehouse shipment line is deleted
        Assert.AreEqual(true, result);
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

    // [Test] //TODO irrelevant path allready tested
    // procedure DeleteByUserWithAllowanceManuallyCreatedWhseShptLine()
    // // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    // var
    //     LocationCode: Code[10];
    //     WarehouseShipmentNo: Code[20];
    // begin
    //     // [SCENARIO #0003] Delete by user with allowance manually created whse. shpt. line
    //     Initialize();

    //     // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
    //     EnableUnblockDeletionOfShptLineOnWarehouseSetup();
    //     // [GIVEN] Location with require shipment
    //     LocationCode := CreateLocationWithRequireShipment();
    //     // [GIVEN] Warehouse employee for current user with allowance
    //     CreateWarehouseEmployeeForCurrentUserWithAllowance(LocationCode);
    //     // [GIVEN] Manually created warehouse shipment from released sales order with one line with require shipment location
    //     WarehouseShipmentNo := CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

    //     // [WHEN] Delete warehouse shipment line
    //     DeleteWarehouseShipmentLine(WarehouseShipmentNo);

    //     // [THEN] Warehouse shipment line is deleted
    //     VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    // end;

    // [Test]//TODO irrelevant path allready tested
    // procedure DeleteByUserWithAllowanceAutomaticallyCreatedWhseShptLine()
    // // [FEATURE] Unblock Deletion of Whse. Shpt. Line enabled
    // var
    //     LocationCode: Code[10];
    //     WarehouseShipmentNo: Code[20];
    // begin
    //     // [SCENARIO #0004] Delete by user with allowance automatically created whse. shpt. line
    //     Initialize();

    //     // [GIVEN] Enable "Unblock Deletion of Shpt. Line" on warehouse setup
    //     EnableUnblockDeletionOfShptLineOnWarehouseSetup();
    //     // [GIVEN] Location with require shipment
    //     LocationCode := CreateLocationWithRequireShipment();
    //     // [GIVEN] Warehouse employee for current user with allowance
    //     CreateWarehouseEmployeeForCurrentUserWithAllowance(LocationCode);
    //     // [GIVEN] Automatically created warehouse shipment from released sales order with one line with require shipment location
    //     WarehouseShipmentNo := CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

    //     // [WHEN] Delete warehouse shipment line
    //     DeleteWarehouseShipmentLine(WarehouseShipmentNo);

    //     // [THEN] Warehouse shipment line is deleted
    //     VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo);
    // end;

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

    // var
    //     Assert: Codeunit Assert;
    //     LibraryWarehouse: Codeunit "Library - Warehouse";
    //     LibrarySales: Codeunit "Library - Sales";
    //     IsInitialized: Boolean;

    // local procedure Initialize()
    // var
    //     LibraryTestInitialize: Codeunit "Library - Test Initialize";
    // begin
    //     LibraryTestInitialize.OnTestInitialize(Codeunit::"Unblock Deletion Enabled FLX");

    //     if IsInitialized then
    //         exit;

    //     LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Unblock Deletion Enabled FLX");

    //     IsInitialized := true;
    //     Commit();

    //     LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Unblock Deletion Enabled FLX");
    // end;

    // local procedure EnableUnblockDeletionOfShptLineOnWarehouseSetup()
    // var
    //     WarehouseSetup: Record "Warehouse Setup";
    // begin
    //     if not WarehouseSetup.Get() then
    //         WarehouseSetup.Insert();
    //     WarehouseSetup."Unblock Deletion of Shpt. Line FLX" := true;
    //     WarehouseSetup.Modify();
    // end;

    // local procedure CreateLocationWithRequireShipment(): Code[10]
    // var
    //     Location: Record Location;
    // begin
    //     LibraryWarehouse.CreateLocationWMS(Location, false, false, false, false, true);
    //     exit(Location.Code);
    // end;

    // local procedure CreateWarehouseEmployeeForCurrentUserWithAllowance(LocationCode: Code[10])
    // var
    //     WarehouseEmployee: Record "Warehouse Employee";
    // begin
    //     LibraryWarehouse.CreateWarehouseEmployee(WarehouseEmployee, LocationCode, false);

    //     WarehouseEmployee."Allowed to Delete Shpt. Line FLX" := true;
    //     WarehouseEmployee.Modify();
    // end;

    // local procedure CreateWarehouseEmployeeForCurrentUserWithNoAllowance(LocationCode: Code[10])
    // var
    //     WarehouseEmployee: Record "Warehouse Employee";
    // begin
    //     LibraryWarehouse.CreateWarehouseEmployee(WarehouseEmployee, LocationCode, false);

    //     WarehouseEmployee."Allowed to Delete Shpt. Line FLX" := false;
    //     WarehouseEmployee.Modify();
    // end;

    // local procedure CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode: Code[10]): Code[20]
    // var
    //     SalesHeader: Record "Sales Header";
    //     SalesLine: Record "Sales Line";
    // begin
    //     LibrarySales.CreateSalesDocumentWithItem(SalesHeader, SalesLine, SalesHeader."Document Type"::Order, '', '', 1, LocationCode, 0D);
    //     LibrarySales.ReleaseSalesDocument(SalesHeader);

    //     LibraryWarehouse.CreateWhseShipmentFromSO(SalesHeader);
    //     exit(GetWarehouseShipmentHeaderNo(SalesHeader."No.", Database::"Sales Line", SalesHeader."Document Type"));
    // end;

    // local procedure CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode: Code[10]): Code[20]
    // var
    //     WarehouseShipmentLine: Record "Warehouse Shipment Line";
    //     WarehouseShipmentNo: Code[20];
    // begin
    //     WarehouseShipmentNo := CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

    //     WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
    //     WarehouseShipmentLine.ModifyAll("System-Created FLX", true);

    //     exit(WarehouseShipmentNo);
    // end;

    // local procedure GetWarehouseShipmentHeaderNo(SourceNo: Code[20]; SourceType: Integer; SourceSubtype: Enum "Sales Document Status"): Code[20]
    // var
    //     WarehouseShipmentLine: Record "Warehouse Shipment Line";
    // begin
    //     FindWarehouseShipmentLine(WarehouseShipmentLine, SourceNo, SourceType, SourceSubtype);
    //     exit(WarehouseShipmentLine."No.");
    // end;

    // local procedure FindWarehouseShipmentLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; SourceNo: Code[20]; SourceType: Integer; SourceSubtype: Enum "Sales Document Type")
    // begin
    //     WarehouseShipmentLine.SetRange("Source Type", SourceType);
    //     WarehouseShipmentLine.SetRange("Source Subtype", SourceSubtype);
    //     WarehouseShipmentLine.SetRange("Source No.", SourceNo);
    //     WarehouseShipmentLine.FindFirst();
    // end;

    // local procedure DeleteWarehouseShipmentLine(WarehouseShipmentNo: Code[20])
    // var
    //     WarehouseShipmentLine: Record "Warehouse Shipment Line";
    // begin
    //     WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
    //     WarehouseShipmentLine.FindFirst();
    //     WarehouseShipmentLine.Delete(true);
    // end;

    // local procedure VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo: Code[20])
    // var
    //     WarehouseShipmentLine: Record "Warehouse Shipment Line";
    // begin
    //     WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
    //     Assert.RecordIsEmpty(WarehouseShipmentLine);
    // end;

    // local procedure VerifyAllowedToDeleteShptLineIsNotEditableOnWarehouseEmployeesPage(LocationCode: Code[10])
    // var
    //     WarehouseEmployee: Record "Warehouse Employee";
    //     WarehouseEmployees: TestPage "Warehouse Employees";
    // begin
    //     WarehouseEmployee.SetRange("User ID", UserId());
    //     WarehouseEmployee.SetRange("Location Code", LocationCode);
    //     WarehouseEmployee.FindFirst();

    //     WarehouseEmployees.OpenEdit();
    //     WarehouseEmployees.GoToRecord(WarehouseEmployee);
    //     Assert.AreEqual(false, WarehouseEmployees."Allowed to Delete Shpt. Line FLX".Editable(), WarehouseEmployees."Allowed to Delete Shpt. Line FLX".Caption());
    //     WarehouseEmployees.Close();
    // end;
}