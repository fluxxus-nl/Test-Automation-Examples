tableextension 76400 "AssemblyLineExtFLX" extends "Assembly Line" // 901
{
    fields
    {
        field(76400; "Attached to Line No."; Integer)
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
        if "Line No." <> 0 then
            with AssemblyLine do begin
                Reset();
                AssemblyLine.SetRange("Document Type", "Document Type");
                AssemblyLine.SetRange("Document No.", "Document No.");
                AssemblyLine.SetRange("Attached to Line No.", "Line No.");
                AssemblyLine.SetFilter("Line No.", '<>%1', "Line No.");
                AssemblyLine.DeleteAll(true);
            end;
    end;
}