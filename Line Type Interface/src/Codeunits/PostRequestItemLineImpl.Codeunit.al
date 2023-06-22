codeunit 50115 "Post Request Item Line Impl." implements "Post Request Line"
{
    Access = Internal;

    procedure PostRequestLine(var RequestLine: Record "Request Line"; PostedRequestNo: Code[20])
    var
        PostedRequestHeader: Record "Posted Request Header";
        PartsPlanningHeader: Record "Parts Planning Header";
    begin
        PostedRequestHeader.Get(PostedRequestNo);

        PartsPlanningHeader := InitPartsPlanningHeader(PostedRequestHeader);
        AddLineToPartsPlanning(PartsPlanningHeader, RequestLine);
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Parts Planning Header", 'ri')]
    local procedure InitPartsPlanningHeader(var PostedRequestHeader: Record "Posted Request Header") PartsPlanningHeader: Record "Parts Planning Header"
    begin
        PartsPlanningHeader.SetCurrentKey("From Request");
        PartsPlanningHeader.SetRange("From Request ID", PostedRequestHeader.SystemId);
        if PartsPlanningHeader.FindFirst() then
            exit;

        PartsPlanningHeader.Init();
        PartsPlanningHeader."Customer No." := PostedRequestHeader."Customer No.";
        PartsPlanningHeader."From Request" := PostedRequestHeader."No.";
        PartsPlanningHeader."From Request ID" := PostedRequestHeader.SystemId;
        PartsPlanningHeader."Starting Date" := PostedRequestHeader."Starting Date";
        PartsPlanningHeader.Insert(true);
    end;

    local procedure AddLineToPartsPlanning(var PartsPlanningHeader: Record "Parts Planning Header"; var RequestLine: Record "Request Line")
    var
        PartsPlanningLine: Record "Parts Planning Line";
    begin
        PartsPlanningLine.Init();
        PartsPlanningLine."Planning ID" := PartsPlanningHeader."Planning ID";
        PartsPlanningLine."Line No." := GetNewLineNo(PartsPlanningLine."Planning ID");
        PartsPlanningLine."Customer No." := PartsPlanningHeader."Customer No.";

        PartsPlanningLine."No." := RequestLine."No.";
        PartsPlanningLine.Quantity := RequestLine.Quantity;
        PartsPlanningLine."Starting Date" := RequestLine."Starting Date";

        PartsPlanningLine.Insert(true);
    end;

    local procedure GetNewLineNo(PlanningID: Code[20]) NewLineNo: Integer
    var
        PartsPlanningLine: Record "Parts Planning Line";
    begin
        NewLineNo := 10000;

        PartsPlanningLine.SetLoadFields("Line No.");
        PartsPlanningLine.SetRange("Planning ID", PlanningID);
        if PartsPlanningLine.FindLast() then
            NewLineNo += PartsPlanningLine."Line No.";
    end;
}
