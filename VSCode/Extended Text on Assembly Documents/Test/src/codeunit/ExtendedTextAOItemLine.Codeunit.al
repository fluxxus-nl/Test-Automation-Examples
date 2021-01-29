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

        // [WHEN] Add item line to assembly order page
        AddItemLineToAssemblyOrderPage(AssemblyDocNo, ItemNo);

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

        // [WHEN] Add item line to assembly order page
        AddItemLineToAssemblyOrderPage(AssemblyDocNo, ItemNo);

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
        ItemNo := CreateItemWithExtendedText(EnableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Assembly order
        AssemblyDocNo := CreateAssemblyOrder();

        // [WHEN] Add item line to assembly order page
        AddItemLineToAssemblyOrderPage(AssemblyDocNo, ItemNo);

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
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
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
        VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure ReplaceItemWithExtendedTextsByItemWithoutExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: array[2] of Code[20];
    begin
        // [SCENARIO #0020] Replace item with extended texts by item without extended texts on assembly order line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ItemNo[1] := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Item with no extended text
        ItemNo[2] := CreateItemWithNoExtendedText();
        // [GIVEN] Assembly order with item line and extended text inserted
        AssemblyDocNo := CreateAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo[1]);

        // [WHEN] Replace item by item with no extended text
        ReplaceItemByItemWithNoExtendedTextOnAssemblyOrderPage(AssemblyDocNo, ItemNo);

        // [THEN] Item is replaced and extended text lines are removed
        VerifyItemIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, ItemNo);
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
        DeleteItemLineFromAssemblyOrder(AssemblyDocNo, ItemNo);

        // [THEN] Item  and extended text lines are removed
        VerifyItemAndExtendedTextLinesAreRemoved(AssemblyDocNo, ItemNo);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text AO Item Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text AO Item Line FLX");

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text AO Item Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddItemLineToAssemblyOrderPage(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyOrderPage: TestPage "Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyDocNo);

        AssemblyOrderPage.OpenEdit();
        AssemblyOrderPage.GoToRecord(AssemblyHeader);
        AssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Item);
        AssemblyOrderPage.Lines."No.".SetValue(ItemNo);
        AssemblyOrderPage.Close();
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
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryAssembly.CreateAssemblyHeader(AssemblyHeader, WorkDate(), '', '', 1, '');
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::Item, ItemNo, LibraryExtTextAssDoc.CreateItemUnitOfMeasureCode(ItemNo), 1, 1, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyOrderWithItemLineAndExtendedTextInserted(ItemNo: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateAssemblyOrderWithItemLine(ItemNo);
        InsertExtendedText(AssemblyDocNo, ItemNo);
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ItemNo);
        exit(AssemblyDocNo);
    end;

    local procedure CreateItemWithNoExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateItemWithNoExtendedText());
    end;

    local procedure CreateItemWithExtendedText(AutomaticExtTextsEnabled: Boolean; EnableExtText: Enum "Assembly Document Type"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateItemWithExtendedText(AutomaticExtTextsEnabled, EnableExtText));
    end;

    local procedure DeleteItemLineFromAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure ReplaceItemByItemWithNoExtendedTextOnAssemblyOrderPage(AssemblyDocNo: Code[20]; ItemNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyOrderPage: TestPage "Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo[1], AssemblyLine);

        AssemblyOrderPage.OpenEdit();
        AssemblyOrderPage.GoToRecord(AssemblyHeader);
        AssemblyOrderPage.Lines.GoToRecord(AssemblyLine);
        AssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Item);
        AssemblyOrderPage.Lines."No.".SetValue(ItemNo[2]);
        AssemblyOrderPage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure VerifyItemAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyItemAndExtendedTextLinesAreRemoved(AssemblyHeader."Document Type"::Order, AssemblyDocNo, ItemNo);
    end;

    local procedure VerifyItemIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ItemNo: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ItemNo);
    end;

    local procedure VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(AssemblyHeader."Document Type"::Order, AssemblyDocNo);
    end;

    local procedure DisableAutomaticExtTexts(): Boolean
    begin
        exit(false);
    end;

    local procedure EnableAutomaticExtTexts(): Boolean
    begin
        exit(true);
    end;

    local procedure DisableExtTextForAssemblyDocument(): Enum "Assembly Document Type"
    begin
        exit("Assembly Document Type"::None);
    end;

    local procedure EnableExtTextForAssemblyOrder(): Enum "Assembly Document Type"
    begin
        exit("Assembly Document Type"::Order);
    end;

    var
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
}