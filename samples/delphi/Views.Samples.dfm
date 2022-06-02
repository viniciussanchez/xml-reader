object FrmSamples: TFrmSamples
  Left = 0
  Top = 0
  Caption = 'Samples'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmXML: TMemo
    Left = 24
    Top = 56
    Width = 585
    Height = 225
    TabOrder = 0
  end
  object btnReadString: TButton
    Left = 24
    Top = 15
    Width = 75
    Height = 25
    Caption = 'Read string'
    TabOrder = 1
    OnClick = btnReadStringClick
  end
  object btnReadFile: TButton
    Left = 105
    Top = 15
    Width = 75
    Height = 25
    Caption = 'Read file'
    TabOrder = 2
    OnClick = btnReadFileClick
  end
end
