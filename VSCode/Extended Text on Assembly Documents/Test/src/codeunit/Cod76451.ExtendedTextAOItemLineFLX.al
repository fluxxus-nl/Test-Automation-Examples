codeunit 76451 "Extended Text AO Item Line FLX"
{
    // Generated on 29/06/2020 at 10:44 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on assembly order/Add item line
        // [FEATURE] Extended Text on assembly order/Delete item line
    end;

    [Test]
    procedure AddToAssemblyOrderLineForItemWithAutomaticExtTextsDisabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0001] Add to assembly order line for item with "Automatic Ext. Texts"disabled and extended text enabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order
        AssemblyDocNo := CreateAssemblyOrder();

        // [WHEN] Add item line to assembly order
        AddItemLineToAssemblyOrder(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to assembly order
        VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo);

    end;

    [Test]
    procedure AddToAssemblyOrderLineForItemWithAutomaticExtTextsEnabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0002] Add to assembly order line for item with "Automatic Ext. Texts" enabled and extended text enabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" enabled and extended text enabled for assembly order
        ItemNo := CreateItemWithExtendedText(EnableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order
        AssemblyDocNo := CreateAssemblyOrder();

        // [WHEN] Add item line to assembly order
        AddItemLineToAssemblyOrder(AssemblyDocNo, ItemNo);

        // [THEN] Extended text lines are added to assembly order
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure AddToAssemblyOrderLineForItemWithAutomaticExtTextsEnabledAndExtendedTextDisabled()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0067] Add to assembly order line for item with "Automatic Ext. Texts" enabled and extended text disabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" enabled and extended text disabled for assembly order
        ItemNo := CreateItemWithExtendedText(EnableAutomaticExtTexts(), DisableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order
        AssemblyDocNo := CreateAssemblyOrder();

        // [WHEN] Add item line to assembly order
        AddItemLineToAssemblyOrder(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to assembly order
        VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForItemWithExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0003] Insert extended texts for item with extended texts on assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with item line
        AssemblyDocNo := CreateAssemblyOrderWithItemLine(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] Extended text lines are added to assembly order
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure InsertExtendedTextsForItemWithNoExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0004] Insert extended texts for item with no extended texts on assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text disabled for assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), DisableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with item line
        AssemblyDocNo := CreateAssemblyOrderWithItemLine(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to assembly order
        VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForItemWithExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0019] Insert extended texts twice for item with extended texts on assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with item line and extended text inserted
        AssemblyDocNo := CreateAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] No additional extended text lines are added to assembly order
        VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyOrder();
    end;

    [Test]
    procedure ReplaceItemWithExtendedTextsByItemWithoutExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0020] Replace item with extended texts by item without extended texts on assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with item line and extended text inserted
        AssemblyDocNo := CreateAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo);

        // [WHEN] Replace item by item with no extended text
        ReplaceItemByItemWithNoExtendedText();

        // [THEN] Item is replaced and extended text lines are removed
        VerifyItemIsReplacedAndExtendedTextLinesAreRemoved();
    end;

    [Test]
    procedure DeleteItemLineWithExtendedText()
    // [FEATURE] Extended Text on assembly order/Delete item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0005] Delete item line with extended text
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with item line and extended text inserted
        AssemblyDocNo := CreateAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo);

        // [WHEN] Delete item line from assembly order
        DeleteItemLineFromAssemblyOrder();

        // [THEN] Item  and extended text lines are removed
        VerifyItemAndExtendedTextLinesAreRemoved();
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text AO Item Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text AO Item Line FLX");

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text AO Item Line FLX");
    end;

    local procedure AddItemLineToAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyDocNo);
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::Item, ItemNo, CreateItemUnitOfMeasureCode(ItemNo), 1, 1, '');
    end;

    local procedure CreateItemUnitOfMeasureCode(ItemNo: Code[20]): Code[10]
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItemUnitOfMeasureCode(ItemUnitOfMeasure, ItemNo, 1);
        exit(ItemUnitOfMeasure.Code);
    end;

    local procedure CreateAssemblyOrder(): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        AssemblyHeader."Document Type" := AssemblyHeader."Document Type"::Order;
        AssemblyHeader.Insert(true);
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyOrderWithItemLine(ItemNo: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryAssembly.CreateAssemblyHeader(AssemblyHeader, WorkDate(), '', '', 1, '');
        AddItemLineToAssemblyOrder(AssemblyHeader."No.", ItemNo);
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateAssemblyOrderWithItemLine(ItemNo);
        InsertExtendedText(AssemblyDocNo, ItemNo);
    end;

    local procedure CreateItemWithExtendedText(AutomaticExtTextsEnabled: Boolean; AssemblyDocumentType: Option " ",Order,Quote,"Blanket Order"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateItemWithExtendedText(AutomaticExtTextsEnabled, AssemblyDocumentType));
    end;

    local procedure DeleteItemLineFromAssemblyOrder()
    begin
        Error('DeleteItmLineFromAssemblyOrder not implemented.')
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
        TransferExtendedText: Codeunit "Transfer Extended Text FLX";
    begin
        AssemblyLine.SetRange("Document Type", AssemblyLine."Document Type"::Order);
        AssemblyLine.SetRange("Document No.", AssemblyDocNo);
        AssemblyLine.SetRange(Type, AssemblyLine.Type::Item);
        AssemblyLine.SetRange("No.", ItemNo);
        AssemblyLine.FindFirst();

        TransferExtendedText.AssemblyCheckIfAnyExtText(AssemblyLine, true);
        TransferExtendedText.InsertAssemblyExtText(AssemblyLine);
    end;

    local procedure ReplaceItemByItemWithNoExtendedText()
    begin
        Error('ReplaceItemByItemWithNoExtendedText not implemented.')
    end;

    local procedure VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
    begin
        ExtendedTextHeader.SetRange(ExtendedTextHeader."Table Name", ExtendedTextHeader."Table Name"::Item);
        ExtendedTextHeader.SetRange("No.", ItemNo);
        ExtendedTextHeader.FindFirst();

        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyDocNo);
        AssemblyLine.SetRange("Document Type", AssemblyLine."Document Type"::Order);
        AssemblyLine.SetRange("Document No.", AssemblyDocNo);
        AssemblyLine.SetRange(Type, AssemblyLine.Type::" ");
        AssemblyLine.FindSet();
        repeat
            ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
            ExtendedTextLine.SetRange("No.", ItemNo);
            ExtendedTextLine.SetRange(Text, AssemblyLine.Description);
            Assert.RecordIsNotEmpty(ExtendedTextLine);
        until AssemblyLine.Next() = 0;
    end;

    local procedure VerifyItemAndExtendedTextLinesAreRemoved()
    begin
        Error('VerifyItemAndExtendedTextLinesAreRemoved not implemented.')
    end;

    local procedure VerifyItemIsReplacedAndExtendedTextLinesAreRemoved()
    begin
        Error('VerifyItemIsReplacedAndExtendedTextLinesAreRemoved not implemented.')
    end;

    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyOrder()
    begin
        Error('VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyOrder not implemented.')
    end;

    local procedure VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyDocNo);
        AssemblyLine.SetRange("Document Type", AssemblyLine."Document Type"::Order);
        AssemblyLine.SetRange("Document No.", AssemblyDocNo);
        AssemblyLine.SetRange(Type, AssemblyLine.Type::" ");
        Assert.RecordIsEmpty(AssemblyLine);
    end;

    local procedure DisableAutomaticExtTexts(): Boolean
    begin
        exit(false);
    end;

    local procedure EnableAutomaticExtTexts(): Boolean
    begin
        exit(false);
    end;

    local procedure DisableExtTextForAssemblyOrder(): Integer
    begin
        exit(0);
    end;

    local procedure EnableExtTextForAssemblyOrder(): Integer
    begin
        exit(1);
    end;

    var
        Assert: Codeunit Assert;
        LibraryAssembly: Codeunit "Library - Assembly";
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;

}