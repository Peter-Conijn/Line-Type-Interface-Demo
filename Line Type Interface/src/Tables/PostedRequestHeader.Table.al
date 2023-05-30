table 50103 "Posted Request Header"
{
    Caption = 'Request Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
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
}