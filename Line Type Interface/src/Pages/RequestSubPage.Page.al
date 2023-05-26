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
                    ToolTip = 'Specifies the type of entity will be selected for this line.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the selected entity on the line.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies details about the selected entity on the line.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies how many of the entity in question is required.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the start of the period that this entity is required. This may not precede the starting date on the request header.';
                }
                field("Duration (Days)"; Rec."Duration (Days)")
                {
                    ToolTip = 'Specifies for how many days the entity will be required. The starting date plus duration may not exceed the finishing date on the header.';
                }
            }
        }
    }
}
