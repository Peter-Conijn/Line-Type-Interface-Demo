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
            DataClassification = CustomerContent;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(5; "Duration (Days)"; Integer)
        {
            Caption = 'Duration (Days)';
            DataClassification = CustomerContent;
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
        "Starting Date" := WorkDate();
        "Duration (Days)" := 1;
    end;

    procedure GetFinishingDate(): Date
    var
        DateExpression: Text;
    begin
        if "Starting Date" = 0D then
            exit;

        DateExpression := StrSubstNo('<%1>', "Duration (Days)");
        exit(CalcDate(DateExpression, "Starting Date"));
    end;
}
