codeunit 50107 "Request Generic Line"
{
    procedure CopyHeaderData(var RequestLine: Record "Request Line")
    var
        RequestHeader: Record "Request Header";
    begin
        RequestHeader.Get();

        RequestLine."Customer No." := RequestHeader."Customer No.";
        RequestLine."Starting Date" := RequestHeader."Starting Date";
        RequestLine."Duration (Days)" := RequestHeader."Duration (Days)";
    end;

    procedure InitQuantity(var RequestLine: Record "Request Line")
    begin
        RequestLine.Validate(Quantity, 1);
    end;
}
