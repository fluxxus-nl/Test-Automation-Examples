codeunit 76455 "Extended Text AQ Res. Line FLX"
{
    // Generated on 29/06/2020 at 10:44 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on assembly quote/Add resource line
        // [FEATURE] Extended Text on assembly quote/Delete resource line
    end;

    [Test]
    procedure AddToAssemblyQuoteLineForResourceWithAutomaticExtTextsDisabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly quote/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0032] Add to assembly quote line for resource with "Automatic Ext. Texts"disabled and extended text enabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add resource line to assembly quote page
        AddResourceLineToAssemblyQuotePage(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure AddToAssemblyQuoteLineForResourceWithAutomaticExtTextsEnabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly quote/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0033] Add to assembly quote line for resource with "Automatic Ext. Texts" enabled and extended text enabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" enabled and extended text enabled for assembly quote
        ResourceNo := CreateResourceWithExtendedText(EnableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add resource line to assembly quote page
        AddResourceLineToAssemblyQuotePage(AssemblyDocNo, ResourceNo);

        // [THEN] Extended text lines are added to assembly quote
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure AddToAssemblyQuoteLineForResourceWithAutomaticExtTextsEnabledAndExtendedTextDisabled()
    // [FEATURE] Extended Text on assembly quote/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0071] Add to assembly quote line for resource with "Automatic Ext. Texts" enabled and extended text disabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" enabled and extended text disabled for assembly quote
        ResourceNo := CreateResourceWithExtendedText(EnableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Assembly quote
        AssemblyDocNo := CreateAssemblyQuote();

        // [WHEN] Add resource line to assembly quote page
        AddResourceLineToAssemblyQuotePage(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForResourceWithExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0034] Insert extended texts for resource with extended texts on assembly quote line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with resource line
        AssemblyDocNo := CreateAssemblyQuoteWithResourceLine(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] Extended text lines are added to assembly quote
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure InsertExtendedTextsForResourceWithNoExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0035] Insert extended texts for resource with no extended texts on assembly quote line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text disabled for assembly quote
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Assembly quote with resource line
        AssemblyDocNo := CreateAssemblyQuoteWithResourceLine(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to assembly quote
        VerifyNoExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForResourceWithExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0036] Insert extended texts twice for resource with extended texts on assembly quote line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with resource line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithResourceLineAndExtendedTextInserted(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] No additional extended text lines are added to assembly quote
        VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure ReplaceResourceWithExtendedTextsByResourceWithoutExtendedTextsOnAssemblyQuoteLine()
    // [FEATURE] Extended Text on assembly quote/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: array[2] of Code[20];
    begin
        // [SCENARIO #0037] Replace resource with extended texts by resource without extended texts on assembly quote line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ResourceNo[1] := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Resource with no extended text
        ResourceNo[2] := CreateResourceWithNoExtendedText();
        // [GIVEN] Assembly quote with resource line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithResourceLineAndExtendedTextInserted(ResourceNo[1]);

        // [WHEN] Replace resource by resource with no extended text
        ReplaceResourceByResourceWithNoExtendedTextOnAssemblyQuotePage(AssemblyDocNo, ResourceNo);

        // [THEN] Resource is replaced and extended text lines are removed
        VerifyResourceIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure DeleteResourceLineWithExtendedText()
    // [FEATURE] Extended Text on assembly quote/Delete resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0038] Delete resource line with extended text
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly quote
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyQuote());
        // [GIVEN] Assembly quote with resource line and extended text inserted
        AssemblyDocNo := CreateAssemblyQuoteWithResourceLineAndExtendedTextInserted(ResourceNo);

        // [WHEN] Delete resource line from assembly quote
        DeleteResourceLineFromAssemblyQuote(AssemblyDocNo, ResourceNo);

        // [THEN] Resource  and extended text lines are removed
        VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyDocNo, ResourceNo);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text AQ Res. Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text AQ Res. Line FLX");

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text AQ Res. Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddResourceLineToAssemblyQuotePage(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyQuotePage: TestPage "Assembly Quote";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);

        AssemblyQuotePage.OpenEdit();
        AssemblyQuotePage.GoToRecord(AssemblyHeader);
        AssemblyQuotePage.Lines.Type.SetValue(AssemblyLine.Type::Resource);
        AssemblyQuotePage.Lines."No.".SetValue(ResourceNo);
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

    local procedure CreateAssemblyQuoteWithResourceLine(ResourceNo: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryAssembly.CreateAssemblyQuote(AssemblyHeader, WorkDate(), '', '', 1, '');
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::Resource, ResourceNo, LibraryExtTextAssDoc.CreateResourceUnitOfMeasureCode(ResourceNo), 1, 1, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyQuoteWithResourceLineAndExtendedTextInserted(ResourceNo: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateAssemblyQuoteWithResourceLine(ResourceNo);
        InsertExtendedText(AssemblyDocNo, ResourceNo);
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ResourceNo);
        exit(AssemblyDocNo);
    end;

    local procedure CreateResourceWithNoExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateResourceWithNoExtendedText());
    end;

    local procedure CreateResourceWithExtendedText(AutomaticExtTextsEnabled: Boolean; AssemblyDocumentType: Option " ",Order,Quote,"Blanket Quote"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateResourceWithExtendedText(AutomaticExtTextsEnabled, AssemblyDocumentType));
    end;

    local procedure DeleteResourceLineFromAssemblyQuote(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure ReplaceResourceByResourceWithNoExtendedTextOnAssemblyQuotePage(AssemblyDocNo: Code[20]; ResourceNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyQuotePage: TestPage "Assembly Quote";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Quote, AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo[1], AssemblyLine);

        AssemblyQuotePage.OpenEdit();
        AssemblyQuotePage.GoToRecord(AssemblyHeader);
        AssemblyQuotePage.Lines.GoToRecord(AssemblyLine);
        AssemblyQuotePage.Lines.Type.SetValue(AssemblyLine.Type::Resource);
        AssemblyQuotePage.Lines."No.".SetValue(ResourceNo[2]);
        AssemblyQuotePage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Quote, AssemblyDocNo, ResourceNo);
    end;

    local procedure VerifyResourceIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ResourceNo: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Quote, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToAssemblyQuote(AssemblyDocNo, ResourceNo);
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

    local procedure DisableExtTextForAssemblyDocument(): Integer
    begin
        exit(0);
    end;

    local procedure EnableExtTextForAssemblyQuote(): Integer
    begin
        exit(1);
    end;

    var
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
}