codeunit 50113 "Post Request Text Line Impl." implements "Post Request Line"
{
    Access = Internal;

    procedure PostRequestLine(var RequestLine: Record "Request Line"; PostedRequestNo: Code[20])
    begin
        AddTextLineToInstructions(RequestLine.Description, PostedRequestNo);
    end;

    local procedure AddTextLineToInstructions(Description: Text[100]; PostedRequestNo: Code[20])
    var
        RequestInstructions: Codeunit "Request Instructions";
    begin
        RequestInstructions.SetInstructions(PostedRequestNo, Description);
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
