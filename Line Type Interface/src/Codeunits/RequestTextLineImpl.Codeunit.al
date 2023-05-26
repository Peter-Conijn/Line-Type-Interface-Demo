codeunit 50106 "Request Text Line Impl."
{
    Access = Internal;

    procedure OnInsert(var Rec: Record "Request Line")
    var
        RequestGenericLine: Codeunit "Request Generic Line";
    begin
        RequestGenericLine.CopyHeaderData(Rec);
        ClearNonEssentialData(Rec);
    end;

    procedure OnModify(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
    end;

    procedure OnDelete(var Rec: Record "Request Line")
    begin
    end;

    procedure OnValidateField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer)
    begin
        case CalledFromFieldNo of
            Rec.FieldNo("No."):
                ValidateNoField(Rec, xRec);
            Rec.FieldNo(Quantity):
                ValidateQuantityField(Rec, xRec);
            Rec.FieldNo("Starting Date"):
                ValidateStartingDateField(Rec, xRec);
            Rec.FieldNo("Duration (Days)"):
                ValidateDurationDays(Rec, xRec);
        end;
    end;

    procedure OnLookupField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer)
    begin
    end;

    local procedure ValidateNoField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Rec.Description := GetDescription(Rec."No.");
    end;

    local procedure ValidateQuantityField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Rec.TestField(Quantity, 0);
    end;

    local procedure ValidateStartingDateField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Rec.TestField(Rec."Starting Date", 0D);
    end;

    local procedure ValidateDurationDays(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Rec.TestField(Quantity, 0);
    end;

    local procedure ClearNonEssentialData(var Rec: Record "Request Line")
    begin
        Rec."Starting Date" := 0D;
        Rec."Duration (Days)" := 0;
    end;

    local procedure GetDescription(StandardTextNo: Code[20]): Text[100]
    var
        StandardText: Record "Standard Text";
    begin
        StandardText.SetLoadFields(Description);
        if StandardText.Get(StandardTextNo) then
            exit(StandardText.Description);
    end;
}
