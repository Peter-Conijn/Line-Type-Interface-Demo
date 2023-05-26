/// <summary>
/// Interface to handle table triggers for request lines
/// </summary>
interface "Request Line"
{
    /// <summary>
    /// Handles the OnInsert table trigger for the request line
    /// </summary>
    /// <param name="Rec">The request line record being inserted</param>
    procedure OnInsert(var Rec: Record "Request Line")

    /// <summary>
    /// Handles the OnModify table trigger for the request line
    /// </summary>
    /// <param name="Rec">The request line record being modified</param>
    /// <param name="xRec">The request line record as it was last retrieved from the database</param>
    procedure OnModify(var Rec: Record "Request Line"; xRec: Record "Request Line")

    /// <summary>
    /// Handles the OnDelete table trigger for the request line
    /// </summary>
    /// <param name="Rec">The request line record being deleted</param>
    procedure OnDelete(var Rec: Record "Request Line")

    /// <summary>
    /// Handles the OnValidate trigger for the request line table fields
    /// </summary>
    /// <param name="Rec">The request line record on which a field validation is performed</param>
    /// <param name="xRec">The request line record as it was last retrieved from the database</param>
    /// <param name="CalledFromFieldNo">The number of the field that is being validated</param>
    procedure OnValidateField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer)

    /// <summary>
    /// Handles the OnLookup trigger for the request line table fields
    /// </summary>
    /// <param name="Rec">The request line record on which a field lookup is performed</param>
    /// <param name="xRec">The request line record as it was last retrieved from the database</param>
    /// <param name="CalledFromFieldNo">The number of the field for which the lookup is being done</param>
    procedure LookupField(var Rec: Record "Request Line"; xRec: Record "Request Line"; CalledFromFieldNo: Integer);
}
