enum 50100 "Request Line Type" implements "Request Line"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
        Implementation = "Request Line" = "Request Text Line";
    }
    value(1; Item)
    {
        Caption = 'Item';
        Implementation = "Request Line" = "Request Item Line";
    }
    value(2; Resource)
    {
        Caption = 'Resource';
        Implementation = "Request Line" = "Request Resource Line";
    }
}