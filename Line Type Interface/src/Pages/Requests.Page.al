page 50101 Requests
{
    ApplicationArea = All;
    Caption = 'Requests';
    PageType = List;
    CardPageId = Request;
    SourceTable = "Request Header";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
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
