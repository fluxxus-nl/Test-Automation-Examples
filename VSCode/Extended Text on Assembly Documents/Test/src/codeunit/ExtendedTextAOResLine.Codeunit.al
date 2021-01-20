codeunit 76454 "Extended Text AO Res. Line FLX"
{
    // Generated on 29/06/2020 at 10:44 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text on assembly order/Add resource line
        // [FEATURE] Extended Text on assembly order/Delete resource line
    end;

    [Test]
    procedure AddToAssemblyOrderLineForResourceWithAutomaticExtTextsDisabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0025] Add to assembly order line for resource with "Automatic Ext. Texts"disabled and extended text enabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order
        AssemblyDocNo := CreateAssemblyOrder();

        // [WHEN] Add resource line to assembly order page
        AddResourceLineToAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to assembly order
        VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure AddToAssemblyOrderLineForResourceWithAutomaticExtTextsEnabledAndExtendedTextEnabled()
    // [FEATURE] Extended Text on assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0026] Add to assembly order line for resource with "Automatic Ext. Texts" enabled and extended text enabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" enabled and extended text enabled for assembly order
        ResourceNo := CreateResourceWithExtendedText(EnableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order
        AssemblyDocNo := CreateAssemblyOrder();

        // [WHEN] Add resource line to assembly order page
        AddResourceLineToAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] Extended text lines are added to assembly order
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure AddToAssemblyOrderLineForResourceWithAutomaticExtTextsEnabledAndExtendedTextDisabled()
    // [FEATURE] Extended Text on assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0070] Add to assembly order line for resource with "Automatic Ext. Texts" enabled and extended text disabled
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" enabled and extended text disabled for assembly order
        ResourceNo := CreateResourceWithExtendedText(EnableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Assembly order
        AssemblyDocNo := CreateAssemblyOrder();

        // [WHEN] Add resource line to assembly order page
        AddResourceLineToAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to assembly order
        VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsForResourceWithExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0027] Insert extended texts for resource with extended texts on assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with resource line
        AssemblyDocNo := CreateAssemblyOrderWithResourceLine(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] Extended text lines are added to assembly order
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure InsertExtendedTextsForResourceWithNoExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0028] Insert extended texts for resource with no extended texts on assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text disabled for assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), DisableExtTextForAssemblyDocument());
        // [GIVEN] Assembly order with resource line
        AssemblyDocNo := CreateAssemblyOrderWithResourceLine(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] No extended text lines are added to assembly order
        VerifyNoExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo);
    end;

    [Test]
    procedure InsertExtendedTextsTwiceForResourceWithExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0029] Insert extended texts twice for resource with extended texts on assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with resource line and extended text inserted
        AssemblyDocNo := CreateAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo);

        // [WHEN] Insert extended text
        InsertExtendedText(AssemblyDocNo, ResourceNo);

        // [THEN] No additional extended text lines are added to assembly order
        VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure ReplaceResourceWithExtendedTextsByResourceWithoutExtendedTextsOnAssemblyOrderLine()
    // [FEATURE] Extended Text on assembly order/Add resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: array[2] of Code[20];
    begin
        // [SCENARIO #0030] Replace resource with extended texts by resource without extended texts on assembly order line
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ResourceNo[1] := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Resource with no extended text
        ResourceNo[2] := CreateResourceWithNoExtendedText();
        // [GIVEN] Assembly order with resource line and extended text inserted
        AssemblyDocNo := CreateAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo[1]);

        // [WHEN] Replace resource by resource with no extended text
        ReplaceResourceByResourceWithNoExtendedTextOnAssemblyOrderPage(AssemblyDocNo, ResourceNo);

        // [THEN] Resource is replaced and extended text lines are removed
        VerifyResourceIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo, ResourceNo);
    end;

    [Test]
    procedure DeleteResourceLineWithExtendedText()
    // [FEATURE] Extended Text on assembly order/Delete resource line
    var
        AssemblyDocNo: Code[20];
        ResourceNo: Code[20];
    begin
        // [SCENARIO #0031] Delete resource line with extended text
        Initialize();

        // [GIVEN] Resource with "Automatic Ext. Texts" disabled and extended text enabled for assembly order
        ResourceNo := CreateResourceWithExtendedText(DisableAutomaticExtTexts(), EnableExtTextForAssemblyOrder());
        // [GIVEN] Assembly order with resource line and extended text inserted
        AssemblyDocNo := CreateAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo);

        // [WHEN] Delete resource line from assembly order
        DeleteResourceLineFromAssemblyOrder(AssemblyDocNo, ResourceNo);

        // [THEN] Resource  and extended text lines are removed
        VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyDocNo, ResourceNo);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text AO Res. Line FLX");

        if IsInitialized then
            exit;

        // [GIVEN] Set Nos on assembly setup
        SetNosOnAssemblySetup();
        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text AO Res. Line FLX");

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text AO Res. Line FLX");
    end;

    local procedure SetNosOnAssemblySetup()
    begin
        LibraryExtTextAssDoc.SetNosOnAssemblySetup();
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure AddResourceLineToAssemblyOrderPage(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyOrderPage: TestPage "Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyDocNo);

        AssemblyOrderPage.OpenEdit();
        AssemblyOrderPage.GoToRecord(AssemblyHeader);
        AssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Resource);
        AssemblyOrderPage.Lines."No.".SetValue(ResourceNo);
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

    local procedure CreateAssemblyOrderWithResourceLine(ResourceNo: Code[20]): Code[20]
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        LibraryAssembly.CreateAssemblyHeader(AssemblyHeader, WorkDate(), '', '', 1, '');
        LibraryAssembly.CreateAssemblyLine(AssemblyHeader, AssemblyLine, AssemblyLine.Type::Resource, ResourceNo, LibraryExtTextAssDoc.CreateResourceUnitOfMeasureCode(ResourceNo), 1, 1, '');
        exit(AssemblyHeader."No.");
    end;

    local procedure CreateAssemblyOrderWithResourceLineAndExtendedTextInserted(ResourceNo: Code[20]): Code[20]
    var
        AssemblyDocNo: Code[20];
    begin
        AssemblyDocNo := CreateAssemblyOrderWithResourceLine(ResourceNo);
        InsertExtendedText(AssemblyDocNo, ResourceNo);
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ResourceNo);
        exit(AssemblyDocNo);
    end;

    local procedure CreateResourceWithNoExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateResourceWithNoExtendedText());
    end;

    local procedure CreateResourceWithExtendedText(AutomaticExtTextsEnabled: Boolean; AssemblyDocumentType: Option " ",Order,Quote,"Blanket Order"): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateResourceWithExtendedText(AutomaticExtTextsEnabled, AssemblyDocumentType));
    end;

    local procedure DeleteResourceLineFromAssemblyOrder(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.DeleteLineFromAssemblyDocument(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure InsertExtendedText(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.InsertExtendedText(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure ReplaceResourceByResourceWithNoExtendedTextOnAssemblyOrderPage(AssemblyDocNo: Code[20]; ResourceNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        AssemblyOrderPage: TestPage "Assembly Order";
    begin
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyDocNo);

        LibraryExtTextAssDoc.FindAssemblyLine(AssemblyHeader."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo[1], AssemblyLine);

        AssemblyOrderPage.OpenEdit();
        AssemblyOrderPage.GoToRecord(AssemblyHeader);
        AssemblyOrderPage.Lines.GoToRecord(AssemblyLine);
        AssemblyOrderPage.Lines.Type.SetValue(AssemblyLine.Type::Resource);
        AssemblyOrderPage.Lines."No.".SetValue(ResourceNo[2]);
        AssemblyOrderPage.Close();
    end;

    local procedure VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyResourceAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Order, AssemblyDocNo, ResourceNo);
    end;

    local procedure VerifyResourceIsReplacedAndExtendedTextLinesAreRemoved(AssemblyDocNo: Code[20]; ResourceNo: array[2] of Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        LibraryExtTextAssDoc.VerifyReplacementAndExtendedTextLinesAreRemoved(AssemblyLine."Document Type"::Order, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
    end;

    local procedure VerifyNoAdditionalExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    begin
        VerifyExtendedTextLinesAreAddedToAssemblyOrder(AssemblyDocNo, ResourceNo);
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

    local procedure DisableExtTextForAssemblyDocument(): Integer
    begin
        exit(0);
    end;

    local procedure EnableExtTextForAssemblyOrder(): Integer
    begin
        exit(1);
    end;

    var
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
}