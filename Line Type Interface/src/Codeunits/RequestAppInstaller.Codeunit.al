codeunit 50109 "Request App Installer"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InitNoSeries();
        InitPostingMapping();
    end;

    local procedure InitNoSeries()
    var
        RequestNoSeries: Codeunit "Request No. Series";
    begin
        RequestNoSeries.InitRequestNoSeries();
        RequestNoSeries.InitPostedRequestNoSeries();
    end;

    local procedure InitPostingMapping()
    var
        PostingMapping: Codeunit "Posting Mapping";
    begin
        PostingMapping.InitPostingMapping();
    end;
}
