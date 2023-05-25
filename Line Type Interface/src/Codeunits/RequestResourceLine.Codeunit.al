codeunit 50103 "Request Resource Line" implements "Request Line"
{
    Access = Internal;

    procedure OnInsert(var Rec: Record "Request Line")
    begin
        RequestResourceLineImpl.OnInsert(Rec);
    end;

    procedure OnModify(var Rec: Record "Request Line"; xRec: Record "Request Line")
    begin
        RequestResourceLineImpl.OnModify(Rec, xRec);
    end;

    procedure OnDelete(var Rec: Record "Request Line")
    begin
        RequestResourceLineImpl.OnDelete(Rec);
    end;

    procedure OnValidateField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer)
    begin
        RequestResourceLineImpl.OnValidateField(Rec, xRec, CalledFromFieldNo);
    end;

    var
        RequestResourceLineImpl: Codeunit "Request Resource Line Impl.";
}
