codeunit 50107 "Request Generic Line"
{
    procedure CopyHeaderData(var RequestLine: Record "Request Line")
    var
        RequestHeader: Record "Request Header";
    begin
        RequestHeader.Get(RequestLine."Document No.");

        RequestLine."Customer No." := RequestHeader."Customer No.";
        RequestLine."Starting Date" := RequestHeader."Starting Date";
        RequestLine."Duration (Days)" := RequestHeader."Duration (Days)";
    end;

    procedure InitQuantity(var RequestLine: Record "Request Line")
    begin
        RequestLine.Validate(Quantity, 1);
    end;

    procedure VerifyStartingDate(RequestNo: Code[20]; LineStartingDate: Date)
    var
        RequestHeader: Record "Request Header";
    begin
        RequestHeader.SetLoadFields("Duration (Days)", "Starting Date");
        RequestHeader.Get(RequestNo);

        if LineStartingDate < RequestHeader."Starting Date" then
            Error(StartingDateErr, RequestHeader."Starting Date");
    end;

    procedure VerifyDuration(RequestNo: Code[20]; LineStartingDate: Date; LineDuration: Integer)
    var
        RequestHeader: Record "Request Header";
        HeaderFinishingDate: Date;
        LineFinishingDate: Date;
        DateExpression: Text;
    begin
        HeaderFinishingDate := RequestHeader.GetFinishingDate();
        DateExpression := StrSubstNo('<%1D>', LineDuration);
        LineFinishingDate := CalcDate(DateExpression, LineStartingDate);

        if LineFinishingDate > HeaderFinishingDate then
            Error(DurationErr, LineFinishingDate - HeaderFinishingDate);
    end;

    var
        StartingDateErr: Label 'Line starting date cannot precede header starting date (%1).', Comment = '%1 = Request header starting date';
        DurationErr: Label 'Duration cannot exceed %1 days with the current starting date on this line.', Comment = '%1 = The number of days that the duration exceeds the maximum duration.';
}
