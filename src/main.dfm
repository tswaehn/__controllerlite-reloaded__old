object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 562
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 18
    Top = 8
    Width = 750
    Height = 550
    MultiLine = True
    TabOrder = 0
    TabPosition = tpBottom
  end
  object MainMenu1: TMainMenu
    Left = 8
    object Exit1: TMenuItem
      Caption = 'Exit'
      OnClick = Exit1Click
    end
    object Help1: TMenuItem
      Caption = 'Help'
      OnClick = Help1Click
    end
  end
end
