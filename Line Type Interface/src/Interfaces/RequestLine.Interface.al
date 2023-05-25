interface "Request Line"
{
    procedure OnInsert(var Rec: Record "Request Line")

    procedure OnModify(var Rec: Record "Request Line"; xRec: Record "Request Line")

    procedure OnDelete(var Rec: Record "Request Line")

    procedure OnValidateField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer)
}
