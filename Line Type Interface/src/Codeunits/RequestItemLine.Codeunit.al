codeunit 50102 "Request Item Line" implements "Request Line"
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
        RequestItemLineImpl.OnValidateField(Rec, xRec, CalledFromFieldNo);
    end;

    procedure LookupField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer)
    begin
        RequestItemLineImpl.OnLookupField(Rec, xRec, CalledFromFieldNo);
    end;

    var
        RequestItemLineImpl: Codeunit "Request Item Line Impl.";
}
