codeunit 50109 "Request App Installer"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InitNoSeries();
    end;

    local procedure InitNoSeries()
    var
        RequestNoSeries: Codeunit "Request No. Series";
    begin
        RequestNoSeries.InitRequestNoSeries();
    end;
}
