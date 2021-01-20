codeunit 76458 "Extended Text AQ Text Line FLX"
{
    // Generated on 06/07/2020 at 08:16 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on assembly quote/Add text line
        // [FEATURE] Extended Text on assembly quote/Delete text line
    end;

    [Test]
    procedure AddToAssemblyQuoteLineForTextWithExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly quote/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0053] Add to assembly quote line for text with extended text enabled
        Initialize();

        // [GIVEN] Standard text with extended text enabled for assembly quote
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add text line to assembly quote page
        AddTextLineToAssemblyQuotePage(AssemblyDocNo, TextCode);

        // [THEN] Extended text lines are added to assembly quote
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, TextCode);
    end;


    [Test]
    procedure AddToAssemblyQuoteLineForTextWithExtendedTextDisabled()
    // [FEATURE] Extended Text on assembly quote/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0074] Add to assembly quote line for text with extended text disabled
        Initialize();

        // [GIVEN] Standard text with extended text disabled for assembly quote
        TextCode := CreateStandardTextWithExtendedText(DisableExtTextForAssemblyDocument());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add text line to assembly quote page
        AddTextLineToAssemblyQuotePage(AssemblyDocNo, TextCode);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForTextWithExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0055] Insert extended texts for text with extended texts on assembly quote line
        Initialize();

        // [GIVEN] Standard text with extended text disabled for assembly quote
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with text line
        AssemblyDocNo := CreateAssemblyQuoteWithTextLine(TextCode);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, TextCode);

        // [THEN] Extended text lines are added to assembly quote
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, TextCode);
    end;

    [Test]
    procedure InsertExtendedTextsForTextWithNoExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0056] Insert extended texts for text with no extended texts on assembly quote line
        Initialize();

        // [GIVEN] Standard text with extended text disabled for assembly quote
        TextCode := CreateStandardTextWithExtendedText(DisableExtTextForAssemblyDocument());
        // [GIVEN] Assembly quote with text line
        AssemblyDocNo := CreateAssemblyQuoteWithTextLine(TextCode);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, TextCode);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForTextWithExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0057] Insert extended texts twice for text with extended texts on assembly quote line
        Initialize();

        // [GIVEN] Standard text with extended text enabled for assembly quote
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with text line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithTextLineAndExtendedTextInserted(TextCode);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, TextCode);

        // [THEN] No additional extended text lines are added to assembly quote
        VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, TextCode);
    end;

    [Test]
    procedure ReplaceTextWithExtendedTextsByTextWithoutExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add text line
    var
        AssemblyDocNo: Code[20];
        TextCode: array[2] of Code[20];
    begin
        // [SCENARIO #0058] Replace text with extended texts by text without extended texts on assembly quote line
        Initialize();

        // [GIVEN] Standard text with extended text enabled for assembly quote
        TextCode[1] := CreateStandardTextWithExtendedText(EnableExtTextForAssemblyQuote());
        // [GIVEN] Standard text with no extended text
        TextCode[2] := CreateStandardTextWithNoExtendedText();
        // [GIVEN] Assembly quote with text line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithTextLineAndExtendedTextInserted(TextCode[1]);

        // [WHEN] Replace text by text with no extended text
        ReplaceTextByTextWithNoExtendedTextOnAssemblyQuotePage(AssemblyDocNo, TextCode);

        // [THEN] Text is replaced and extended text lines are removed
        VerifyTextIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, TextCode);
    end;

    [Test]
    procedure DeleteTextLineWithExtendedText()
    // [FEATURE] Extended Text on assembly quote/Delete text line
    var
        AssemblyDocNo: Code[20];
        TextCode: Code[20];
    begin
        // [SCENARIO #0059] Delete text line with extended text
        Initialize();

        // [GIVEN] Standard text with extended text enabled for assembly quote
        TextCode := CreateStandardTextWithExtendedText(EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with text line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithTextLineAndExtendedTextInserted(TextCode);

        // [WHEN] Delete text line from assembly quote
        DeleteTextLineFromAssemblyQuote(AssemblyDocNo, TextCode);

        // [THEN] Text  and extended text lines are removed
        VerifyTextAndExtendedTextLinesAreRemoved(AssemblyDocNo, TextCode);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text AQ Text Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text AQ Text Line FLX");

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text AQ Text Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddTextLineToAssemblyQuotePage(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyQuotePage: TestPage "Assembly Quote";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);

        AssemblyQuotePage.OpenEdit();
        AssemblyQuotePage.GoToRecord(AssemblyHeader);
        AssemblyQuotePage.Lines.Type.SetValue(AssemblyLine.Type::" ");
        AssemblyQuotePage.Lines."No.".SetValue(TextCode);
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

    local procedure CreateAssemblyQuoteWithTextLine(TextCode: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryAssembly.CreateAssemblyQuote(AssemblyHeader, WorkDate(), '', '', 1, '');
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::" ", TextCode, '', 0, 0, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyQuoteWithTextLineAndExtendedTextInserted(TextCode: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateAssemblyQuoteWithTextLine(TextCode);
        InsertExtendedText(AssemblyDocNo, TextCode);
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, TextCode);
        exit(AssemblyDocNo);
    end;

    local procedure CreateStandardTextWithNoExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateStandardTextWithNoExtendedText());
    end;

    local procedure CreateStandardTextWithExtendedText(EnableExtText: Option None,Order,Quote,"Blanket Order"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateStandardTextWithExtendedText(EnableExtText));
    end;

    local procedure DeleteTextLineFromAssemblyQuote(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure ReplaceTextByTextWithNoExtendedTextOnAssemblyQuotePage(AssemblyDocNo: Code[20]; TextCode: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyQuotePage: TestPage "Assembly Quote";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::" ", TextCode[1], AssemblyLine);

        AssemblyQuotePage.OpenEdit();
        AssemblyQuotePage.GoToRecord(AssemblyHeader);
        AssemblyQuotePage.Lines.GoToRecord(AssemblyLine);
        AssemblyQuotePage.Lines.Type.SetValue(AssemblyLine.Type::" ");
        AssemblyQuotePage.Lines."No.".SetValue(TextCode[2]);
        AssemblyQuotePage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure VerifyTextAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyTextAndExtendedTextLinesAreRemoved(AssemblyHeader."Document Type"::Quote, AssemblyDocNo, TextCode);
    end;

    local procedure VerifyTextIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; TextCode: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
    end;

    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20]; TextCode: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, TextCode);
    end;

    local procedure VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);
    end;

    local procedure DisableExtTextForAssemblyDocument(): Integer
    begin
        exit(0);
    end;

    local procedure EnableExtTextForAssemblyQuote(): Integer
    begin
        exit(2);
    end;

    var
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
}