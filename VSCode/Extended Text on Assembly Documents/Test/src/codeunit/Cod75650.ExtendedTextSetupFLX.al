codeunit 76450 "Extended Text Setup FLX"
{
    // Generated on 28/06/2020 at 15:21 by lvanvugt

    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] Extended Text/Setup
    end;

    [Test]
    procedure AssemblyQuoteOnExtendedTextCardPageForItem()
    // [FEATURE] Extended Text/Setup
    var
        ExtendedTextPage: TestPage "Extended Text";
        ItemNo: Code[20];
    begin
        // [SCENARIO #0016] "Assembly Quote" on Extended Text card page for item
        Initialize();

        // [GIVEN] Item with extended text
        ItemNo := CreateItemWithExtendedText();

        // [WHEN] Open Extended Text card page
        OpenExtendedTextCardPage(ExtendedTextPage, ItemNo);

        // [THEN] "Assembly Quote" is set on Extended Text card page
        VerifyAssemblyQuoteIsSetOnExtendedTextCardPage(ExtendedTextPage);
    end;

    [Test]
    procedure AssemblyBlanketOrderOnExtendedTextCardPageForItem()
    // [FEATURE] Extended Text/Setup
    var
        ExtendedTextPage: TestPage "Extended Text";
        ItemNo: Code[20];
    begin
        // [SCENARIO #0017] "Assembly Blanket Order" on Extended Text card page for item
        Initialize();

        // [GIVEN] Item with extended text
        ItemNo := CreateItemWithExtendedText();

        // [WHEN] Open Extended Text card page
        OpenExtendedTextCardPage(ExtendedTextPage, ItemNo);

        // [THEN] "Assembly Blanket Order" is set on Extended Text card page
        VerifyAssemblyBlanketOrderIsSetOnExtendedTextCardPage(ExtendedTextPage);
    end;

    [Test]
    procedure AssemblyOrderOnExtendedTextCardPageForItem()
    // [FEATURE] Extended Text/Setup
    var
        ExtendedTextPage: TestPage "Extended Text";
        ItemNo: Code[20];
    begin
        // [SCENARIO #0018] "Assembly Order" on Extended Text card page for item
        Initialize();

        // [GIVEN] Item with extended text
        ItemNo := CreateItemWithExtendedText();

        // [WHEN] Open Extended Text card page
        OpenExtendedTextCardPage(ExtendedTextPage, ItemNo);

        // [THEN] "Assembly Order" is set on Extended Text card page
        VerifyAssemblyOrderIsSetOnExtendedTextCardPage(ExtendedTextPage);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text Setup FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text Setup FLX");

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text Setup FLX");
    end;

    local procedure CreateItemWithExtendedText(): Code[20]
    var
        Item: Record Item;
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItem(Item);
        CreateExtendedText(Item."No.");
        exit(Item."No.");
    end;

    local procedure CreateExtendedText(ItemNo: Code[20])
    var
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        LibraryService: Codeunit "Library - Service";
    begin
        LibraryService.CreateExtendedTextHeaderItem(ExtendedTextHeader, ItemNo);
        LibraryService.CreateExtendedTextLineItem(ExtendedTextLine, ExtendedTextHeader);
    end;

    local procedure OpenExtendedTextCardPage(var ExtendedTextPage: TestPage "Extended Text"; ItemNo: Code[20])
    var
        ExtendedTextHeader: Record "Extended Text Header";
    begin
        ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::Item);
        ExtendedTextHeader.SetRange("No.", ItemNo);
        ExtendedTextHeader.FindFirst();
        ExtendedTextPage.OpenView();
        ExtendedTextPage.GoToRecord(ExtendedTextHeader);
    end;

    local procedure VerifyAssemblyBlanketOrderIsSetOnExtendedTextCardPage(var ExtendedTextPage: TestPage "Extended Text")
    begin
        VerifyFieldIsSet(ExtendedTextPage."Assembly Blanket Order".Value(), ExtendedTextPage."Assembly Blanket Order".Caption());
        ExtendedTextPage.Close();
    end;

    local procedure VerifyAssemblyOrderIsSetOnExtendedTextCardPage(var ExtendedTextPage: TestPage "Extended Text")
    begin
        VerifyFieldIsSet(ExtendedTextPage."Assembly Order".Value(), ExtendedTextPage."Assembly Order".Caption());
        ExtendedTextPage.Close();
    end;

    local procedure VerifyAssemblyQuoteIsSetOnExtendedTextCardPage(var ExtendedTextPage: TestPage "Extended Text")
    begin
        VerifyFieldIsSet(ExtendedTextPage."Assembly Quote".Value(), ExtendedTextPage."Assembly Quote".Caption());
        ExtendedTextPage.Close();
    end;

    local procedure VerifyFieldIsSet(FieldValueString: Text; FieldValueCaption: Text)
    var
        DummyBoolean: Boolean;
    begin
        Evaluate(DummyBoolean, FieldValueString);
        Assert.IsTrue(DummyBoolean, FieldValueCaption);
    end;

    var
        Assert: Codeunit Assert;
        IsInitialized: Boolean;

}