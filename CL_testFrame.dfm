object TestFrame: TTestFrame
  Left = 0
  Top = 0
  Width = 430
  Height = 280
  TabOrder = 0
  TabStop = True
  object Button1: TButton
    Left = 264
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 111
    Width = 75
    Height = 25
    Caption = 'Remove'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 264
    Top = 53
    Width = 137
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object ListBox1: TListBox
    Left = 25
    Top = 31
    Width = 225
    Height = 210
    ItemHeight = 13
    TabOrder = 3
  end
end
