table 50102 "Request Line"
{
    Caption = 'Request Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(4; "Type"; Enum "Request Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[100])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(8; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(9; "Duration (Days)"; Integer)
        {
            Caption = 'Duration (Days)';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        ImplementRequestLine();
        RequestLine.OnInsert(Rec);
    end;

    trigger OnModify()
    begin
        ImplementRequestLine();
        RequestLine.OnModify(Rec, xRec);
    end;

    trigger OnDelete()
    begin
        ImplementRequestLine();
        RequestLine.OnDelete(Rec);
    end;

    local procedure ValidateField(CalledFromFieldNo: Integer)
    begin
        ImplementRequestLine();
        RequestLine.OnValidateField(Rec, xRec, CalledFromFieldNo);
    end;

    local procedure ImplementRequestLine()
    begin
        RequestLine := Rec.Type;
    end;

    var
        RequestLine: Interface "Request Line";
}
