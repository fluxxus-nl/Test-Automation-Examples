codeunit 75659 "Library - Unblock Deletion"
{
    var
        Assert: Codeunit Assert;
        LibraryWarehouse: Codeunit "Library - Warehouse";
        LibrarySales: Codeunit "Library - Sales";

    procedure SetUnblockDeletionOfShptLineOnWarehouseSetup(Enable: Boolean)
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        with WarehouseSetup do begin
            if not Get() then
                Insert();
            "Unblock Deletion of Shpt. Line" := Enable;
            Modify();
        end;
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

        with WarehouseShipmentLine do begin
            Setrange("No.", WarehouseShipmentNo);
            ModifyAll("System-Created", true);
        end;

        exit(WarehouseShipmentNo);
    end;

    procedure CreateWarehouseEmployeeForCurrentUser(WithAllowance: Boolean; LocationCode: Code[10])
    var
        WarehouseEmployee: Record "Warehouse Employee";
    begin
        LibraryWarehouse.CreateWarehouseEmployee(WarehouseEmployee, LocationCode, false);

        if WithAllowance then
            with WarehouseEmployee do begin
                "Allowed to Delete Shpt. Line" := true;
                Modify();
            end;
    end;

    procedure DeleteWarehouseShipmentLine(WarehouseShipmentNo: Code[20])
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        with WarehouseShipmentLine do begin
            Setrange("No.", WarehouseShipmentNo);
            FindFirst();
            Delete(true);
        end;
    end;

    procedure VerifyWarehouseShipmentLineIsDeleted(WarehouseShipmentNo: Code[20])
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        with WarehouseShipmentLine do begin
            Setrange("No.", WarehouseShipmentNo);
            Assert.RecordIsEmpty(WarehouseShipmentLine);
        end;
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
        with WarehouseEmployee do begin
            SetRange("User ID", UserId());
            SetRange("Location Code", LocationCode);
            FindFirst()
        end;

        with WarehouseEmployees do begin
            OpenEdit();
            GoToRecord(WarehouseEmployee);
            Assert.AreEqual(IsEditable, "Allowed to Delete Shpt. Line".Editable(), "Allowed to Delete Shpt. Line".Caption());
            Close();
        end;
    end;

    local procedure GetWarehouseShipmentHeaderNo(SourceNo: Code[20]; SourceType: Integer; SourceSubtype: Integer): Code[20]
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        FindWarehouseShipmentLine(WarehouseShipmentLine, SourceNo, SourceType, SourceSubtype);
        exit(WarehouseShipmentLine."No.");
    end;

    local procedure FindWarehouseShipmentLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; SourceNo: Code[20]; SourceType: Integer; SourceSubtype: Integer)
    begin
        with WarehouseShipmentLine do begin
            Setrange("Source Type", SourceType);
            if SourceSubtype >= 0 then
                SetRange("Source Subtype", SourceSubtype);
            Setrange("Source No.", SourceNo);
            FindFirst();
        end;
    end;
}