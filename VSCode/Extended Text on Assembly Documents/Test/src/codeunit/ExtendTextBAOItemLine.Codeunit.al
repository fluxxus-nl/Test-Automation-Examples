codeunit 76453 "Extend. Text BAO Item Line FLX"
{
    // Generated on 29/06/2020 at 10:44 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on blanket assembly order/Add item line
        // [FEATURE] Extended Text on blanket assembly order/Delete item line
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForItemWithAutomaticExtTextsDisabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on blanket assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0011] Add to blanket assembly order line for item with "Automatic Ext. Texts"disabled and extended text enabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add item line to blanket assembly order page
        AddItemLineToBlanketAssemblyOrderPage(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForItemWithAutomaticExtTextsEnabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on blanket assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0012] Add to blanket assembly order line for item with "Automatic Ext. Texts" enabled and extended text enabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" enabled and extended text enabled for blanket assembly order
        ItemNo := CreateItemWithExtendedText(EnableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add item line to blanket assembly order page
        AddItemLineToBlanketAssemblyOrderPage(AssemblyDocNo, ItemNo);

        // [THEN] Extended text lines are added to blanket assembly order
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForItemWithAutomaticExtTextsEnabledAndExtendedTextDisabled()
    // [FEATURE] Extended Text on blanket assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0069] Add to blanket assembly order line for item with "Automatic Ext. Texts" enabled and extended text disabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" enabled and extended text disabled for blanket assembly order
        ItemNo := CreateItemWithExtendedText(EnableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add item line to blanket assembly order page
        AddItemLineToBlanketAssemblyOrderPage(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForItemWithExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0013] Insert extended texts for item with extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with item line
        AssemblyDocNo := CreateBlanketAssemblyOrderWithItemLine(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] Extended text lines are added to blanket assembly order
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure InsertExtendedTextsForItemWithNoExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0014] Insert extended texts for item with no extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text disabled for blanket assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Blanket assembly order with item line
        AssemblyDocNo := CreateBlanketAssemblyOrderWithItemLine(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForItemWithExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0023] Insert extended texts twice for item with extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with item line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] No additional extended text lines are added to blanket assembly order
        VerifyNoAdditionalExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure ReplaceItemWithExtendedTextsByItemWithoutExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: array[2] of Code[20];
    begin
        // [SCENARIO #0024] Replace item with extended texts by item without extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ItemNo[1] := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Item with no extended text
        ItemNo[2] := CreateItemWithNoExtendedText();
        // [GIVEN] Blanket assembly order with item line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo[1]);

        // [WHEN] Replace item by item with no extended text
        ReplaceItemByItemWithNoExtendedTextOnBlanketAssemblyOrderPage(AssemblyDocNo, ItemNo);

        // [THEN] Item is replaced and extended text lines are removed
        VerifyItemIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure DeleteItemLineWithExtendedText()
    // [FEATURE] Extended Text on blanket assembly order/Delete item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0015] Delete item line with extended text
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with item line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo);

        // [WHEN] Delete item line from blanket assembly order
        DeleteItemLineFromBlanketAssemblyOrder(AssemblyDocNo, ItemNo);

        // [THEN] Item  and extended text lines are removed
        VerifyItemAndExtendedTextLinesAreRemoved(AssemblyDocNo, ItemNo);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extend. Text BAO Item Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extend. Text BAO Item Line FLX");

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extend. Text BAO Item Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddItemLineToBlanketAssemblyOrderPage(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        BlanketAssemblyOrderPage: TestPage "Blanket Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);

        BlanketAssemblyOrderPage.OpenEdit();
        BlanketAssemblyOrderPage.GoToRecord(AssemblyHeader);
        BlanketAssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Item);
        BlanketAssemblyOrderPage.Lines."No.".SetValue(ItemNo);
        BlanketAssemblyOrderPage.Close();
    end;

    local procedure CreateBlanketAssemblyOrder(): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.CreateBlanketAssemblyOrder(AssemblyHeader, WorkDate(), '', '', 1);
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateBlanketAssemblyOrderWithItemLine(ItemNo: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryExtTextAssDoc.CreateBlanketAssemblyOrder(AssemblyHeader, WorkDate(), '', '', 1);
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::Item, ItemNo, LibraryExtTextAssDoc.CreateItemUnitOfMeasureCode(ItemNo), 1, 1, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateBlanketAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateBlanketAssemblyOrderWithItemLine(ItemNo);
        InsertExtendedText(AssemblyDocNo, ItemNo);
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ItemNo);
        exit(AssemblyDocNo);
    end;

    local procedure CreateItemWithNoExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateItemWithNoExtendedText());
    end;

    local procedure CreateItemWithExtendedText(AutomaticExtTextsEnabled: Boolean; EnableExtText: Option None,Order,Quote,"Blanket Order"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateItemWithExtendedText(AutomaticExtTextsEnabled, EnableExtText));
    end;

    local procedure DeleteItemLineFromBlanketAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure ReplaceItemByItemWithNoExtendedTextOnBlanketAssemblyOrderPage(AssemblyDocNo: Code[20]; ItemNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        BlanketAssemblyOrderPage: TestPage "Blanket Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Item, ItemNo[1], AssemblyLine);

        BlanketAssemblyOrderPage.OpenEdit();
        BlanketAssemblyOrderPage.GoToRecord(AssemblyHeader);
        BlanketAssemblyOrderPage.Lines.GoToRecord(AssemblyLine);
        BlanketAssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Item);
        BlanketAssemblyOrderPage.Lines."No.".SetValue(ItemNo[2]);
        BlanketAssemblyOrderPage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure VerifyItemAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyItemAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, ItemNo);
    end;

    local procedure VerifyItemIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ItemNo: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;


    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    local procedure VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);
    end;

    local procedure DisableAutomaticExtTexts(): Boolean
    begin
        exit(false);
    end;

    local procedure EnableAutomaticExtTexts(): Boolean
    begin
        exit(true);
    end;

    local procedure DisableExtTextForAssemblyDocument(): Integer
    begin
        exit(0);
    end;

    local procedure EnableExtTextForBlanketAssemblyOrder(): Integer
    begin
        exit(1);
    end;

    var
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
}