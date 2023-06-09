codeunit 50105 "Request Resource Line Impl."
{
    Access = Internal;

    procedure OnInsert(var Rec: Record "Request Line")
    var
        RequestGenericLine: Codeunit "Request Generic Line";
    begin
        RequestGenericLine.CopyHeaderData(Rec);
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
    var
        RequestGenericLine: Codeunit "Request Generic Line";
    begin
        Rec.Description := GetDescription(Rec."No.");
        RequestGenericLine.CopyHeaderData(Rec);
        RequestGenericLine.InitQuantity(Rec);
    end;

    local procedure ValidateQuantityField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
    end;

    local procedure ValidateStartingDateField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    var
        RequestGenericLine: Codeunit "Request Generic Line";
    begin
        RequestGenericLine.VerifyStartingDate(Rec."Document No.", Rec."Starting Date");
        RequestGenericLine.VerifyDuration(Rec."Document No.", Rec."Starting Date", Rec."Duration (Days)");
    end;

    local procedure ValidateDurationDays(var Rec: Record "Request Line"; xRec: Record "Request Line")
    var
        RequestGenericLine: Codeunit "Request Generic Line";
    begin
        RequestGenericLine.VerifyDuration(Rec."Document No.", Rec."Starting Date", Rec."Duration (Days)");
    end;

    local procedure GetDescription(ResourceNo: Code[20]): Text[100]
    var
        Resource: Record Resource;
    begin
        Resource.SetLoadFields(Name);
        if Resource.Get(ResourceNo) then
            exit(Resource.Name);
    end;
}
