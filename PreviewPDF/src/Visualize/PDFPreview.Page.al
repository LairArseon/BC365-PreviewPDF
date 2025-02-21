page 90000 "PDF Preview"
{
    Caption = 'PDF Preview', Comment = 'ESP="Previsualización PDF"';
    DataCaptionFields = "No.";
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PDF Viewer Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            usercontrol(PDFViewer; "PDF Viewer")
            {
                trigger ViewerReady()
                begin
                    LoadFirstElement();
                end;

                trigger ReturnLoadedElementList(ElementList: JsonArray)
                var
                    JsonToken, JsonInnerToken : JsonToken;
                    JsonObject: JsonObject;
                begin
                    Clear(LoadedElementList);
                    foreach JsonToken in ElementList do begin
                        JsonObject := JsonToken.AsObject();
                        JsonObject.Get('No', JsonInnerToken);
                        LoadedElementList.Add(JsonInnerToken.AsValue().AsInteger());
                    end;
                end;
            }
        }
    }

    var
        LoadedElementList: List of [Integer];

    local procedure LoadFirstElement()
    var
        IsHandled: Boolean;
    begin
        OnBeforeLoadFirstElement(IsHandled);
        if IsHandled then
            exit;

        if Rec.FindFirst() then
            LoadElement(Rec);

        OnAfterLoadFirstElement();
    end;

    local procedure LoadElement(var PDFViewerBuffer: Record "PDF Viewer Buffer" temporary)
    var
        IsHandled: Boolean;
    begin
        OnBeforeLoadElement(PDFViewerBuffer, IsHandled);
        if IsHandled then
            exit;

        CurrPage.PDFViewer.LoadElement(
            PDFViewerBuffer."No.",
            PDFViewerBuffer.Name,
            PDFViewerBuffer.URL,
            PDFViewerBuffer.GetBlobAsBase64(),
            PDFViewerBuffer.GetMediaAsBase64());

        CurrPage.PDFViewer.DisplayElement(PDFViewerBuffer."No.");

        OnAfterLoadElement(PDFViewerBuffer);
    end;

    #region Integration Events

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLoadFirstElement(var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLoadFirstElement()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLoadElement(var PDFViewerBuffer: Record "PDF Viewer Buffer" temporary; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLoadElement(var PDFViewerBuffer: Record "PDF Viewer Buffer" temporary)
    begin
    end;

    #endregion Integration Events

}