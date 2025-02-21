controladdin "PDF Viewer"
{
    RequestedHeight = 1500;
    MinimumHeight = 1500;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;

    Scripts =
        './src/ControlAddIn/js/jquery-3.7.1.min.js',
        './src/ControlAddIn/js/bootstrap.bundle.min.js',
        './src/ControlAddIn/js/ViewerScript.js';
    StyleSheets =
        './src/ControlAddIn/css/bootstrap.min.css',
        './src/ControlAddIn/css/CustomStyles.css';

    #region Events

    event ViewerReady()

    event ReturnLoadedElementList(ElementList: JsonArray)

    #endregion

    #region Procedures

    procedure LoadElement(ElementID: Integer; ElementName: Text; ElementURL: Text; BlobAsBase64: Text; MediaASBase64: Text)

    procedure DisplayElement(ElementID: Integer)

    procedure GetLoadedElementList()

    #endregion
}