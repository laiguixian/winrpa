object regForm: TregForm
  Left = 404
  Top = 290
  Width = 306
  Height = 226
  BorderIcons = [biSystemMenu]
  Caption = 'regForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 73
    Height = 13
    AutoSize = False
    Caption = #27880#20876#20449#24687#65306
  end
  object Label2: TLabel
    Left = 8
    Top = 16
    Width = 57
    Height = 13
    AutoSize = False
    Caption = #26426#22120#30721#65306
  end
  object Edit1: TEdit
    Left = 56
    Top = 16
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 64
    Width = 281
    Height = 89
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 112
    Top = 160
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = BitBtn1Click
  end
end
