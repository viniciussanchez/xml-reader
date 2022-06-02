unit Views.Samples;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.Reader, Vcl.StdCtrls;

type
  TFrmSamples = class(TForm)
    mmXML: TMemo;
    btnReadString: TButton;
    btnReadFile: TButton;
    procedure btnReadStringClick(Sender: TObject);
    procedure btnReadFileClick(Sender: TObject);
  private
    procedure DoPrintElement(const AElement: IXmlElement);
    procedure DoPrintAttribute(const AAttribute: IXmlAttribute);
    procedure DoPrintNode(const ANode: IXmlNode);
    procedure Read(const AXml: IXmlReader);
  end;

var
  FrmSamples: TFrmSamples;

implementation

{$R *.dfm}

const
  XML = '<?xml version="1.0" encoding="UTF-8"?><developer mvp="true"><firstName>Vinicius</firstName>' +
    '<lastName>Sanchez</lastName><age/><projects><Boss>yes</Boss><DataSet-Serialize>yes</DataSet-Serialize>' +
    '<RESTRequest4Delphi>yes</RESTRequest4Delphi><BCrypt>yes</BCrypt><Horse>yes</Horse></projects></developer>';

procedure TFrmSamples.btnReadFileClick(Sender: TObject);
begin
  Read(TXmlReader.New.LoadFromFile('D:\Projetos\delphi\xml-reader\samples\delphi\teste.xml'));
end;

procedure TFrmSamples.btnReadStringClick(Sender: TObject);
begin
  Read(TXmlReader.New.LoadFromString(XML));
end;

procedure TFrmSamples.DoPrintAttribute(const AAttribute: IXmlAttribute);
begin
  mmXML.Lines.Add('[Attribute] Name: ' + AAttribute.Name + ' value: ' + AAttribute.AsString);
end;

procedure TFrmSamples.DoPrintElement(const AElement: IXmlElement);
begin
  mmXML.Lines.Add('[Element] Name: ' + AElement.Name + ' value: ' + AElement.AsString);
end;

procedure TFrmSamples.DoPrintNode(const ANode: IXmlNode);
var
  LElement: IXmlElement;
  LAttribute: IXmlAttribute;
  LNode: IXmlNode;
begin
  mmXML.Lines.Add('[Node] Name: ' + ANode.Name);

  for LAttribute in ANode.Attributes do
    DoPrintAttribute(LAttribute);

  for LElement in ANode.Elements do
    DoPrintElement(LElement);

  for LNode in ANode.Nodes do
    DoPrintNode(LNode);
end;

procedure TFrmSamples.Read(const AXml: IXmlReader);
begin
  mmXML.Lines.Add('Version: ' + AXml.Version);
  mmXML.Lines.Add('Encoding: ' + AXml.Encoding);
  DoPrintNode(AXml.Node);
end;

end.
