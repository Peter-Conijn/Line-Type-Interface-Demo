codeunit 50110 "Post Request"
{
    Access = Public;
    TableNo = "Request Header";

    trigger OnRun()
    var
        RequestHeader: Record "Request Header";
    begin
        RequestHeader := Rec;

        Post(RequestHeader);

        Rec := RequestHeader;
    end;

    procedure PostRequestWithUI(var RequestHeader: Record "Request Header")
    var
        ConfirmManagement: Codeunit "Confirm Management";
        PostRequestQst: Label 'Do you want to post request %1?', Comment = '%1 = The number of the request to be posted.';
    begin
        if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(PostRequestQst, RequestHeader."No."), false) then
            exit;

        Codeunit.Run(Codeunit::"Post Request", RequestHeader);
    end;

    local procedure Post(var RequestHeader: Record "Request Header")
    var
        PostedRequestNo: Code[20];
    begin
        Commit();

        PostedRequestNo := CreatePostedRequest(RequestHeader);
        CreatePostedDocuments(RequestHeader, PostedRequestNo);
        DeleteRequest(RequestHeader);
    end;

    local procedure CreatePostedRequest(var RequestHeader: Record "Request Header"): Code[20]
    var
        PostedRequestNo: Code[20];
    begin
        PostedRequestNo := CreatePostedRequestHeader(RequestHeader);
        CreatePostedRequestLines(PostedRequestNo, RequestHeader."No.");

        exit(PostedRequestNo);
    end;

    local procedure CreatePostedDocuments(var RequestHeader: Record "Request Header"; PostedRequestNo: Code[20])
    var
        RequestLine: Record "Request Line";
        PostRequestLineFactory: Codeunit "Post Request Line Factory";
        PostRequestLine: Interface "Post Request Line";
    begin
        RequestLine.SetRange("Document No.", RequestHeader."No.");
        if not RequestLine.FindSet() then
            exit;

        PostRequestLine := PostRequestLineFactory.GetPostingEngine(RequestLine.Type);
        PostRequestLine.PostRequestLine(RequestLine, PostedRequestNo);
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Request Header", 'd')]
    local procedure DeleteRequest(var RequestHeader: Record "Request Header")
    begin
        RequestHeader.Delete(true);
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Posted Request Header", 'im')]
    local procedure CreatePostedRequestHeader(var RequestHeader: Record "Request Header"): Code[20]
    var
        PostedRequestHeader: Record "Posted Request Header";
    begin
        PostedRequestHeader.LockTable();

        PostedRequestHeader.Init();
        PostedRequestHeader."No." := GetNextPostedRequestNo();
        PostedRequestHeader.Insert(true);

        PostedRequestHeader.TransferFields(RequestHeader);
        PostedRequestHeader.Modify(true);

        exit(PostedRequestHeader."No.")
    end;

    local procedure GetNextPostedRequestNo(): Code[20]
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesCode: Code[20];
        NewNo: Code[20];
    begin
        NoSeriesCode := GetNoSeriesCode();
        NoSeriesMgt.InitSeries(NoSeriesCode, NoSeriesCode, WorkDate(), NewNo, NoSeriesCode);

        exit(NewNo);
    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        RequestNoSeries: Codeunit "Request No. Series";
    begin
        exit(RequestNoSeries.GetPostedRequestNoSeriesCode());
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Posted Request Line", 'im')]
    [InherentPermissions(PermissionObjectType::TableData, Database::"Request Line", 'r')]
    local procedure CreatePostedRequestLines(PostedRequestNo: Code[20]; RequestNo: Code[20])
    var
        RequestLine: Record "Request Line";
    begin
        RequestLine.SetRange("Document No.", RequestNo);
        if not RequestLine.FindSet() then
            exit;

        repeat
            CreatePostedRequestLine(PostedRequestNo, RequestLine);
        until RequestLine.Next() = 0;
    end;

    local procedure CreatePostedRequestLine(var PostedRequestNo: Code[20]; var RequestLine: Record "Request Line")
    var
        PostedRequestLine: Record "Posted Request Line";
    begin
        PostedRequestLine.LockTable();

        PostedRequestLine.Init();
        PostedRequestLine."Document No." := PostedRequestNo;
        PostedRequestLine."Line No." := RequestLine."Line No.";
        PostedRequestLine.Insert(true);

        PostedRequestLine.TransferFields(RequestLine);
        PostedRequestLine.Modify(true);
    end;
}
