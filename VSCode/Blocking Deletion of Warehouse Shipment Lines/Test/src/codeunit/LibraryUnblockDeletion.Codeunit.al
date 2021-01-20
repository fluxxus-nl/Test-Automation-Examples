codeunit 75655 "Library - Unblock Deletion FLX"
{
    var
        Assert: Codeunit Assert;
        LibraryInventory: Codeunit "Library - Inventory";
        LibrarySales: Codeunit "Library - Sales";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryWarehouse: Codeunit "Library - Warehouse";

    procedure CreateUnitOfMeasure()
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        LibraryInventory.CreateUnitOfMeasureCode(UnitOfMeasure);
    end;

    procedure SetOrderNosOnSalesReceivablesSetup()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        if not SalesReceivablesSetup.Get() then
            SalesReceivablesSetup.Insert();
        LibraryUtility.UpdateSetupNoSeriesCode(
          DATABASE::"Sales & Receivables Setup", SalesReceivablesSetup.FieldNo("Order Nos."));
    end;

    procedure SetUnblockDeletionOfShptLineOnWarehouseSetup(Enable: Boolean)
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        if not WarehouseSetup.Get() then
            WarehouseSetup.Insert();
        WarehouseSetup."Unblock Deletion of Shpt. Line FLX" := Enable;
        WarehouseSetup.Modify();
    end;

    procedure SetWhseShipNosOnWarehouseSetup()
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        if not WarehouseSetup.Get() then
            WarehouseSetup.Insert();
        LibraryUtility.UpdateSetupNoSeriesCode(
          DATABASE::"Warehouse Setup", WarehouseSetup.FieldNo("Whse. Ship Nos."));
    end;

    procedure CreateLocationWithRequireShipment(): Code[10]
    var
        Location: Record Location;
    begin
        LibraryWarehouse.CreateLocationWMS(Location, false, false, false, false, true);
        exit(Location.Code);
    end;

    procedure CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode: Code[10]): Code[20]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        LibrarySales.CreateSalesDocumentWithItem(SalesHeader, SalesLine, SalesHeader."Document Type"::Order, '', '', 1, LocationCode, 0D);
        LibrarySales.ReleaseSalesDocument(SalesHeader);

        LibraryWarehouse.CreateWhseShipmentFromSO(SalesHeader);
        exit(GetWarehouseShipmentHeaderNo(SalesHeader."No.", Database::"Sales Line", SalesHeader."Document Type"));
    end;

    procedure CreateAutomaticallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode: Code[10]): Code[20]
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        WarehouseShipmentNo: Code[20];
    begin
        WarehouseShipmentNo := CreateManuallyCreatedWarehouseShipmentFromReleasedSalesOrderWithOneLineWithRequireShipmentLocation(LocationCode);

        WarehouseShipmentLine.Setrange("No.", WarehouseShipmentNo);
        WarehouseShipmentLine.ModifyAll("System-Created FLX", true);

        exit(WarehouseShipmentNo);
    end;

    procedure CreateWarehouseEmployeeForCurrentUser(WithAllowance: Boolean; LocationCode: Code[10])
    var
        WarehouseEmployee: Record "Warehouse Employee";
    begin
        LibraryWarehouse.CreateWarehouseEmployee(WarehouseEmployee, LocationCode, false);

        if WithAllowance then begin
            WarehouseEmployee."Allowed to Delete Shpt. Line FLX" := true;
            WarehouseEmployee.Modify();
        end;
    end;

    procedure DeleteWarehouseShipmentLine(WarehouseShipmentNo: Code[20])
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        WarehouseShipmentLine.Setrange("No.", WarehouseShipmentNo);
        WarehouseShipmentLine.FindFirst();
        WarehouseShipmentLine.Delete(true);
    end;

    procedure VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo: Code[20])
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        WarehouseShipmentLine.Setrange("No.", WarehouseShipmentNo);
        Assert.RecordIsEmpty(WarehouseShipmentLine);
    end;

    procedure VerifyErrorDisallowingDeletion()
    var
        NotAlllowedToDeleteSystemCreatedLinesErr: Label 'You are not allowed to delete system-created warehouse shipment lines on current location.';
    begin
        Assert.ExpectedError(NotAlllowedToDeleteSystemCreatedLinesErr);
    end;

    procedure VerifyAllowedToDeleteShptLineOnWarehouseEmployeesPage(IsEditable: Boolean; LocationCode: Code[10])
    var
        WarehouseEmployee: Record "Warehouse Employee";
        WarehouseEmployees: TestPage "Warehouse Employees";
    begin
        WarehouseEmployee.SetRange("User ID", UserId());
        WarehouseEmployee.SetRange("Location Code", LocationCode);
        WarehouseEmployee.FindFirst();

        WarehouseEmployees.OpenEdit();
        WarehouseEmployees.GoToRecord(WarehouseEmployee);
        Assert.AreEqual(IsEditable, WarehouseEmployees."Allowed to Delete Shpt. Line FLX".Editable(), WarehouseEmployees."Allowed to Delete Shpt. Line FLX".Caption());
        WarehouseEmployees.Close();
    end;

    local procedure GetWarehouseShipmentHeaderNo(SourceNo: Code[20]; SourceType: Integer; SourceSubtype: Enum "Sales Document Type"): Code[20]
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        FindWarehouseShipmentLine(WarehouseShipmentLine, SourceNo, SourceType, SourceSubtype);
        exit(WarehouseShipmentLine."No.");
    end;

    local procedure FindWarehouseShipmentLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; SourceNo: Code[20]; SourceType: Integer; SourceSubtype: Enum "Sales Document Type")
    begin
        WarehouseShipmentLine.Setrange("Source Type", SourceType);
        WarehouseShipmentLine.SetRange("Source Subtype", SourceSubtype);
        WarehouseShipmentLine.Setrange("Source No.", SourceNo);
        WarehouseShipmentLine.FindFirst();
    end;
}