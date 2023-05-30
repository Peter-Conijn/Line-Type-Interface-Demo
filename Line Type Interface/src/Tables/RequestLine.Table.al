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
            Editable = false;
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
            TableRelation = if (Type = const(" ")) "Standard Text" else
            if (Type = const(Item)) Item else
            if (Type = const(Resource)) Resource;

            trigger OnValidate()
            begin
                ValidateField(FieldNo("No."));
            end;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateField(FieldNo(Description));
            end;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            MinValue = 0;

            trigger OnValidate()
            begin
                ValidateField(FieldNo(Quantity));
            end;
        }
        field(8; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateField(FieldNo("Starting Date"));
            end;
        }
        field(9; "Duration (Days)"; Integer)
        {
            Caption = 'Duration (Days)';
            DataClassification = CustomerContent;
            BlankZero = true;
            MinValue = 0;

            trigger OnValidate()
            begin
                ValidateField(FieldNo("Duration (Days)"));
            end;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type)
        {
            IncludedFields = "No.";
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

    local procedure LookupField(CalledFromFieldNo: Integer)
    begin
        ImplementRequestLine();
        RequestLine.LookupField(Rec, xRec, CalledFromFieldNo);
    end;

    local procedure ImplementRequestLine()
    begin
        RequestLine := Rec.Type;
    end;

    var
        RequestLine: Interface "Request Line";
}
