codeunit 76469 "Library - Ext Text Ass Doc FLX"
{
    procedure CreateUnitOfMeasure()
    var
        UnitOfMeasure: Record "Unit of Measure";
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateUnitOfMeasureCode(UnitOfMeasure);
    end;

    procedure SetNosOnAssemblySetup()
    var
        AssemblySetup: Record "Assembly Setup";
        LibraryUtility: Codeunit "Library - Utility";
    begin
        if not AssemblySetup.Get() then
            AssemblySetup.Insert();
        LibraryUtility.UpdateSetupNoSeriesCode(
          DATABASE::"Assembly Setup", AssemblySetup.FieldNo("Assembly Quote Nos."));
        LibraryUtility.UpdateSetupNoSeriesCode(
          DATABASE::"Assembly Setup", AssemblySetup.FieldNo("Assembly Order Nos."));
        LibraryUtility.UpdateSetupNoSeriesCode(
          DATABASE::"Assembly Setup", AssemblySetup.FieldNo("Blanket Assembly Order Nos."));
        LibraryUtility.UpdateSetupNoSeriesCode(
          DATABASE::"Assembly Setup", AssemblySetup.FieldNo("Posted Assembly Order Nos."));
    end;

    procedure CreateItemWithExtendedText(AutomaticExtTextsEnabled: Boolean; EnableExtText: Option None,Order,Quote,"Blanket Order"): Code[20]
    var
        Item: Record Item;
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItem(Item);
        Item."Automatic Ext. Texts" := AutomaticExtTextsEnabled;
        Item.Modify();

        CreateExtendedText(2, Item."No.", EnableExtText); // 2 = Item
        exit(Item."No.");
    end;

    procedure CreateResourceWithExtendedText(AutomaticExtTextsEnabled: Boolean; EnableExtText: Option None,Order,Quote,"Blanket Order"): Code[20]
    var
        Resource: Record Resource;
        LibraryResource: Codeunit "Library - Resource";
    begin
        LibraryResource.CreateResourceNew(Resource);
        Resource."Automatic Ext. Texts" := AutomaticExtTextsEnabled;
        Resource.Modify();

        CreateExtendedText(3, Resource."No.", EnableExtText); // 3 = Resource
        exit(Resource."No.");
    end;

    procedure CreateStandardTextWithExtendedText(EnableExtText: Option None,Order,Quote,"Blanket Order"): Code[20]
    var
        StandardText: Record "Standard Text";
        LibrarySales: Codeunit "Library - Sales";
    begin
        LibrarySales.CreateStandardText(StandardText);

        CreateExtendedText(0, StandardText.Code, EnableExtText); // 0 = Standard Text
        exit(StandardText.Code);
    end;

    local procedure CreateExtendedText(LineType: Option "Standard Text","G/L Account",Item,Resource; No: Code[20]; EnableExtText: Option None,Order,Quote,"Blanket Order")
    var
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        LibraryService: Codeunit "Library - Service";
        LibraryRandom: Codeunit "Library - Random";
    begin
        CreateExtendedTextHeader(ExtendedTextHeader, LineType, No);
        case EnableExtText of
            EnableExtText::None:
                begin
                    ExtendedTextHeader."Assembly Order FLX" := false;
                    ExtendedTextHeader."Assembly Quote FLX" := false;
                    ExtendedTextHeader."Assembly Blanket Order FLX" := false;
                end;
            EnableExtText::Order:
                ExtendedTextHeader."Assembly Order FLX" := true;
            EnableExtText::Quote:
                ExtendedTextHeader."Assembly Quote FLX" := true;
            EnableExtText::"Blanket Order":
                ExtendedTextHeader."Assembly Blanket Order FLX" := true;
        end;
        ExtendedTextHeader.Modify();
        LibraryService.CreateExtendedTextLineItem(ExtendedTextLine, ExtendedTextHeader);
        ExtendedTextLine.Text := LibraryRandom.RandText(MaxStrLen(ExtendedTextLine.Text));
        ExtendedTextLine.Modify();
    end;

    local procedure CreateExtendedTextHeader(var ExtendedTextHeader: Record "Extended Text Header"; LineType: Option " ",Item,Resource; No: Code[20])
    begin
        ExtendedTextHeader.Init();
        ExtendedTextHeader.Validate("Table Name", LineType);
        ExtendedTextHeader.Validate("No.", No);
        ExtendedTextHeader.Insert(true);
    end;

    procedure CreateBlanketAssemblyOrder(var AssemblyHeader: Record "Assembly Header"; DueDate: Date; ParentItemNo: Code[20]; LocationCode: Code[10]; Quantity: Decimal): Code[20]
    var
        LibraryAssembly: Codeunit "Library - Assembly";
    begin
        Clear(AssemblyHeader);
        AssemblyHeader."Document Type" := AssemblyHeader."Document Type"::"Blanket Order";
        AssemblyHeader.Insert(true);
        AssemblyHeader.Validate("Item No.", ParentItemNo);
        AssemblyHeader.Validate("Location Code", LocationCode);
        AssemblyHeader.Validate("Due Date", DueDate);
        AssemblyHeader.Validate(Quantity, Quantity);
        AssemblyHeader.Modify(true);

        exit(AssemblyHeader."No.");
    end;

    procedure DeleteLineFromAssemblyDocument(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        FindAssemblyLine(DocumentType, AssemblyDocNo, LineType, No, AssemblyLine);
        AssemblyLine.Delete(true);
    end;

    procedure InsertExtendedText(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
        TransferExtendedText: Codeunit "Transfer Extended Text FLX";
    begin
        FindAssemblyLine(DocumentType, AssemblyDocNo, LineType, No, AssemblyLine);

        TransferExtendedText.AssemblyCheckIfAnyExtText(AssemblyLine, true);
        TransferExtendedText.InsertAssemblyExtText(AssemblyLine);
    end;

    procedure VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyDocType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        NoOfTextLines: Label 'Number of text lines.';
    begin
        case LineType of
            LineType::" ":
                begin
                    ExtendedTextHeader.SetRange(ExtendedTextHeader."Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                    ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::"Standard Text");
                end;
            LineType::Item:
                begin
                    ExtendedTextHeader.SetRange(ExtendedTextHeader."Table Name", ExtendedTextHeader."Table Name"::Item);
                    ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
                end;
            LineType::Resource:
                begin
                    ExtendedTextHeader.SetRange(ExtendedTextHeader."Table Name", ExtendedTextHeader."Table Name"::Resource);
                    ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Resource);
                end;
        end;
        ExtendedTextHeader.SetRange("No.", No);
        ExtendedTextHeader.FindFirst();

        ExtendedTextLine.SetRange("No.", No);

        AssemblyHeader.Get(AssemblyDocType, AssemblyDocNo);
        AssemblyLine.SetRange("Document Type", AssemblyDocType);
        AssemblyLine.SetRange("Document No.", AssemblyDocNo);
        AssemblyLine.SetRange("No.", '');
        AssemblyLine.SetRange(Type, AssemblyLine.Type::" ");

        Assert.AreEqual(ExtendedTextLine.Count(), AssemblyLine.Count(), NoOfTextLines);

        AssemblyLine.FindSet();
        repeat
            ExtendedTextLine.SetRange(Text, AssemblyLine.Description);
            Assert.RecordIsNotEmpty(ExtendedTextLine);
        until AssemblyLine.Next() = 0;
    end;

    procedure FindAssemblyLine(EnableExtText: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20]; var AssemblyLine: Record "Assembly Line")
    begin
        SetAssemblyLineFilter(EnableExtText, AssemblyDocNo, LineType, No, AssemblyLine);
        AssemblyLine.FindFirst();
    end;

    procedure SetAssemblyLineFilter(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20]; var AssemblyLine: Record "Assembly Line")
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        AssemblyLine.SetRange("Document Type", DocumentType);
        AssemblyLine.SetRange("Document No.", AssemblyDocNo);
        AssemblyLine.SetRange(Type, LineType);
        AssemblyLine.SetRange("No.", No);
    end;

    procedure CreateItemWithNoExtendedText(): Code[20]
    var
        Item: Record Item;
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItem(Item);
        exit(Item."No.");
    end;

    procedure CreateItemUnitOfMeasureCode(ItemNo: Code[20]): Code[10]
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItemUnitOfMeasureCode(ItemUnitOfMeasure, ItemNo, 1);
        exit(ItemUnitOfMeasure.Code);
    end;

    procedure CreateResourceWithNoExtendedText(): Code[20]
    var
        Resource: Record Resource;
        LibraryResource: Codeunit "Library - Resource";
    begin
        LibraryResource.CreateResourceNew(Resource);
        exit(Resource."No.");
    end;

    procedure CreateResourceUnitOfMeasureCode(ResourceNo: Code[20]): Code[10]
    var
        ResourceUnitOfMeasure: Record "Resource Unit of Measure";
        UnitOfMeasure: Record "Unit of Measure";
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateUnitOfMeasureCode(UnitOfMeasure);

        ResourceUnitOfMeasure.Init();
        ResourceUnitOfMeasure.Validate("Resource No.", ResourceNo);
        ResourceUnitOfMeasure.Validate(Code, UnitOfMeasure.Code);
        ResourceUnitOfMeasure.Validate("Qty. per Unit of Measure", 1);
        ResourceUnitOfMeasure.Insert(true);
    end;

    procedure CreateStandardTextWithNoExtendedText(): Code[20]
    var
        StandardText: Record "Standard Text";
        LibrarySales: Codeunit "Library - Sales";
    begin
        LibrarySales.CreateStandardText(StandardText);
        exit(StandardText.Code);
    end;

    procedure VerifyAssemblyLine(Exists: Boolean; DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(DocumentType, AssemblyDocNo);

        SetAssemblyLineFilter(DocumentType, AssemblyDocNo, LineType, No, AssemblyLine);
        if Exists then
            Assert.RecordIsNotEmpty(AssemblyLine)
        else
            Assert.RecordIsEmpty(AssemblyLine);
    end;

    procedure VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(DocumentType, AssemblyDocNo);
        AssemblyLine.SetRange("Document Type", DocumentType);
        AssemblyLine.SetRange("Document No.", AssemblyDocNo);
        AssemblyLine.SetRange(Type, AssemblyLine.Type::" ");
        AssemblyLine.SetRange("No.", '');
        Assert.RecordIsEmpty(AssemblyLine);
    end;

    procedure VerifyItemAndExtendedTextLinesAreRemoved(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        VerifyAssemblyLine(false, DocumentType, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(DocumentType, AssemblyDocNo);
    end;

    procedure VerifyResourceAndExtendedTextLinesAreRemoved(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        VerifyAssemblyLine(false, DocumentType, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(DocumentType, AssemblyDocNo);
    end;

    procedure VerifyTextAndExtendedTextLinesAreRemoved(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; TextCode: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        VerifyAssemblyLine(false, DocumentType, AssemblyDocNo, AssemblyLine.Type::" ", TextCode);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(DocumentType, AssemblyDocNo);
    end;

    procedure VerifyReplacementAndExtendedTextLinesAreRemoved(DocumentType: Enum "Assembly Document Type"; AssemblyDocNo: Code[20]; Type: Option " ",Item,Resource; No: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(DocumentType, AssemblyDocNo);
        VerifyAssemblyLine(false, DocumentType, AssemblyDocNo, Type, No[1]);
        VerifyAssemblyLine(true, DocumentType, AssemblyDocNo, Type, No[2]);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(DocumentType, AssemblyDocNo);
    end;

    var
        Assert: Codeunit Assert;
}