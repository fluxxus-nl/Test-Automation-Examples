pageextension 75640 "WarehouseSetupExtFLX" extends "Warehouse Setup" //5775
{
    layout
    {
        addlast(General)
        {
            field("Unblock Deletion of Shpt. Line FLX"; Rec."Unblock Deletion of Shpt. Line FLX")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether you allow users to delete system-created warehouse shipment lines.';
            }
        }
    }
}