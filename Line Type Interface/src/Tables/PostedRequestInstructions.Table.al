table 50108 "Posted Request Instructions"
{
    Caption = 'Posted Request Instructions';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Posted Request No."; Code[20])
        {
            Caption = 'Posted Request No.';
        }
        field(2; Instructions; Blob)
        {
            Caption = 'Instructions';
        }
    }
    keys
    {
        key(PK; "Posted Request No.")
        {
            Clustered = true;
        }
    }
}
