table 50101 "Request Header"
{
    Caption = 'Request Header';
    DataClassification = CustomerContent;
    LookupPageId = Requests;
    DrillDownPageId = Requests;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                TestNoSeriesManual();
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CalcFields(Name);
            end;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(5; "Duration (Days)"; Integer)
        {
            Caption = 'Duration (Days)';
            MinValue = 0;
            BlankZero = true;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        InitNoSeries();

        "Starting Date" := WorkDate();
        "Duration (Days)" := 1;
    end;

    trigger OnDelete()
    begin
        DeleteRequestLines();
    end;

    procedure GetFinishingDate(): Date
    var
        DateExpression: Text;
    begin
        if "Starting Date" = 0D then
            exit;

        DateExpression := StrSubstNo('<%1D>', "Duration (Days)");
        exit(CalcDate(DateExpression, "Starting Date"));
    end;

    local procedure InitNoSeries()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesCode: Code[20];
    begin
        if "No." <> '' then
            exit;

        TestNoSeries();
        NoSeriesCode := GetNoSeriesCode();
        NoSeriesMgt.InitSeries(NoSeriesCode, NoSeriesCode, WorkDate(), "No.", NoSeriesCode);
    end;

    local procedure TestNoSeries()
    var
        RequestNoSeries: Codeunit "Request No. Series";
    begin
        RequestNoSeries.InitRequestNoSeries();
    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        RequestNoSeries: Codeunit "Request No. Series";
    begin
        exit(RequestNoSeries.GetRequestNoSeriesCode());
    end;

    local procedure TestNoSeriesManual()
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        case true of
            "No." = '',
            CurrFieldNo <> FieldNo("No."):
                exit;
        end;

        NoSeriesManagement.TestManual(GetNoSeriesCode());
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Request Line", 'd')]
    local procedure DeleteRequestLines()
    var
        RequestLine: Record "Request Line";
    begin
        RequestLine.SetRange("Document No.", "No.");
        if not RequestLine.IsEmpty() then
            RequestLine.DeleteAll(true);
    end;
}
