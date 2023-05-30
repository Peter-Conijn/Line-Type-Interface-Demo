codeunit 50119 "Posting Mapping"
{
    Access = Internal;
    InherentPermissions = X;
    Permissions = tabledata "Request Posting Mapping" = RI;

    procedure InitPostingMapping()
    var
        LineTypes: List of [Integer];
        LineType: Integer;
    begin
        LineTypes := GetRequestLineTypeOrdinals();

        foreach LineType in LineTypes do
            InsertPostingMappingLine(LineType);
    end;

    local procedure GetRequestLineTypeOrdinals(): List of [Integer]
    begin
        exit(Enum::"Request Line Type".Ordinals());
    end;

    local procedure InsertPostingMappingLine(var LineType: Integer)
    var
        RequestPostingMapping: Record "Request Posting Mapping";
    begin
        if RequestPostingMapping.Get(Enum::"Request Line Type".FromInteger(LineType)) then
            exit;

        RequestPostingMapping.Init();

        RequestPostingMapping."Line Type" := Enum::"Request Line Type".FromInteger(LineType);
        case RequestPostingMapping."Line Type" of
            Enum::"Request Line Type"::" ":
                RequestPostingMapping."Posting Type" := Enum::"Request Posting Type"::" ";
            Enum::"Request Line Type"::Item:
                RequestPostingMapping."Posting Type" := Enum::"Request Posting Type"::Item;
            Enum::"Request Line Type"::Resource:
                RequestPostingMapping."Posting Type" := Enum::"Request Posting Type"::Resource;
        end;

        RequestPostingMapping.Insert(true);
    end;
}
