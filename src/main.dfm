object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 399
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 24
    Top = 27
    Width = 577
    Height = 350
    ActivePage = TabSheet2
    MultiLine = True
    TabOrder = 0
    TabPosition = tpBottom
    object TabSheet1: TTabSheet
      Caption = 'Connections'
      ExplicitWidth = 514
      ExplicitHeight = 300
    end
    object TabSheet2: TTabSheet
      Caption = 'Terminal'
      ImageIndex = 1
      ExplicitWidth = 514
      ExplicitHeight = 300
    end
  end
end
