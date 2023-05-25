codeunit 50101 "Request Text Line" implements "Request Line"
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
    end;
}
