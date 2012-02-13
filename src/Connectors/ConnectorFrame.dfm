object ConnectorFrame: TConnectorFrame
  Left = 0
  Top = 0
  ClientHeight = 289
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Button3: TButton
    Left = 399
    Top = 151
    Width = 65
    Height = 25
    Caption = 'Del'
    TabOrder = 0
  end
  object Button4: TButton
    Left = 399
    Top = 65
    Width = 65
    Height = 25
    Caption = 'Edit'
    TabOrder = 1
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 399
    Top = 224
    Width = 65
    Height = 25
    Caption = 'Up'
    TabOrder = 2
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 399
    Top = 255
    Width = 65
    Height = 25
    Caption = 'Down'
    TabOrder = 3
    OnClick = Button6Click
  end
  object ListBox1: TListBox
    Left = 24
    Top = 34
    Width = 369
    Height = 246
    ItemHeight = 13
    TabOrder = 4
  end
  object Button2: TButton
    Left = 399
    Top = 34
    Width = 65
    Height = 25
    Caption = 'Add'
    TabOrder = 5
  end
  object Button7: TButton
    Left = 399
    Top = 111
    Width = 65
    Height = 25
    Caption = 'Con/Dis'
    TabOrder = 6
    OnClick = Button7Click
  end
end
