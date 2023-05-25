page 50100 "Request Posting Mapping"
{
    ApplicationArea = All;
    Caption = 'Request Posting Mapping';
    PageType = List;
    SourceTable = "Request Posting Mapping";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line Type"; Rec."Line Type")
                {
                    ToolTip = 'Specifies the value of the Line Type field.';
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ToolTip = 'Specifies the value of the Posting Type field.';
                }
            }
        }
    }
}
