pageextension 76401 "Extended Text Ext FLX" extends "Extended Text" // 386
{
    layout
    {
        addlast(Content)
        {
            group(Assembly)
            {
                Caption = 'Assembly';
                field("Assembly Quote"; Rec."Assembly Quote")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether the text will be available on assembly quotes.';
                }
                field("Assembly Blanket Order"; Rec."Assembly Blanket Order")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether the text will be available on assembly blanket orders.';
                }
                field("Assembly Order"; Rec."Assembly Order")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether the text will be available on assembly orders.';
                }
            }
        }
    }
}