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
    begin
        // [SCENARIO #0016] "Assembly Quote" on Extended Text card page for item
        // [GIVEN] Item with extended text
        Initialize();

        // [WHEN] Open Extended Text card page
        OpenExtendedTextCardPage(ExtendedTextPage, ItemNo);

        // [THEN] "Assembly Quote" is not set on Extended Text card page
        VerifyAssemblyQuoteIsNotSetOnExtendedTextCardPage(ExtendedTextPage);
    end;

    [Test]
    procedure AssemblyBlanketOrderOnExtendedTextCardPageForItem()
    // [FEATURE] Extended Text/Setup
    var
        ExtendedTextPage: TestPage "Extended Text";
    begin
        // [SCENARIO #0017] "Assembly Blanket Order" on Extended Text card page for item
        // [GIVEN] Item with extended text
        Initialize();

        // [WHEN] Open Extended Text card page
        OpenExtendedTextCardPage(ExtendedTextPage, ItemNo);

        // [THEN] "Assembly Blanket Order" is not set on Extended Text card page
        VerifyAssemblyBlanketOrderIsNotSetOnExtendedTextCardPage(ExtendedTextPage);
    end;

    [Test]
    procedure AssemblyOrderOnExtendedTextCardPageForItem()
    // [FEATURE] Extended Text/Setup
    var
        ExtendedTextPage: TestPage "Extended Text";
    begin
        // [SCENARIO #0018] "Assembly Order" on Extended Text card page for item
        // [GIVEN] Item with extended text
        Initialize();

        // [WHEN] Open Extended Text card page
        OpenExtendedTextCardPage(ExtendedTextPage, ItemNo);

        // [THEN] "Assembly Order" is not set on Extended Text card page
        VerifyAssemblyOrderIsNotSetOnExtendedTextCardPage(ExtendedTextPage);
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Extended Text Setup FLX");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Extended Text Setup FLX");

        // [GIVEN] Unit of measure
        CreateUnitOfMeasure();
        // [GIVEN] Item with extended text
        ItemNo := CreateItemWithExtendedText();

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Extended Text Setup FLX");
    end;

    local procedure CreateUnitOfMeasure()
    begin
        LibraryExtTextAssDoc.CreateUnitOfMeasure();
    end;

    local procedure CreateItemWithExtendedText(): Code[20]
    begin
        exit(LibraryExtTextAssDoc.CreateItemWithExtendedText(false, "Assembly Document Type"::None)); // enable ext. text for no assembly doc
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

    local procedure VerifyAssemblyBlanketOrderIsNotSetOnExtendedTextCardPage(var ExtendedTextPage: TestPage "Extended Text")
    begin
        VerifyFieldIsNotSet(ExtendedTextPage."Assembly Blanket Order FLX".Value(), ExtendedTextPage."Assembly Blanket Order FLX".Caption());
        ExtendedTextPage.Close();
    end;

    local procedure VerifyAssemblyOrderIsNotSetOnExtendedTextCardPage(var ExtendedTextPage: TestPage "Extended Text")
    begin
        VerifyFieldIsNotSet(ExtendedTextPage."Assembly Order FLX".Value(), ExtendedTextPage."Assembly Order FLX".Caption());
        ExtendedTextPage.Close();
    end;

    local procedure VerifyAssemblyQuoteIsNotSetOnExtendedTextCardPage(var ExtendedTextPage: TestPage "Extended Text")
    begin
        VerifyFieldIsNotSet(ExtendedTextPage."Assembly Quote FLX".Value(), ExtendedTextPage."Assembly Quote FLX".Caption());
        ExtendedTextPage.Close();
    end;

    local procedure VerifyFieldIsNotSet(FieldValueString: Text; FieldValueCaption: Text)
    var
        DummyBoolean: Boolean;
    begin
        Evaluate(DummyBoolean, FieldValueString);
        Assert.IsFalse(DummyBoolean, FieldValueCaption);
    end;

    var
        Assert: Codeunit Assert;
        LibraryExtTextAssDoc: Codeunit "Library - Ext Text Ass Doc FLX";
        IsInitialized: Boolean;
        ItemNo: Code[20];

}