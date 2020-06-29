codeunit 76459 "Library - Ext Text Ass Doc FLX"
{
    procedure CreateItemWithExtendedText(AutomaticExtTextsEnabled: Boolean; AssemblyDocumentType: Option " ",Order,Quote,"Blanket Order"): Code[20]
    var
        Item: Record Item;
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItem(Item);
        Item."Automatic Ext. Texts" := AutomaticExtTextsEnabled;
        Item.Modify();

        CreateExtendedText(Item."No.", AssemblyDocumentType);
        exit(Item."No.");
    end;

    local procedure CreateExtendedText(ItemNo: Code[20]; AssemblyDocumentType: Option " ",Order,Quote,"Blanket Order")
    var
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        LibraryService: Codeunit "Library - Service";
    begin
        LibraryService.CreateExtendedTextHeaderItem(ExtendedTextHeader, ItemNo);
        case AssemblyDocumentType of
            AssemblyDocumentType::" ":
                begin
                    ExtendedTextHeader."Assembly Order" := false;
                    ExtendedTextHeader."Assembly Quote" := false;
                    ExtendedTextHeader."Assembly Blanket Order" := false;
                end;
            AssemblyDocumentType::Order:
                ExtendedTextHeader."Assembly Order" := true;
            AssemblyDocumentType::Quote:
                ExtendedTextHeader."Assembly Quote" := true;
            AssemblyDocumentType::"Blanket Order":
                ExtendedTextHeader."Assembly Blanket Order" := true;
        end;
        ExtendedTextHeader.Modify();
        LibraryService.CreateExtendedTextLineItem(ExtendedTextLine, ExtendedTextHeader);
    end;
}