program samples;

uses
  Vcl.Forms,
  Views.Samples in 'Views.Samples.pas' {FrmSamples};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSamples, FrmSamples);
  Application.Run;
end.
