tableextension 76400 "Assembly Line Ext FLX" extends "Assembly Line" // 901
{
    fields
    {
        field(76400; "Attached to Line No. FLX"; Integer)
        {
            Caption = 'Attached to Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Assembly Line"."Line No." where("Document Type" = field("Document Type"), "Document No." = field("Document No."));
        }
    }

    trigger OnDelete()
    begin
        DeleteAttachedLines();
    end;

    procedure DeleteAttachedLines()
    var
        AssemblyLine: Record "Assembly Line";
    begin
        if "Line No." <> 0 then begin
            AssemblyLine.SetRange("Document Type", Rec."Document Type");
            AssemblyLine.SetRange("Document No.", Rec."Document No.");
            AssemblyLine.SetRange("Attached to Line No. FLX", Rec."Line No.");
            AssemblyLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
            AssemblyLine.DeleteAll(true);
        end;
    end;
}