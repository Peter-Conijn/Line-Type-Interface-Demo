page 50102 Request
{
    ApplicationArea = All;
    Caption = 'Request';
    PageType = Document;
    SourceTable = "Request Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Finishing Date"; Rec.GetFinishingDate())
                {
                    ToolTip = 'Specifies the date that the request requirements end.';
                    Editable = false;
                }
            }
            part(RequestLines; "Request SubPage")
            {
                SubPageLink = "Document No." = Field("No.");
                UpdatePropagation = Both;
            }
        }
    }
}
