table 50109 "Parts Planning Line"
{
    Caption = 'Request Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Planning ID"; Code[20])
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
            if (Type = const(Item)) Item;
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
    }

    keys
    {
        key(PK; "Planning ID", "Line No.")
        {
            Clustered = true;
        }
    }
}