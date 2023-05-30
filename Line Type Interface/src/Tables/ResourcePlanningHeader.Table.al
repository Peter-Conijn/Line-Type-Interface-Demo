table 50105 "Resource Planning Header"
{
    Caption = 'Resource Planning Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Planning ID"; Guid)
        {
            Caption = 'Planning ID';
            DataClassification = SystemMetadata;
        }
        field(2; "From Request"; Code[20])
        {
            Caption = 'From Request';
            DataClassification = CustomerContent;
        }
        field(3; "From Request ID"; Guid)
        {
            Caption = 'From Request ID';
            DataClassification = SystemMetadata;
        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CalcFields(Name);
            end;
        }
        field(6; Name; Text[100])
        {
            Caption = 'Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(7; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(8; "Duration (Days)"; Integer)
        {
            Caption = 'Duration (Days)';
            MinValue = 0;
            BlankZero = true;
        }
    }
    keys
    {
        key(PK; "Planning ID")
        {
            Clustered = true;
        }
        key(Key2; "From Request ID")
        {
            Unique = true;
        }
    }

    trigger OnInsert()
    begin
        if IsNullGuid("Planning ID") then
            "Planning ID" := CreateGuid();
    end;
}
