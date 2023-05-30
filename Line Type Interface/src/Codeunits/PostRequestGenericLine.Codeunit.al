codeunit 50118 "Post Request Generic Line"
{
    procedure CreateOrGetResourcePlanningHeader(RequestId: Guid) ResourcePlanningHeader: Record "Resource Planning Header";
    begin
        ResourcePlanningHeader.SetCurrentKey("From Request ID");
        ResourcePlanningHeader.SetRange("From Request ID", RequestId);
        if ResourcePlanningHeader.FindFirst() then
            exit;

        ResourcePlanningHeader.LockTable();
        ResourcePlanningHeader.Init();

        AddFieldsFromRequestHeader(ResourcePlanningHeader, RequestId);

        ResourcePlanningHeader.Insert(true);
    end;

    procedure CreateOrGetPartsPlanningHeader(RequestId: Guid) PartsPlanningHeader: Record "Parts Planning Header";
    begin
        PartsPlanningHeader.SetCurrentKey("From Request ID");
        PartsPlanningHeader.SetRange("From Request ID", RequestId);
        if PartsPlanningHeader.FindFirst() then
            exit;

        PartsPlanningHeader.LockTable();
        PartsPlanningHeader.Init();

        AddFieldsFromRequestHeader(PartsPlanningHeader, RequestId);

        PartsPlanningHeader.Insert(true);
    end;

    local procedure AddFieldsFromRequestHeader(var ResourcePlanningHeader: Record "Resource Planning Header"; RequestId: Guid)
    var
        RequestHeader: Record "Request Header";
    begin
        RequestHeader.GetBySystemId(RequestId);

        ResourcePlanningHeader."From Request" := RequestHeader."No.";
        ResourcePlanningHeader."From Request ID" := RequestId;
        ResourcePlanningHeader."Customer No." := RequestHeader."Customer No.";
        ResourcePlanningHeader."Starting Date" := RequestHeader."Starting Date";
        ResourcePlanningHeader."Duration (Days)" := RequestHeader."Duration (Days)";
    end;

    local procedure AddFieldsFromRequestHeader(var PartsPlanningHeader: Record "Parts Planning Header"; RequestId: Guid)
    var
        RequestHeader: Record "Request Header";
    begin
        RequestHeader.GetBySystemId(RequestId);

        PartsPlanningHeader."From Request" := RequestHeader."No.";
        PartsPlanningHeader."From Request ID" := RequestId;
        PartsPlanningHeader."Customer No." := RequestHeader."Customer No.";
        PartsPlanningHeader."Starting Date" := RequestHeader."Starting Date";
    end;
}
