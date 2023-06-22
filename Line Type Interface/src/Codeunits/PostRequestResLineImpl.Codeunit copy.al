codeunit 50117 "Post Request Res. Line Impl." implements "Post Request Line"
{
    Access = Internal;

    procedure PostRequestLine(var RequestLine: Record "Request Line"; PostedRequestNo: Code[20])
    var
        PostedRequestHeader: Record "Posted Request Header";
        ResourcePlanningHeader: Record "Resource Planning Header";
    begin
        PostedRequestHeader.Get(PostedRequestNo);

        ResourcePlanningHeader := InitResourcePlanningHeader(PostedRequestHeader);
        AddLineToResourcePlanning(ResourcePlanningHeader, RequestLine);
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Resource Planning Header", 'ri')]
    local procedure InitResourcePlanningHeader(var PostedRequestHeader: Record "Posted Request Header") ResourcePlanningHeader: Record "Resource Planning Header"
    begin
        ResourcePlanningHeader.SetCurrentKey("From Request");
        ResourcePlanningHeader.SetRange("From Request ID", PostedRequestHeader.SystemId);
        if ResourcePlanningHeader.FindFirst() then
            exit;

        ResourcePlanningHeader.Init();
        ResourcePlanningHeader."Customer No." := PostedRequestHeader."Customer No.";
        ResourcePlanningHeader."From Request" := PostedRequestHeader."No.";
        ResourcePlanningHeader."From Request ID" := PostedRequestHeader.SystemId;
        ResourcePlanningHeader."Starting Date" := PostedRequestHeader."Starting Date";
        ResourcePlanningHeader.Insert(true);
    end;

    local procedure AddLineToResourcePlanning(var ResourcePlanningHeader: Record "Resource Planning Header"; var RequestLine: Record "Request Line")
    var
        ResourcePlanningLine: Record "Resource Planning Line";
    begin
        ResourcePlanningLine.Init();
        ResourcePlanningLine."Planning ID" := ResourcePlanningHeader."Planning ID";
        ResourcePlanningLine."Line No." := GetNewLineNo(ResourcePlanningLine."Planning ID");
        ResourcePlanningLine."Customer No." := ResourcePlanningHeader."Customer No.";

        ResourcePlanningLine."No." := RequestLine."No.";
        ResourcePlanningLine.Quantity := RequestLine.Quantity;
        ResourcePlanningLine."Starting Date" := RequestLine."Starting Date";

        ResourcePlanningLine.Insert(true);
    end;

    local procedure GetNewLineNo(PlanningID: Code[20]) NewLineNo: Integer
    var
        ResourcePlanningLine: Record "Resource Planning Line";
    begin
        NewLineNo := 10000;

        ResourcePlanningLine.SetLoadFields("Line No.");
        ResourcePlanningLine.SetRange("Planning ID", PlanningID);
        if ResourcePlanningLine.FindLast() then
            NewLineNo += ResourcePlanningLine."Line No.";
    end;
}
