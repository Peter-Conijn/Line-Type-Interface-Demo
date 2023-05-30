codeunit 50112 "Post Request Text Line" implements "Post Request Line"
{
    Access = Internal;

    procedure PostRequestLine(var RequestLine: Record "Request Line"; PostedRequestNo: Code[20])
    var
        PostRequestTextLineImpl: Codeunit "Post Request Text Line Impl.";
    begin
        PostRequestTextLineImpl.PostRequestLine(RequestLine, PostedRequestNo);
    end;
}
