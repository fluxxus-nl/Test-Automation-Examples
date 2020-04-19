tableextension 76401 "ExtendedTextHeaderExtFLX" extends "Extended Text Header" // 279
{
    fields
    {
        field(76400; "Assembly Quote"; Boolean)
        {
            AccessByPermission = TableData "Assembly Header" = R;
            Caption = 'Assembly Quote';
            InitValue = true;
        }
        field(76401; "Assembly Blanket Order"; Boolean)
        {
            AccessByPermission = TableData "Assembly Header" = R;
            Caption = 'Assembly Blanket Order';
            InitValue = true;
        }
        field(76402; "Assembly Order"; Boolean)
        {
            AccessByPermission = TableData "Assembly Header" = R;
            Caption = 'Assembly Order';
            InitValue = true;
        }
    }
}