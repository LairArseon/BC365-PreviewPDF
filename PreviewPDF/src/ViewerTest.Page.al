page 90001 ViewerTest
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                var
                    PDFViewerBuffer: Record "PDF Viewer Buffer";
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                begin
                    UploadIntoStream('Upload PDF', '', '', FileName, InStr);

                    PDFViewerBuffer."No." := 1;
                    PDFViewerBuffer.Name := CopyStr(FileName, 1, MaxStrLen(PDFViewerBuffer.Name));
                    PDFViewerBuffer.Blob.CreateOutStream(OutStr);
                    CopyStream(OutStr, InStr);
                    PDFViewerBuffer.Insert(true);

                    Page.Run(Page::"PDF Preview", PDFViewerBuffer);
                end;
            }
        }
    }
}