codeunit 76456 "Extend. Text BAO Res. Line FLX"
{
    // Generated on 29/06/2020 at 10:44 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on blanket assembly order/Add resource line
        // [FEATURE] Extended Text on blanket assembly order/Delete resource line
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForResourceWithAutomaticExtTextsDisabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on blanket assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0039] Add to blanket blanket assembly order line for resource with "Automatic Ext. Texts"disabled and extended text enabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add resource line to blanket assembly order page
        AddResourceLineToBlanketAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForResourceWithAutomaticExtTextsEnabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on blanket assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0040] Add to blanket blanket assembly order line for resource with "Automatic Ext. Texts" enabled and extended text enabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" enabled and extended text enabled for blanket assembly order
        ResourceNo := CreateResourceWithExtendedText(EnableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add resource line to blanket assembly order page
        AddResourceLineToBlanketAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] Extended text lines are added to blanket assembly order
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure AddToBlanketAssemblyOrderLineForResourceWithAutomaticExtTextsEnabledAndExtendedTextDisabled()
    // [FEATURE] Extended Text on blanket assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0072] Add to blanket blanket assembly order line for resource with "Automatic Ext. Texts" enabled and extended text disabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" enabled and extended text disabled for blanket assembly order
        ResourceNo := CreateResourceWithExtendedText(EnableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Blanket assembly order
        AssemblyDocNo := CreateBlanketAssemblyOrder();

        // [WHEN] Add resource line to blanket assembly order page
        AddResourceLineToBlanketAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForResourceWithExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0041] Insert extended texts for resource with extended texts on blanket blanket assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with resource line
        AssemblyDocNo := CreateBlanketAssemblyOrderWithResourceLine(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] Extended text lines are added to blanket assembly order
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure InsertExtendedTextsForResourceWithNoExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0042] Insert extended texts for resource with no extended texts on blanket blanket assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text disabled for blanket assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Blanket assembly order with resource line
        AssemblyDocNo := CreateBlanketAssemblyOrderWithResourceLine(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to blanket assembly order
        VerifyNoExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForResourceWithExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0043] Insert extended texts twice for resource with extended texts on blanket blanket assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with resource line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] No additional extended text lines are added to blanket assembly order
        VerifyNoAdditionalExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure ReplaceResourceWithExtendedTextsByResourceWithoutExtendedTextsOnBlanketAssemblyOrderLine()
    // [FEATURE] Extended Text on blanket assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: array[2] of Code[20];
    begin
        // [SCENARIO #0044] Replace resource with extended texts by resource without extended texts on blanket blanket assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ResourceNo[1] := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Resource with no extended text
        ResourceNo[2] := CreateResourceWithNoExtendedText();
        // [GIVEN] Blanket assembly order with resource line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo[1]);

        // [WHEN] Replace resource by resource with no extended text
        ReplaceResourceByResourceWithNoExtendedTextOnBlanketAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] Resource is replaced and extended text lines are removed
        VerifyResourceIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure DeleteResourceLineWithExtendedText()
    // [FEATURE] Extended Text on blanket assembly order/Delete resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0045] Delete resource line with extended text
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for blanket assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForBlanketAssemblyOrder());
        // [GIVEN] Blanket assembly order with resource line and extended text inserted
        AssemblyDocNo := CreateBlanketAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo);

        // [WHEN] Delete resource line from blanket assembly order
        DeleteResourceLineFromBlanketAssemblyOrder(AssemblyDocNo, ResourceNo);

        // [THEN] Resource  and extended text lines are removed
        VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyDocNo, ResourceNo);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extend. Text BAO Res. Line FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extend. Text BAO Res. Line FLX");

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extend. Text BAO Res. Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddResourceLineToBlanketAssemblyOrderPage(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        BlanketAssemblyOrderPage: TestPage "Blanket Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);

        BlanketAssemblyOrderPage.OpenEdit();
        BlanketAssemblyOrderPage.GoToRecord(AssemblyHeader);
        BlanketAssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Resource);
        BlanketAssemblyOrderPage.Lines."No.".SetValue(ResourceNo);
        BlanketAssemblyOrderPage.Close();
    end;

    local procedure CreateBlanketAssemblyOrder(): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        LibraryExtTextAssDoc.CreateBlanketAssemblyOrder(AssemblyHeader, WorkDate(), '', '', 1);
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateBlanketAssemblyOrderWithResourceLine(ResourceNo: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryExtTextAssDoc.CreateBlanketAssemblyOrder(AssemblyHeader, WorkDate(), '', '', 1);
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::Resource, ResourceNo, LibraryExtTextAssDoc.CreateResourceUnitOfMeasureCode(ResourceNo), 1, 1, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateBlanketAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateBlanketAssemblyOrderWithResourceLine(ResourceNo);
        InsertExtendedText(AssemblyDocNo, ResourceNo);
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ResourceNo);
        exit(AssemblyDocNo);
    end;

    local procedure CreateResourceWithNoExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateResourceWithNoExtendedText());
    end;

    local procedure CreateResourceWithExtendedText(AutomaticExtTextsEnabled: Boolean; AssemblyDocumentType: Enum "Assembly Document Type"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateResourceWithExtendedText(AutomaticExtTextsEnabled, AssemblyDocumentType));
    end;

    local procedure DeleteResourceLineFromBlanketAssemblyOrder(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure ReplaceResourceByResourceWithNoExtendedTextOnBlanketAssemblyOrderPage(AssemblyDocNo: Code[20]; ResourceNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        BlanketAssemblyOrderPage: TestPage "Blanket Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo[1], AssemblyLine);

        BlanketAssemblyOrderPage.OpenEdit();
        BlanketAssemblyOrderPage.GoToRecord(AssemblyHeader);
        BlanketAssemblyOrderPage.Lines.GoToRecord(AssemblyLine);
        BlanketAssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Resource);
        BlanketAssemblyOrderPage.Lines."No.".SetValue(ResourceNo[2]);
        BlanketAssemblyOrderPage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, ResourceNo);
    end;

    local procedure VerifyResourceIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ResourceNo: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::"Blanket Order", AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToBlanketAssemblyOrder(AssemblyDocNo, ResourceNo);
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