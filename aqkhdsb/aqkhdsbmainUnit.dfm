object doForm: TdoForm
  Left = 466
  Top = 168
  Width = 737
  Height = 483
  Caption = 'doForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 729
    Height = 449
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object Image1: TImage
        Left = 432
        Top = 208
        Width = 97
        Height = 49
        AutoSize = True
      end
      object Image2: TImage
        Left = 432
        Top = 88
        Width = 97
        Height = 41
        AutoSize = True
      end
      object Image3: TImage
        Left = 432
        Top = 144
        Width = 97
        Height = 49
        AutoSize = True
      end
      object Label1: TLabel
        Left = 432
        Top = 72
        Width = 41
        Height = 13
        AutoSize = False
        Caption = #27169#29256
      end
      object Label2: TLabel
        Left = 432
        Top = 128
        Width = 97
        Height = 13
        AutoSize = False
        Caption = #29992#20110#21028#26029#30340#25130#22270
      end
      object Label3: TLabel
        Left = 248
        Top = 72
        Width = 105
        Height = 13
        AutoSize = False
        Caption = #24403#21069'QQ'#31383#21475#21477#26564
      end
      object Label4: TLabel
        Left = 248
        Top = 160
        Width = 81
        Height = 13
        AutoSize = False
        Caption = #34394#25311#38190#20540
      end
      object Label5: TLabel
        Left = 432
        Top = 192
        Width = 41
        Height = 13
        AutoSize = False
        Caption = #25130#22270
      end
      object Label6: TLabel
        Left = 432
        Top = 256
        Width = 41
        Height = 13
        AutoSize = False
        Caption = #39564#35777#30721
      end
      object Image4: TImage
        Left = 432
        Top = 272
        Width = 97
        Height = 49
        AutoSize = True
      end
      object Label7: TLabel
        Left = 248
        Top = 112
        Width = 33
        Height = 13
        AutoSize = False
        Caption = #36134#21495
      end
      object Label8: TLabel
        Left = 248
        Top = 136
        Width = 33
        Height = 13
        AutoSize = False
        Caption = #23494#30721
      end
      object Label9: TLabel
        Left = 248
        Top = 216
        Width = 81
        Height = 13
        AutoSize = False
        Caption = #24453#21152#36134#21495
      end
      object Label10: TLabel
        Left = 248
        Top = 296
        Width = 81
        Height = 13
        AutoSize = False
        Caption = #39564#35777#20449#24687
      end
      object Label11: TLabel
        Left = 360
        Top = 72
        Width = 57
        Height = 13
        AutoSize = False
        Caption = #25130#22270#21442#25968
      end
      object Label12: TLabel
        Left = 8
        Top = 8
        Width = 57
        Height = 13
        AutoSize = False
        Caption = 'QQ'#30446#24405#65306
      end
      object Label31: TLabel
        Left = 402
        Top = 320
        Width = 95
        Height = 13
        AutoSize = False
        Caption = #27627#31186#21518#21152#19979#19968'QQ'
      end
      object QQpathEdit: TEdit
        Left = 64
        Top = 8
        Width = 409
        Height = 21
        TabOrder = 0
        Text = 'C:\Program Files\Tencent\QQIntl\Bin\QQ.exe'
      end
      object Memo1: TMemo
        Left = 8
        Top = 88
        Width = 233
        Height = 105
        ScrollBars = ssBoth
        TabOrder = 1
        OnClick = Memo1Click
      end
      object nowhandelEdit: TEdit
        Left = 248
        Top = 88
        Width = 89
        Height = 21
        TabOrder = 2
        Text = 'nowhandelEdit'
      end
      object Button3: TButton
        Left = 8
        Top = 40
        Width = 75
        Height = 25
        Caption = #24320#22987
        TabOrder = 3
        OnClick = Button3Click
      end
      object qquserEdit: TEdit
        Left = 280
        Top = 112
        Width = 73
        Height = 21
        TabOrder = 4
        Text = '2518730186'
      end
      object qqpwdEdit: TMaskEdit
        Left = 280
        Top = 136
        Width = 73
        Height = 21
        PasswordChar = '*'
        TabOrder = 5
        Text = 'bxvDq0305107226*'
      end
      object Memo2: TMemo
        Left = 248
        Top = 176
        Width = 105
        Height = 33
        Lines.Strings = (
          'a'
          '65'
          'b'
          '66'
          'c'
          '67'
          'd'
          '68'
          'e'
          '69'
          'f'
          '70'
          'g'
          '71'
          'h'
          '72'
          'i'
          '73'
          'j'
          '74'
          'k'
          '75'
          'l'
          '76'
          'm'
          '77'
          'n'
          '78'
          'o'
          '79'
          'p'
          '80'
          'q'
          '81'
          'r'
          '82'
          's'
          '83'
          't'
          '84'
          'u'
          '85'
          'v'
          '86'
          'w'
          '87'
          'x'
          '88'
          'y'
          '89'
          'z'
          '90'
          'A'
          '65'
          'B'
          '66'
          'C'
          '67'
          'D'
          '68'
          'E'
          '69'
          'F'
          '70'
          'G'
          '71'
          'H'
          '72'
          'I'
          '73'
          'J'
          '74'
          'K'
          '75'
          'L'
          '76'
          'M'
          '77'
          'N'
          '78'
          'O'
          '79'
          'P'
          '80'
          'Q'
          '81'
          'R'
          '82'
          'S'
          '83'
          'T'
          '84'
          'U'
          '85'
          'V'
          '86'
          'W'
          '87'
          'X'
          '88'
          'Y'
          '89'
          'Z'
          '90'
          '0'
          '48'
          '1'
          '49'
          '2'
          '50'
          '3'
          '51'
          '4'
          '52'
          '5'
          '53'
          '6'
          '54'
          '7'
          '55'
          '8'
          '56'
          '9'
          '57'
          ';'
          '186'
          '='
          '187'
          ','
          '188'
          '-'
          '189'
          '.'
          '190'
          '/'
          '191'
          '`'
          '192'
          '['
          '219'
          '\'
          '220'
          ']'
          '221'
          #39
          '222'
          ')'
          '48'
          '!'
          '49'
          '@'
          '50'
          '#'
          '51'
          '$'
          '52'
          '%'
          '53'
          '^'
          '54'
          '&'
          '55'
          '*'
          '56'
          '('
          '57'
          ':'
          '186'
          '+'
          '187'
          '<'
          '188'
          '_'
          '189'
          '>'
          '190'
          '?'
          '191'
          '~'
          '192'
          '{'
          '219'
          '|'
          '220'
          '}'
          '221'
          '"'
          '222')
        TabOrder = 6
      end
      object Memo3: TMemo
        Left = 8
        Top = 200
        Width = 233
        Height = 137
        Lines.Strings = (
          'Memo3')
        ScrollBars = ssBoth
        TabOrder = 7
      end
      object Edit5: TEdit
        Left = 104
        Top = 40
        Width = 57
        Height = 21
        TabOrder = 8
        Text = '180'
      end
      object Edit6: TEdit
        Left = 168
        Top = 40
        Width = 57
        Height = 21
        TabOrder = 9
        Text = '280'
      end
      object Button1: TButton
        Left = 232
        Top = 40
        Width = 41
        Height = 25
        Caption = #31227#20301
        TabOrder = 10
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 272
        Top = 40
        Width = 65
        Height = 25
        Caption = #36941#21382#31383#20307
        TabOrder = 11
        OnClick = Button2Click
      end
      object checkinfoedit: TEdit
        Left = 248
        Top = 312
        Width = 105
        Height = 21
        TabOrder = 12
        Text = #20320#22909#21834
      end
      object Button4: TButton
        Left = 336
        Top = 40
        Width = 49
        Height = 25
        Caption = #25130#22270
        TabOrder = 13
        OnClick = Button4Click
      end
      object Edit9: TEdit
        Left = 360
        Top = 88
        Width = 33
        Height = 21
        TabOrder = 14
        Text = 'Left'
      end
      object Edit10: TEdit
        Left = 392
        Top = 88
        Width = 33
        Height = 21
        TabOrder = 15
        Text = 'Top'
      end
      object Edit11: TEdit
        Left = 360
        Top = 112
        Width = 33
        Height = 21
        TabOrder = 16
        Text = 'Right'
      end
      object Edit12: TEdit
        Left = 392
        Top = 112
        Width = 33
        Height = 21
        TabOrder = 17
        Text = 'Bottom'
      end
      object Edit15: TEdit
        Left = 360
        Top = 136
        Width = 73
        Height = 21
        TabOrder = 18
        Text = #25130#22270#25991#20214#21517
      end
      object Button8: TButton
        Left = 384
        Top = 40
        Width = 57
        Height = 25
        Caption = #21028#26029#38454#27573
        TabOrder = 19
        OnClick = Button8Click
      end
      object Button5: TButton
        Left = 440
        Top = 40
        Width = 57
        Height = 25
        Caption = #21028#26029#36827#31243
        TabOrder = 20
        OnClick = Button5Click
      end
      object waddqqMemo: TMemo
        Left = 248
        Top = 232
        Width = 105
        Height = 57
        Lines.Strings = (
          '782596698'
          '1873366406'
          '14255845'
          '565333428'
          'ser@trm.com')
        TabOrder = 21
      end
      object Button6: TButton
        Left = 472
        Top = 8
        Width = 33
        Height = 25
        Caption = '...'
        TabOrder = 22
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 496
        Top = 40
        Width = 41
        Height = 25
        Caption = #20020#26102
        TabOrder = 23
        OnClick = Button7Click
      end
      object waittimeEdit: TEdit
        Left = 368
        Top = 320
        Width = 33
        Height = 21
        TabOrder = 24
        Text = '1000'
      end
      object CheckBox1: TCheckBox
        Left = 136
        Top = 64
        Width = 97
        Height = 17
        Caption = #33719#21462#22909#21451#25968#37327
        Checked = True
        State = cbChecked
        TabOrder = 25
        WordWrap = True
      end
      object Button11: TButton
        Left = 360
        Top = 160
        Width = 65
        Height = 25
        Caption = #21477#26564#35835#22909#21451
        TabOrder = 26
        OnClick = Button11Click
      end
      object Button9: TButton
        Left = 360
        Top = 184
        Width = 65
        Height = 25
        Caption = #36941#21382#36827#31243
        TabOrder = 27
        OnClick = Button9Click
      end
      object Button10: TButton
        Left = 360
        Top = 232
        Width = 65
        Height = 25
        Caption = #20108#20540#21270
        TabOrder = 28
        OnClick = Button10Click
      end
      object BitBtn1: TBitBtn
        Left = 360
        Top = 256
        Width = 65
        Height = 25
        Caption = #39068#33394#20998#24067#22270
        TabOrder = 29
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 360
        Top = 208
        Width = 65
        Height = 25
        Caption = #21462#22270
        TabOrder = 30
        OnClick = BitBtn2Click
      end
      object Button12: TButton
        Left = 504
        Top = 8
        Width = 49
        Height = 25
        Caption = #25191#34892
        TabOrder = 31
        OnClick = Button12Click
      end
      object Button13: TButton
        Left = 360
        Top = 280
        Width = 65
        Height = 25
        Caption = #26159#21542#39564#35777#30721
        TabOrder = 32
        OnClick = Button13Click
      end
      object Button14: TButton
        Left = 496
        Top = 72
        Width = 75
        Height = 25
        Caption = #25289'QQ'#30028#38754
        TabOrder = 33
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 496
        Top = 96
        Width = 75
        Height = 25
        Caption = #21024#38500#20020#26102#25991#20214
        TabOrder = 34
        OnClick = Button15Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 721
        Height = 421
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TChart')
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 392
    Top = 8
  end
  object opendamaADOQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 80
    Top = 184
  end
  object opencodeADOQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 112
    Top = 152
  end
  object editsuodingADOQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 80
    Top = 120
  end
  object editmainqqADOQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 48
    Top = 120
  end
  object editlistqqADOQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 80
    Top = 88
  end
  object editevenADOQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 112
    Top = 88
  end
  object editcodeADOQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 80
    Top = 152
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 176
    Top = 40
  end
end
