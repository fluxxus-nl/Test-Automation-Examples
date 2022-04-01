tableextension 76401 "Extended Text Header Ext FLX" extends "Extended Text Header" // 279
{
    fields
    {
        field(76400; "Assembly Quote FLX"; Boolean)
        {
            AccessByPermission = tabledata "Assembly Header" = R;
            Caption = 'Assembly Quote';
            InitValue = true;
        }
        field(76401; "Assembly Blanket Order FLX"; Boolean)
        {
            AccessByPermission = tabledata "Assembly Header" = R;
            Caption = 'Assembly Blanket Order';
            InitValue = true;
        }
        field(76402; "Assembly Order FLX"; Boolean)
        {
            AccessByPermission = tabledata "Assembly Header" = R;
            Caption = 'Assembly Order';
            InitValue = true;
        }
    }
}