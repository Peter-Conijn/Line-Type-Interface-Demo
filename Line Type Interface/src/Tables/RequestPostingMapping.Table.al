table 50100 "Request Posting Mapping"
{
    Caption = 'Request Posting Mapping';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line Type"; Enum "Request Line Type")
        {
            Caption = 'Line Type';
        }
        field(2; "Posting Type"; Enum "Request Posting Type")
        {
            Caption = 'Posting Type';
        }
    }
    keys
    {
        key(PK; "Line Type")
        {
            Clustered = true;
        }
    }
}
