table 50104 "Posted Request Line"
{
    Caption = 'Request Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
        }
        field(4; "Type"; Enum "Request Line Type")
        {
            Caption = 'Type';
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(" ")) "Standard Text" else
            if (Type = const(Item)) Item else
            if (Type = const(Resource)) Resource;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            MinValue = 0;
        }
        field(8; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(9; "Duration (Days)"; Integer)
        {
            Caption = 'Duration (Days)';
            BlankZero = true;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
