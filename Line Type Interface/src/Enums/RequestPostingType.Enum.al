enum 50101 "Request Posting Type" implements "Post Request Line"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
        Implementation = "Post Request Line" = "Post Request Text Line";
    }
    value(1; Item)
    {
        Caption = 'Item';
        Implementation = "Post Request Line" = "Post Request Item Line";
    }
    value(2; Resource)
    {
        Caption = 'Resource';
        Implementation = "Post Request Line" = "Post Request Res. Line";
    }
}