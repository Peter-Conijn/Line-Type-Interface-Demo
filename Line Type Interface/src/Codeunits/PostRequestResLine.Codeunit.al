codeunit 50116 "Post Request Res. Line" implements "Post Request Line"
{
    Access = Internal;

    procedure PostRequestLine(var RequestLine: Record "Request Line"; PostedRequestNo: Code[20])
    var
        PostRequestTextLineImpl: Codeunit "Post Request Text Line Impl.";
    begin
        PostRequestTextLineImpl.PostRequestLine(RequestLine, PostedRequestNo);
    end;
}