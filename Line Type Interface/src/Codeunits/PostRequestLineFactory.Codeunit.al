codeunit 50111 "Post Request Line Factory"
{
    Access = Internal;

    procedure GetPostingEngine(RequestLineType: Enum "Request Line Type"): Interface "Post Request Line"
    var
        RequestPostingMapping: Record "Request Posting Mapping";
    begin
        RequestPostingMapping.Get(RequestLineType);
        exit(RequestPostingMapping."Posting Type");
    end;
}
