codeunit 50101 "Request Text Line" implements "Request Line"
{
    Access = Internal;

    procedure OnInsert(var Rec: Record "Request Line")
    begin
        RequestTextLineImpl.OnInsert(Rec);
    end;

    procedure OnModify(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        RequestTextLineImpl.OnModify(Rec, xRec);
    end;

    procedure OnDelete(var Rec: Record "Request Line")
    begin
        RequestTextLineImpl.OnDelete(Rec);
    end;

    procedure OnValidateField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer)
    begin
        RequestTextLineImpl.OnValidateField(Rec, xRec, CalledFromFieldNo);
    end;

    var
        RequestTextLineImpl: Codeunit "Request Text Line Impl.";
}
