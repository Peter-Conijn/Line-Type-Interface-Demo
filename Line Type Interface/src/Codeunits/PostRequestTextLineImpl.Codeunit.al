codeunit 50113 "Post Request Text Line Impl." implements "Post Request Line"
{
    Access = Internal;

    procedure PostRequestLine(var RequestLine: Record "Request Line"; PostedRequestNo: Code[20])
    var
        RequestHasItemLines: Boolean;
        RequestHasResourceLines: Boolean;
    begin
        RequestHasItemLines := HasItemLines(RequestLine."Document No.");
        RequestHasResourceLines := HasResourceLines(RequestLine."Document No.");

        if RequestHasItemLines then
            AddLineToPartsPlanning(RequestLine);
        if RequestHasResourceLines then
            AddLineToResourcePlanning(RequestLine);
    end;

    local procedure HasItemLines(DocumentNo: Code[20]): Boolean
    begin
        exit(HasLinesOfType(DocumentNo, Enum::"Request Line Type"::Item));
    end;

    local procedure HasResourceLines(DocumentNo: Code[20]): Boolean
    begin
        exit(HasLinesOfType(DocumentNo, Enum::"Request Line Type"::Resource));
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Request Line", 'R')]
    local procedure HasLinesOfType(DocumentNo: Code[20]; RequestLineType: Enum "Request Line Type"): Boolean
    var
        RequestLine: Record "Request Line";
    begin
        RequestLine.SetCurrentKey(Type);
        RequestLine.SetRange(Type);
        exit(not RequestLine.IsEmpty());
    end;

    local procedure AddLineToPartsPlanning(var RequestLine: Record "Request Line")
    begin
        Error('Procedure AddLineToPartsPlanning not implemented.');
    end;

    local procedure AddLineToResourcePlanning(var RequestLine: Record "Request Line")
    begin
        Error('Procedure AddLineToResourcePlanning not implemented.');
    end;
}
