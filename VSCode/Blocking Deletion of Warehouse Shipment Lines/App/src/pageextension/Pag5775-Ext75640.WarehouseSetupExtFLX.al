pageextension 75640 "WarehouseSetupExtFLX" extends "Warehouse Setup" //5775
{
    layout
    {
        addlast(General)
        {
            field("Unblock Deletion of Shpt. Line"; "Unblock Deletion of Shpt. Line")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether you allow users to delete system-created warehouse shipment lines.';
            }
        }
    }
}