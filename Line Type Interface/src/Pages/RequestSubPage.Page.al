page 50103 "Request SubPage"
{
    ApplicationArea = All;
    Caption = 'Request SubPage';
    PageType = ListPart;
    SourceTable = "Request Line";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Duration (Days)"; Rec."Duration (Days)")
                {
                    ToolTip = 'Specifies the value of the Duration (Days) field.';
                }
            }
        }
    }
}
