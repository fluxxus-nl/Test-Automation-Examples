codeunit 76459 "Extend. Text BAO Text Line FLX"
{
    // Generated on 06/07/2020 at 09:09 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on blanket assembly order/Add text line
        // [FEATURE] Extended Text on blanket assembly order/Delete text line
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForTextWithExtendedTextEnabled()
    // [FEATURE] Extended Text on blanket assembly order/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0060] Add to blanket assembly order line for text with extended text enabled
        Initialize();

        // [GIVEN] Standard text with extended text enabled for blanket assembly order
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add text line to blanket assembly order page
        AddTextLineToBlanketAssemblyOrderPage(AssemblyDocNo, TextCode);

        // [THEN] Extended text lines are added to blanket assembly order
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, TextCode);
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForTextWithExtendedTextDisabled()
    // [FEATURE] Extended Text on blanket assembly order/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0075] Add to blanket assembly order line for text with extended text disabled
        Initialize();

        // [GIVEN] Standard text with extended text disabled for blanket assembly order
        TextCode := CreateStandardTextWithExtendedText(DisableExtTextForAssemblyDocument());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add text line to blanket assembly order page
        AddTextLineToBlanketAssemblyOrderPage(AssemblyDocNo, TextCode);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForTextWithExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0062] Insert extended texts for text with extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Standard text with extended text disabled for blanket assembly order
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with text line
        AssemblyDocNo := CreateBlanketAssemblyOrderWithTextLine(TextCode);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, TextCode);

        // [THEN] Extended text lines are added to blanket assembly order
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, TextCode);
    end;

    [Test]
    procedure InsertExtendedTextsForTextWithNoExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0063] Insert extended texts for text with no extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Standard text with extended text disabled for blanket assembly order
        TextCode := CreateStandardTextWithExtendedText(DisableExtTextForAssemblyDocument());
        // [GIVEN] Blanket assembly order with text line
        AssemblyDocNo := CreateBlanketAssemblyOrderWithTextLine(TextCode);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, TextCode);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForTextWithExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0064] Insert extended texts twice for text with extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Standard text with extended text enabled for blanket assembly order
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with text line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithTextLineAndExtendedTextInserted(TextCode);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, TextCode);

        // [THEN] No additional extended text lines are added to blanket assembly order
        VerifyNoAdditionalExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, TextCode);
    end;

    [Test]
    procedure ReplaceTextWithExtendedTextsByTextWithoutExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: array[2] of Code[20];
    begin
        // [SCENARIO #0065] Replace text with extended texts by text without extended texts on blanket assembly order line
        Initialize();

        // [GIVEN] Standard text with extended text enabled for blanket assembly order
        TextCode[1] := CreateStandardTextWithExtendedText(EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Standard text with no extended text
        TextCode[2] := CreateStandardTextWithNoExtendedText();
        // [GIVEN] Blanket assembly order with text line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithTextLineAndExtendedTextInserted(TextCode[1]);

        // [WHEN] Replace text by text with no extended text
        ReplaceTextByTextWithNoExtendedTextOnBlanketAssemblyOrderPage(AssemblyDocNo, TextCode);

        // [THEN] Text is replaced and extended text lines are removed
        VerifyTextIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, TextCode);
    end;

    [Test]
    procedure DeleteTextLineWithExtendedText()
    // [FEATURE] Extended Text on blanket assembly order/Delete text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0066] Delete text line with extended text
        Initialize();

        // [GIVEN] Standard text with extended text enabled for blanket assembly order
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with text line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithTextLineAndExtendedTextInserted(TextCode);

        // [WHEN] Delete text line from blanket assembly order
        DeleteTextLineFromBlanketAssemblyOrder(AssemblyDocNo, TextCode);

        // [THEN] Text  and extended text lines are removed
        VerifyTextAndExtendedTextLinesAreRemoved(AssemblyDocNo, TextCode);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extend. Text BAO Text Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extend. Text BAO Text Line FLX");

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extend. Text BAO Text Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddTextLineToBlanketAssemblyOrderPage(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        BlanketAssemblyOrderPage: TestPage "Blanket Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);

        BlanketAssemblyOrderPage.OpenEdit();
        BlanketAssemblyOrderPage.GoToRecord(AssemblyHeader);
        BlanketAssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::" ");
        BlanketAssemblyOrderPage.Lines."No.".SetValue(TextCode);
        BlanketAssemblyOrderPage.Close();
    end;

    local procedure CreateBlanketAssemblyOrder(): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        AssemblyHeader."Document Type" := AssemblyHeader."Document Type"::"Blanket Order";
        AssemblyHeader.Insert(true);
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateBlanketAssemblyOrderWithTextLine(TextCode: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryExtTextAssDoc.CreateBlanketAssemblyOrder(AssemblyHeader, WorkDate(), '', '', 1);
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::" ", TextCode, '', 0, 0, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateBlanketAssemblyOrderWithTextLineAndExtendedTextInserted(TextCode: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateBlanketAssemblyOrderWithTextLine(TextCode);
        InsertExtendedText(AssemblyDocNo, TextCode);
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, TextCode);
        exit(AssemblyDocNo);
    end;

    local procedure CreateStandardTextWithNoExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateStandardTextWithNoExtendedText());
    end;

    local procedure CreateStandardTextWithExtendedText(AssemblyDocumentType: Enum "Assembly Document Type"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateStandardTextWithExtendedText(AssemblyDocumentType));
    end;

    local procedure DeleteTextLineFromBlanketAssemblyOrder(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure ReplaceTextByTextWithNoExtendedTextOnBlanketAssemblyOrderPage(AssemblyDocNo: Code[20]; TextCode: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        BlanketAssemblyOrderPage: TestPage "Blanket Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::" ", TextCode[1], AssemblyLine);

        BlanketAssemblyOrderPage.OpenEdit();
        BlanketAssemblyOrderPage.GoToRecord(AssemblyHeader);
        BlanketAssemblyOrderPage.Lines.GoToRecord(AssemblyLine);
        BlanketAssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::" ");
        BlanketAssemblyOrderPage.Lines."No.".SetValue(TextCode[2]);
        BlanketAssemblyOrderPage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure VerifyTextAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyTextAndExtendedTextLinesAreRemoved(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo, TextCode);
    end;

    local procedure VerifyTextIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; TextCode: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20]; TextCode: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, TextCode);
    end;

    local procedure VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);
    end;

    local procedure DisableExtTextForAssemblyDocument(): Enum "Assembly Document Type"
    begin
        exit("Assembly Document Type"::None);
    end;

    local procedure EnableExtTextForBlanketAssemblyOrder(): Enum "Assembly Document Type"
    begin
        exit("Assembly Document Type"::"Blanket Order");
    end;

    var
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
}