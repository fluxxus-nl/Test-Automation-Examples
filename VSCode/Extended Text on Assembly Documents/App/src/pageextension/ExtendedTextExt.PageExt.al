pageextension 76401 "Extended Text Ext FLX" extends "Extended Text" // 386
{
    layout
    {
        addlast(Content)
        {
            group(AssemblyASDFLX)
            {
                Caption = 'Assembly';
                field("Assembly Quote FLX"; Rec."Assembly Quote FLX")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether the text will be available on assembly quotes.';
                }
                field("Assembly Blanket Order FLX"; Rec."Assembly Blanket Order FLX")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether the text will be available on assembly blanket orders.';
                }
                field("Assembly Order FLX"; Rec."Assembly Order FLX")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether the text will be available on assembly orders.';
                }
            }
        }
    }
}