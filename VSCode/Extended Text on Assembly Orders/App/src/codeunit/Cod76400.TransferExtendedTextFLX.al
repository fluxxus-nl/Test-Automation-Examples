codeunit 76400 "Transfer Extended Text FLX"
{
    procedure AssemblyCheckIfAnyExtText(var AssemblyLine: Record "Assembly Line"; Unconditionally: Boolean): Boolean
    var
        AssemblyHeader: Record "Assembly Header";
        ExtTextHeader: Record "Extended Text Header";
    begin
        MakeUpdateRequired := false;
        if IsDeleteAttachedLines(AssemblyLine."Line No.", AssemblyLine."No.", AssemblyLine."Attached to Line No.") then
            MakeUpdateRequired := DeleteAssemblyLines(AssemblyLine);

        AutoText := false;

        if Unconditionally then
            AutoText := true
        else
            case AssemblyLine.Type OF
                AssemblyLine.Type::" ":
                    AutoText := true;
                AssemblyLine.Type::Item:
                    begin
                        if Item.Get(AssemblyLine."No.") then
                            AutoText := Item."Automatic Ext. Texts";
                    end;
                AssemblyLine.Type::Resource:
                    begin
                        if Res.Get(AssemblyLine."No.") then
                            AutoText := Res."Automatic Ext. Texts";
                    end;
            end;

        if AutoText then begin
            AssemblyLine.TestField("Document No.");
            AssemblyHeader.Get(AssemblyLine."Document Type", AssemblyLine."Document No.");
            ExtTextHeader.SetRange("Table Name", AssemblyLine.Type);
            ExtTextHeader.SetRange("No.", AssemblyLine."No.");
            case AssemblyLine."Document Type" OF
                AssemblyLine."Document Type"::Quote:
                    ExtTextHeader.SetRange("Assembly Quote", true);
                AssemblyLine."Document Type"::"Blanket Order":
                    ExtTextHeader.SetRange("Assembly Blanket Order", true);
                AssemblyLine."Document Type"::Order:
                    ExtTextHeader.SetRange("Assembly Order", true);
            end;
            OnAssemblyCheckIfAnyExtTextAutoText(ExtTextHeader, AssemblyHeader, AssemblyLine, Unconditionally);
            exit(ReadLines(ExtTextHeader, AssemblyHeader."Starting Date", ''));
        end;
    end;

    procedure MakeUpdate(): Boolean
    begin
        exit(MakeUpdateRequired);
    end;

    procedure ReadLines(var ExtTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]) Result: Boolean
    var
        ExtTextLine: Record "Extended Text Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeReadLines(ExtTextHeader, DocDate, LanguageCode, IsHandled, Result);
        if IsHandled then
            exit(Result);

        ExtTextHeader.SetCurrentKey(
          "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
        ExtTextHeader.SetRange("Starting Date", 0D, DocDate);
        ExtTextHeader.SetFilter("Ending Date", '%1..|%2', DocDate, 0D);
        if LanguageCode = '' then begin
            ExtTextHeader.SetRange("Language Code", '');
            if not ExtTextHeader.FindSet() then
                exit;
        end else begin
            ExtTextHeader.SetRange("Language Code", LanguageCode);
            if not ExtTextHeader.FindSet() then begin
                ExtTextHeader.SetRange("All Language Codes", true);
                ExtTextHeader.SetRange("Language Code", '');
                if not ExtTextHeader.FindSet() then
                    exit;
            end;
        end;
        TempExtTextLine.DeleteAll();
        repeat
            ExtTextLine.SetRange("Table Name", ExtTextHeader."Table Name");
            ExtTextLine.SetRange("No.", ExtTextHeader."No.");
            ExtTextLine.SetRange("Language Code", ExtTextHeader."Language Code");
            ExtTextLine.SetRange("Text No.", ExtTextHeader."Text No.");
            if ExtTextLine.FindSet() then begin
                repeat
                    TempExtTextLine := ExtTextLine;
                    TempExtTextLine.Insert();
                until ExtTextLine.Next() = 0;
                Result := true;
            end;
        until ExtTextHeader.Next() = 0;
    end;

    procedure InsertAssemblyExtText(var AssemblyLine: Record "Assembly Line")
    var
        DummyAssemblyLine: Record "Assembly Line";
    begin
        InsertAssemblyExtTextRetLast(AssemblyLine, DummyAssemblyLine);
    end;

    procedure InsertAssemblyExtTextRetLast(var AssemblyLine: Record "Assembly Line"; var LastInsertedAssemblyLine: Record "Assembly Line")
    var
        ToAssemblyLine: Record "Assembly Line";
        IsHandled: Boolean;
    begin
        OnBeforeInsertAssemblyExtText(AssemblyLine, TempExtTextLine, IsHandled);
        if IsHandled then
            exit;

        ToAssemblyLine.Reset();
        ToAssemblyLine.SetRange("Document Type", AssemblyLine."Document Type");
        ToAssemblyLine.SetRange("Document No.", AssemblyLine."Document No.");
        ToAssemblyLine := AssemblyLine;
        if ToAssemblyLine.Find('>') then begin
            LineSpacing :=
              (ToAssemblyLine."Line No." - AssemblyLine."Line No.") div
              (1 + TempExtTextLine.Count());
            if LineSpacing = 0 then
                Error(ThereIsNotEnoughSpaceErr);
        end else
            LineSpacing := 10000;

        NextLineNo := AssemblyLine."Line No." + LineSpacing;

        TempExtTextLine.Reset();
        if TempExtTextLine.Find('-') then begin
            repeat
                ToAssemblyLine.Init();
                ToAssemblyLine."Document Type" := AssemblyLine."Document Type";
                ToAssemblyLine."Document No." := AssemblyLine."Document No.";
                ToAssemblyLine."Line No." := NextLineNo;
                NextLineNo := NextLineNo + LineSpacing;
                ToAssemblyLine.Description := TempExtTextLine.Text;
                ToAssemblyLine."Attached to Line No." := AssemblyLine."Line No.";
                OnBeforeToAssemblyLineInsert(ToAssemblyLine, AssemblyLine, TempExtTextLine, NextLineNo, LineSpacing);
                ToAssemblyLine.Insert();
            until TempExtTextLine.Next() = 0;
            MakeUpdateRequired := true;
        end;
        TempExtTextLine.DeleteAll();
        LastInsertedAssemblyLine := ToAssemblyLine;
    end;

    local procedure DeleteAssemblyLines(var AssemblyLine: Record "Assembly Line"): Boolean
    var
        AssemblyLine2: Record "Assembly Line";
    begin
        AssemblyLine2.SetRange("Document Type", AssemblyLine."Document Type");
        AssemblyLine2.SetRange("Document No.", AssemblyLine."Document No.");
        AssemblyLine2.SetRange("Attached to Line No.", AssemblyLine."Line No.");
        OnDeleteAssemblyLinesOnAfterSetFilters(AssemblyLine2, AssemblyLine);
        AssemblyLine2 := AssemblyLine;
        if AssemblyLine2.Find('>') then begin
            repeat
                AssemblyLine2.Delete(true);
            until AssemblyLine2.Next() = 0;
            exit(true);
        end;
    end;

    local procedure IsDeleteAttachedLines(LineNo: Integer; No: Code[20]; AttachedToLineNo: Integer): Boolean
    begin
        exit((LineNo <> 0) and (AttachedToLineNo = 0) and (No <> ''));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReadLines(var ExtendedTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDeleteAssemblyLinesOnAfterSetFilters(var ToAssemblyLine: Record "Assembly Line"; FromAssemblyLine: Record "Assembly Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAssemblyCheckIfAnyExtTextAutoText(var ExtendedTextHeader: Record "Extended Text Header"; var AssemblyHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line"; Unconditionally: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeToAssemblyLineInsert(var ToAssemblyLine: Record "Assembly Line"; AssemblyLine: Record "Assembly Line"; TempExtTextLine: Record "Extended Text Line" temporary; var NextLineNo: Integer; LineSpacing: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertAssemblyExtText(var AssemblyLine: Record "Assembly Line"; var TempExtTextLine: Record "Extended Text Line" temporary; var IsHandled: Boolean)
    begin
    end;

    var
        Item: Record Item;
        Res: Record Resource;
        TempExtTextLine: Record "Extended Text Line";
        NextLineNo: Integer;
        LineSpacing: Integer;
        MakeUpdateRequired: Boolean;
        AutoText: Boolean;
        ThereIsNotEnoughSpaceErr: Label 'There is not enough space to insert extended text lines.';
}