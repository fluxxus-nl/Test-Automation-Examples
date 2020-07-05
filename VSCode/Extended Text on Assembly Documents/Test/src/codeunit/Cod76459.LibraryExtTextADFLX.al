codeunit 76459 "Library - Ext Text Ass Doc FLX"
{
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

    local procedure CreateExtendedText(LineType: Option " ",Item,Resource; No: Code[20]; EnableExtText: Option None,Order,Quote,"Blanket Order")
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
                    ExtendedTextHeader."Assembly Order" := false;
                    ExtendedTextHeader."Assembly Quote" := false;
                    ExtendedTextHeader."Assembly Blanket Order" := false;
                end;
            EnableExtText::Order:
                ExtendedTextHeader."Assembly Order" := true;
            EnableExtText::Quote:
                ExtendedTextHeader."Assembly Quote" := true;
            EnableExtText::"Blanket Order":
                ExtendedTextHeader."Assembly Blanket Order" := true;
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

    procedure DeleteLineFromAssemblyDocument(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        FindAssemblyLine(EnableExtText, AssemblyDocNo, LineType, No, AssemblyLine);
        AssemblyLine.Delete(true);
    end;

    procedure InsertExtendedText(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
        TransferExtendedText: Codeunit "Transfer Extended Text FLX";
    begin
        FindAssemblyLine(EnableExtText, AssemblyDocNo, LineType, No, AssemblyLine);

        TransferExtendedText.AssemblyCheckIfAnyExtText(AssemblyLine, true);
        TransferExtendedText.InsertAssemblyExtText(AssemblyLine);
    end;

    procedure VerifyExtendedTextLinesAreAddedToAssemblyDocument(AssemblyDocType: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        NoOfTextLines: Label 'Number of text lines.';
    begin
        case LineType of
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
        AssemblyLine.SetRange(Type, AssemblyLine.Type::" ");

        Assert.AreEqual(ExtendedTextLine.Count(), AssemblyLine.Count(), NoOfTextLines);

        AssemblyLine.FindSet();
        repeat
            ExtendedTextLine.SetRange(Text, AssemblyLine.Description);
            Assert.RecordIsNotEmpty(ExtendedTextLine);
        until AssemblyLine.Next() = 0;
    end;

    procedure FindAssemblyLine(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20]; var AssemblyLine: Record "Assembly Line")
    begin
        SetAssemblyLineFilter(EnableExtText, AssemblyDocNo, LineType, No, AssemblyLine);
        AssemblyLine.FindFirst();
    end;

    procedure SetAssemblyLineFilter(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20]; var AssemblyLine: Record "Assembly Line")
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        AssemblyLine.SetRange("Document Type", EnableExtText);
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

    procedure VerifyAssemblyLine(Exists: Boolean; EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; LineType: Option " ",Item,Resource; No: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(EnableExtText, AssemblyDocNo);

        SetAssemblyLineFilter(EnableExtText, AssemblyDocNo, LineType, No, AssemblyLine);
        if Exists then
            Assert.RecordIsNotEmpty(AssemblyLine)
        else
            Assert.RecordIsEmpty(AssemblyLine);
    end;

    procedure VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(EnableExtText, AssemblyDocNo);
        AssemblyLine.SetRange("Document Type", AssemblyLine."Document Type"::Quote);
        AssemblyLine.SetRange("Document No.", AssemblyDocNo);
        AssemblyLine.SetRange(Type, AssemblyLine.Type::" ");
        Assert.RecordIsEmpty(AssemblyLine);
    end;

    procedure VerifyItemAndExtendedTextLinesAreRemoved(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; ItemNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        VerifyAssemblyLine(false, EnableExtText, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(EnableExtText, AssemblyDocNo);
    end;

    procedure VerifyResourceAndExtendedTextLinesAreRemoved(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; ResourceNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
    begin
        VerifyAssemblyLine(false, EnableExtText, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(EnableExtText, AssemblyDocNo);
    end;

    procedure VerifyItemIsReplacedAndExtendedTextLinesAreRemoved(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; ItemNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(EnableExtText, AssemblyDocNo);
        VerifyAssemblyLine(false, EnableExtText, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo[1]);
        VerifyAssemblyLine(true, EnableExtText, AssemblyDocNo, AssemblyLine.Type::Item, ItemNo[2]);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(EnableExtText, AssemblyDocNo);
    end;

    procedure VerifyResourceIsReplacedAndExtendedTextLinesAreRemoved(EnableExtText: Option Quote,Order,,,"Blanket Order"; AssemblyDocNo: Code[20]; ResourceNo: array[2] of Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyHeader.Get(EnableExtText, AssemblyDocNo);
        VerifyAssemblyLine(false, EnableExtText, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo[1]);
        VerifyAssemblyLine(true, EnableExtText, AssemblyDocNo, AssemblyLine.Type::Resource, ResourceNo[2]);
        VerifyNoExtendedTextLinesAreAddedToAssemblyDocument(EnableExtText, AssemblyDocNo);
    end;

    var
        Assert: Codeunit Assert;
}