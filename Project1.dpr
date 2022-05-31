program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {FrmSamples},
  Xml.Reader.Intf in 'src\Xml.Reader.Intf.pas',
  Xml.Reader.Element.Intf in 'src\Xml.Reader.Element.Intf.pas',
  Xml.Reader.Node.Intf in 'src\Xml.Reader.Node.Intf.pas',
  Xml.Reader.Attribute.Intf in 'src\Xml.Reader.Attribute.Intf.pas',
  Xml.Reader in 'src\Xml.Reader.pas',
  Xml.Reader.Node in 'src\Xml.Reader.Node.pas',
  Xml.Reader.Attribute in 'src\Xml.Reader.Attribute.pas',
  Xml.Reader.Element in 'src\Xml.Reader.Element.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSamples, FrmSamples);
  Application.Run;
end.
