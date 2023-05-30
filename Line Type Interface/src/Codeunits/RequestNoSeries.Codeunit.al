codeunit 50108 "Request No. Series"
{
    Access = Internal;
    Permissions = tabledata "No. Series" = rim,
                  tabledata "No. Series Line" = rim;

    procedure InitRequestNoSeries()
    begin
        InitNoSeries(GetRequestNoSeriesCode());
        InitNoSeriesLine(GetRequestNoSeriesCode(), GetRequestNoSeriesStart());
    end;

    procedure GetRequestNoSeriesCode(): Code[20]
    begin
        exit('REQUESTS');
    end;

    procedure InitPostedRequestNoSeries()
    begin
        InitNoSeries(GetPostedRequestNoSeriesCode());
        InitNoSeriesLine(GetPostedRequestNoSeriesCode(), GetPostedRequestNoSeriesStart());
    end;

    procedure GetPostedRequestNoSeriesCode(): Code[20]
    begin
        exit('P-REQUESTS');
    end;

    local procedure GetRequestNoSeriesStart(): Code[20]
    begin
        exit('RQ-0001');
    end;

    local procedure GetPostedRequestNoSeriesStart(): Code[20]
    begin
        exit('PRQ-0001');
    end;

    local procedure InitNoSeries(RequestNoSeriesCode: Code[20])
    var
        NoSeries: Record "No. Series";
    begin
        if NoSeries.Get(RequestNoSeriesCode) then
            exit;

        NoSeries.Init();
        NoSeries.Validate(Code, RequestNoSeriesCode);
        NoSeries."Default Nos." := true;
        NoSeries.Insert(true);
    end;

    local procedure InitNoSeriesLine(RequestNoSeriesCode: Code[20]; RequestNoSeriesStart: Code[20])
    var
        NoSeriesLine: Record "No. Series Line";
    begin
        NoSeriesLine.SetRange("Series Code", RequestNoSeriesCode);
        if not NoSeriesLine.IsEmpty() then
            exit;

        NoSeriesLine.Init();
        NoSeriesLine.Validate("Series Code", RequestNoSeriesCode);
        NoSeriesLine.Validate("Starting No.", RequestNoSeriesStart);
        NoSeriesLine.Insert(true);
    end;
}
