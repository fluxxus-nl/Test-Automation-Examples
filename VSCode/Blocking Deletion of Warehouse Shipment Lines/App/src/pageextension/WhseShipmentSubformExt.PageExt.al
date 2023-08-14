pageextension 75642 "WhseShipmentSubformExtFLX" extends "Whse. Shipment Subform" //7336
{
    layout
    {
        addlast(Control1)
        {
            field("System-Created FLX"; Rec."System-Created FLX")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that the entry was created by the system.';
            }
        }
    }
}