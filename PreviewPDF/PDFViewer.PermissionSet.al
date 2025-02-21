permissionset 90000 PDFViewer
{
    Caption = 'PDF Viewer', Comment = 'ESP="Visualizador PDF"', MaxLength = 30;
    Assignable = true;
    Permissions = tabledata "PDF Viewer Buffer" = RIMD,
        table "PDF Viewer Buffer" = X,
        page "PDF Preview" = X;
}