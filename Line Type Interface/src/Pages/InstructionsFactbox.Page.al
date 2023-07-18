page 50107 "Instructions Factbox"
{
    ApplicationArea = All;
    Caption = 'Instructions Factbox';
    PageType = CardPart;
    SourceTable = "Posted Request Instructions";

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;

                field(InstructionsText; GetInstructions())
                {
                    Caption = 'Instructions';
                    MultiLine = true;
                    Editable = false;
                    ExtendedDatatype = RichContent;
                }
            }
        }
    }

    procedure SetSourceRecordLink(PostedRequestNo: Code[20])
    begin
        GlobalPostedRequestNo := PostedRequestNo;
    end;

    local procedure GetInstructions(): Text
    var
        RequestInstructions: Codeunit "Request Instructions";
    begin
        if GlobalPostedRequestNo = '' then
            exit;

        exit(RequestInstructions.GetInstructions(Rec."Posted Request No."));
    end;

    var
        GlobalPostedRequestNo: Code[20];
}
