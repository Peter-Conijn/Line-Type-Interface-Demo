codeunit 50120 "Request Instructions"
{
    Access = Public;

    procedure SetInstructions(PostedRequestNo: Code[20]; NewInstructions: Text);
    var
        Instructions: Text;
    begin
        if Instructions = '' then
            exit;

        Instructions := GetInstructions(PostedRequestNo) + GetNewLineChar();
        Instructions += NewInstructions;

        SaveInstructions(PostedRequestNo, Instructions);
    end;

    procedure GetInstructions(PostedRequestNo: Code[20]) Instructions: Text;
    var
        PostedRequestInstructions: Record "Posted Request Instructions";
        InStream: InStream;
    begin
        if not PostedRequestInstructions.Get(PostedRequestNo) then
            exit;

        PostedRequestInstructions.CalcFields(Instructions);
        if not PostedRequestInstructions.Instructions.HasValue() then
            exit;

        PostedRequestInstructions.Instructions.CreateInStream(InStream, TextEncoding::UTF8);
        InStream.Read(Instructions);
    end;

    local procedure GetNewLineChar(): Text
    var
        TypeHelper: Codeunit "Type Helper";
    begin
        exit(TypeHelper.NewLine());
    end;

    local procedure SaveInstructions(PostedRequestNo: Code[20]; Instructions: Text)
    var
        PostedRequestInstructions: Record "Posted Request Instructions";
        OutStream: OutStream;
    begin
        InitInstructionsRecord(PostedRequestInstructions, PostedRequestNo);

        PostedRequestInstructions.Instructions.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.Write(Instructions);

        PostedRequestInstructions.Modify();
    end;

    local procedure InitInstructionsRecord(var PostedRequestInstructions: Record "Posted Request Instructions"; PostedRequestNo: Code[20])
    begin
        if PostedRequestInstructions.Get(PostedRequestNo) then
            exit;

        PostedRequestInstructions.Init();
        PostedRequestInstructions."Posted Request No." := PostedRequestNo;
        PostedRequestInstructions.Insert(true);
    end;
}
