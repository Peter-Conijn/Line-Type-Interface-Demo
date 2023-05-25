codeunit 50105 "Request Resource Line Impl."
{
    Access = Internal;

    procedure OnInsert(var Rec: Record "Request Line")
    begin
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

    local procedure ValidateNoField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Rec.Description := GetDescription(Rec."No.");
    end;

    local procedure ValidateQuantityField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Error('Procedure ValidateQuantityField not implemented.');
    end;

    local procedure ValidateStartingDateField(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Error('Procedure ValidateStartingDateField not implemented.');
    end;

    local procedure ValidateDurationDays(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        Error('Procedure ValidateDurationDays not implemented.');
    end;

    local procedure GetDescription(ItemNo: Code[20]): Text[100]
    var
        Resource: Record Resource;
    begin
        Resource.SetLoadFields(Name);
        if Resource.Get(ItemNo) then
            exit(Resource.Name);
    end;
}
