codeunit 76452 "Extended Text AQ Item Line FLX"
{
    // Generated on 05/07/2020 at 10:58 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on assembly quote/Add item line
        // [FEATURE] Extended Text on assembly quote/Delete item line
    end;

    [Test]
    procedure AddToAssemblyQuoteLineForItemWithAutomaticExtTextsDisabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly quote/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0006] Add to assembly quote line for item with "Automatic Ext. Texts"disabled and extended text enabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add item line to assembly quote page
        AddItemLineToAssemblyQuotePage(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure AddToAssemblyQuoteLineForItemWithAutomaticExtTextsEnabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly quote/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0007] Add to assembly quote line for item with "Automatic Ext. Texts" enabled and extended text enabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" enabled and extended text enabled for assembly quote
        ItemNo := CreateItemWithExtendedText(EnableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add item line to assembly quote page
        AddItemLineToAssemblyQuotePage(AssemblyDocNo, ItemNo);

        // [THEN] Extended text lines are added to assembly quote
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure AddToAssemblyQuoteLineForItemWithAutomaticExtTextsEnabledAndExtendedTextDisabled()
    // [FEATURE] Extended Text on assembly quote/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0068] Add to assembly quote line for item with "Automatic Ext. Texts" enabled and extended text disabled
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" enabled and extended text disabled for assembly quote
        ItemNo := CreateItemWithExtendedText(EnableAutomaticExtTexts(), DisableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add item line to assembly quote page
        AddItemLineToAssemblyQuotePage(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForItemWithExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0008] Insert extended texts for item with extended texts on assembly quote line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with item line
        AssemblyDocNo := CreateAssemblyQuoteWithItemLine(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] Extended text lines are added to assembly quote
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure InsertExtendedTextsForItemWithNoExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0009] Insert extended texts for item with no extended texts on assembly quote line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text disabled for assembly quote
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), DisableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with item line
        AssemblyDocNo := CreateAssemblyQuoteWithItemLine(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForItemWithExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0021] Insert extended texts twice for item with extended texts on assembly quote line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with item line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithItemLineAndExtendedTextInserted(ItemNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ItemNo);

        // [THEN] No additional extended text lines are added to assembly quote
        VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure ReplaceItemWithExtendedTextsByItemWithoutExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: array[2] of Code[20];
    begin
        // [SCENARIO #0022] Replace item with extended texts by item without extended texts on assembly quote line
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ItemNo[1] := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Item with no extended text
        ItemNo[2] := CreateItemWithNoExtendedText();
        // [GIVEN] Assembly quote with item line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithItemLineAndExtendedTextInserted(ItemNo[1]);

        // [WHEN] Replace item by item with no extended text
        ReplaceItemByItemWithNoExtendedTextOnAssemblyQuotePage(AssemblyDocNo, ItemNo);

        // [THEN] Item is replaced and extended text lines are removed
        VerifyItemIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, ItemNo);
    end;

    [Test]
    procedure DeleteItemLineWithExtendedText()
    // [FEATURE] Extended Text on assembly quote/Delete item line
    var
        AssemblyDocNo: Code[20];
        ItemNo: Code[20];
    begin
        // [SCENARIO #0010] Delete item line with extended text
        Initialize();

        // [GIVEN] Item with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ItemNo := CreateItemWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with item line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithItemLineAndExtendedTextInserted(ItemNo);

        // [WHEN] Delete item line from assembly quote
        DeleteItemLineFromAssemblyQuote(AssemblyDocNo, ItemNo);

        // [THEN] Item  and extended text lines are removed
        VerifyItemAndExtendedTextLinesAreRemoved(AssemblyDocNo, ItemNo);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text AQ Item Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text AQ Item Line FLX");

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text AQ Item Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddItemLineToAssemblyQuotePage(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyQuotePage: TestPage "Assembly Quote";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);

        AssemblyQuotePage.OpenEdit();
        AssemblyQuotePage.GoToRecord(AssemblyHeader);
        AssemblyQuotePage.Lines.Type.SetValue(AssemblyLine.Type::Item);
        AssemblyQuotePage.Lines."No.".SetValue(ItemNo);
        AssemblyQuotePage.Close();
    end;

    local procedure CreateAssemblyQuote(): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        AssemblyHeader."Document Type" := AssemblyHeader."Document Type"::Quote;
        AssemblyHeader.Insert(true);
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyQuoteWithItemLine(ItemNo: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryAssembly.CreateAssemblyQuote(AssemblyHeader, WorkDate(), '', '', 1, '');
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::Item, ItemNo, LibraryExtTextAssDoc.CreateItemUnitOfMeasureCode(ItemNo), 1, 1, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyQuoteWithItemLineAndExtendedTextInserted(ItemNo: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateAssemblyQuoteWithItemLine(ItemNo);
        InsertExtendedText(AssemblyDocNo, ItemNo);
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ItemNo);
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

    local procedure DeleteItemLineFromAssemblyQuote(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure ReplaceItemByItemWithNoExtendedTextOnAssemblyQuotePage(AssemblyDocNo: Code[20]; ItemNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyQuotePage: TestPage "Assembly Quote";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo[1], AssemblyLine);

        AssemblyQuotePage.OpenEdit();
        AssemblyQuotePage.GoToRecord(AssemblyHeader);
        AssemblyQuotePage.Lines.GoToRecord(AssemblyLine);
        AssemblyQuotePage.Lines.Type.SetValue(AssemblyLine.Type::Item);
        AssemblyQuotePage.Lines."No.".SetValue(ItemNo[2]);
        AssemblyQuotePage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;

    local procedure VerifyItemAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyItemAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Quote, AssemblyDocNo, ItemNo);
    end;

    local procedure VerifyItemIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ItemNo: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
    end;


    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20]; ItemNo: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ItemNo);
    end;

    local procedure VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);
    end;

    local procedure DisableAutomaticExtTexts(): Boolean
    begin
        exit(false);
    end;

    local procedure EnableAutomaticExtTexts(): Boolean
    begin
        exit(true);
    end;

    local procedure DisableExtTextForAssemblyQuote(): Enum "Assembly Document Type"
    begin
        exit("Assembly Document Type"::None);
    end;

    local procedure EnableExtTextForAssemblyQuote(): Enum "Assembly Document Type"
    begin
        exit("Assembly Document Type"::Quote);
    end;

    var
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
}