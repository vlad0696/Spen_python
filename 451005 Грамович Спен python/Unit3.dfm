object spen_form: Tspen_form
  Left = 0
  Top = 0
  Caption = #1055#1086#1076#1089#1095#1105#1090' '#1089#1087#1077#1085#1072
  ClientHeight = 348
  ClientWidth = 954
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object open_button: TButton
    Left = 192
    Top = 24
    Width = 129
    Height = 33
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
    TabOrder = 0
    OnClick = open_buttonClick
  end
  object main_button: TButton
    Left = 592
    Top = 24
    Width = 129
    Height = 33
    Caption = #1055#1088#1086#1080#1079#1074#1077#1089#1090#1080' '#1087#1086#1076#1089#1095#1105#1090
    TabOrder = 1
    OnClick = main_buttonClick
  end
  object text_memo: TMemo
    Left = 24
    Top = 80
    Width = 593
    Height = 249
    Lines.Strings = (
      'kod_memo')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object StringGrid1: TStringGrid
    Left = 623
    Top = 80
    Width = 320
    Height = 249
    ColCount = 2
    FixedCols = 0
    ScrollBars = ssVertical
    TabOrder = 3
    ColWidths = (
      193
      105)
  end
  object OpenDialog1: TOpenDialog
  end
end
