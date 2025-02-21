table 90000 "PDF Viewer Buffer"
{
    Caption = 'Viewer Buffer', Comment = 'ESP="Buffer Previsualización"';
    TableType = Temporary;
    DataClassification = CustomerContent;
    Extensible = true;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.', Comment = 'ESP="Nº"';
            AllowInCustomizations = Never;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            AllowInCustomizations = Always;
        }
        field(3; "URL"; Text[2048])
        {
            Caption = 'URL', Comment = 'ESP="URL"';
            AllowInCustomizations = Always;
        }
        field(4; Blob; Blob)
        {
            Caption = 'Element BLOB', Comment = 'ESP="BLOB Elemento"';
            AllowInCustomizations = Always;
        }
        field(5; Media; Media)
        {
            Caption = 'Element Media', Comment = 'ESP="Media Elemento"';
            AllowInCustomizations = Always;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Name)
        {

        }
        fieldgroup(Brick; Name, Media)
        {

        }
    }

    procedure GetBlobAsBase64() BlobAsBase64: Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        InStr: InStream;
    begin
        Rec.CalcFields(Blob);
        if not Rec.Blob.HasValue() then
            exit;

        Rec.Blob.CreateInStream(InStr);
        BlobAsBase64 := Base64Convert.ToBase64(InStr);
    end;

    procedure GetMediaAsBase64() MediaAsBase64: Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if not Rec.Media.HasValue() then
            exit;

        TempBlob.CreateOutStream(OutStr);
        Rec.Media.ExportStream(OutStr);
        TempBlob.CreateInStream(InStr);
        MediaAsBase64 := Base64Convert.ToBase64(InStr);
    end;
}