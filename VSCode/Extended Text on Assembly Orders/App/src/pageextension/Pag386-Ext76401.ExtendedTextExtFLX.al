pageextension 76401 "ExtendedTextExtFLX" extends "Extended Text" // 386
{
    layout
    {
        addlast(Content)
        {
            group(Assembly)
            {
                Caption = 'Assembly';
                field("Assembly Quote"; "Assembly Quote")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether the text will be available on assembly quotes.';
                }
                field("Assembly Blanket Order"; "Assembly Blanket Order")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether the text will be available on assembly blanket orders.';
                }
                field("Assembly Order"; "Assembly Order")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether the text will be available on assembly orders.';
                }
            }
        }
    }
}