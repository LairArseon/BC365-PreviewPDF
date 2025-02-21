
AttachmentList = [];

function InitIFrameElement() {
    let ctrlAddinElement = $("#controlAddIn");

    $('<iframe>', {
        src: '',
        id: 'AddInIFrame',
        frameborder: 0,
        scrolling: 'no'
    }).appendTo(ctrlAddinElement);
}
InitIFrameElement()

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ViewerReady', '');

class RecordAttachment {
    constructor(ElementNo, ElementName, URL, BLOBAsBase64, MediaAsBase64) {
        this.No = ElementNo;
        this.Name = ElementName;
        this.URL = URL;
        this.Base64BLOB = BLOBAsBase64;
        this.Base64Media = MediaAsBase64;
    }

    GetByNo(No) {
        ReturnElement = null;
        AttachmentList.forEach(element => {
            if (element.No = No) {
                ReturnElement = element;
            }
        });
        return ReturnElement
    }
}

function LoadElement(ElementNo, ElementName, URL, BLOBAsBase64, MediaAsBase64) {
    NewAttachment = new RecordAttachment(ElementNo, ElementName, URL, BLOBAsBase64, MediaAsBase64);
    AttachmentList.push(NewAttachment);
}

function DisplayElement(ElementNo) {
    let IFrameElement = $("#AddInIFrame");
    let ElementToDisplay = RecordAttachment.GetByNo(ElementNo);
    IFrameElement.attr('src', 'data:application/pdf;base64,' + ElementToDisplay.Base64BLOB);
}

function GetLoadedElementList() {
    ReturnElement = [];
    AttachmentList.forEach(element => {
        ReturnElement.push(element.No);
    });
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ReturnLoadedElementList', [ReturnElement]);
}