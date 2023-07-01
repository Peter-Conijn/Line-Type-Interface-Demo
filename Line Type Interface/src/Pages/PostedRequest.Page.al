page 50105 "Posted Request"
{
    ApplicationArea = All;
    Caption = 'Posted Request';
    PageType = Document;
    SourceTable = "Posted Request Header";
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
            part(Lines; "Posted Request SubPage")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            part(Instructions; "Instructions Factbox")
            {
                SubPageLink = "Posted Request No." = field("No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        PlaceholderTxt: Label 'Request Details';
    begin
        CurrPage.Instructions.Page.SetSourceRecordLink(Rec."No.");
    end;
}
