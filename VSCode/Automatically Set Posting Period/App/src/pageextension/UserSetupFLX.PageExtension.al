pageextension 80640 UserSetupFLX extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Autom. Update Posting Period"; "Autom. Update Posting Period")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the Allow Posting From/To dates on this user should be automatically updated.';
            }
        }
    }
}