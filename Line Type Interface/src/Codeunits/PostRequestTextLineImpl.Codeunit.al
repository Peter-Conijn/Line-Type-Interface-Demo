codeunit 50113 "Post Request Text Line Impl." implements "Post Request Line"
{
    Access = Internal;

    procedure PostRequestLine(var RequestLine: Record "Request Line"; PostedRequestNo: Code[20])
    begin
        AddTextLineToEntityText(RequestLine.Description, PostedRequestNo);
    end;

    local procedure AddTextLineToEntityText(Description: Text[100]; PostedRequestNo: Code[20])
    var
        EntityText: Record "Entity Text";
    begin
        InitEntityTextord(EntityText, PostedRequestNo);
    end;

    local procedure InitEntityTextord(var EntityText: Record "Entity Text"; PostedRequestNo: Code[20])
    var
        PostedRequestHeader: Record "Posted Request Header";
    begin
        PostedRequestHeader.SetLoadFields(SystemId);
        PostedRequestHeader.Get(PostedRequestNo);

        if EntityText.Get(CompanyName(), Database::"Posted Request Header", PostedRequestHeader.SystemId, Enum::"Entity Text Scenario"::"Request Information") then
            exit;

        EntityText.Init();
        EntityText.Company := CopyStr(CompanyName(), 1, MaxStrLen(EntityText.Company));
        EntityText."Source Table Id" := Database::"Posted Request Header";
        EntityText."Source System Id" := PostedRequestHeader.SystemId;
        EntityText.Scenario := Enum::"Entity Text Scenario"::"Request Information";
        EntityText.Insert();
    end;
}
