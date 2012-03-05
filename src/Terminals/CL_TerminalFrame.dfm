object TerminalFrame: TTerminalFrame
  Left = 0
  Top = 0
  Width = 750
  Height = 506
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object GroupBox1: TGroupBox
    Left = 466
    Top = 340
    Width = 271
    Height = 157
    Caption = ' Makros '
    TabOrder = 0
    object Button5: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 0
    end
    object Button6: TButton
      Left = 178
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 1
    end
    object Button7: TButton
      Left = 97
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 2
    end
    object Button8: TButton
      Left = 97
      Top = 55
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 3
    end
    object Button9: TButton
      Left = 178
      Top = 55
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 4
    end
    object Button10: TButton
      Left = 16
      Top = 55
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 5
    end
    object Button11: TButton
      Left = 97
      Top = 86
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 6
    end
    object Button12: TButton
      Left = 178
      Top = 86
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 7
    end
    object Button13: TButton
      Left = 16
      Top = 86
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 8
    end
    object Button14: TButton
      Left = 16
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 9
    end
    object Button15: TButton
      Left = 97
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 10
    end
    object Button16: TButton
      Left = 178
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 11
    end
  end
  object GroupBox2: TGroupBox
    Left = 468
    Top = 3
    Width = 269
    Height = 206
    Caption = ' Quick Makro '
    TabOrder = 1
    object quickMakroMemo: TMemo
      Left = 11
      Top = 24
      Width = 246
      Height = 137
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Button4: TButton
      Left = 94
      Top = 167
      Width = 75
      Height = 25
      Caption = 'Execute'
      TabOrder = 1
      OnClick = Button4Click
    end
    object Button18: TButton
      Left = 175
      Top = 167
      Width = 75
      Height = 25
      Caption = 'Save as ...'
      TabOrder = 2
    end
    object Button22: TButton
      Left = 14
      Top = 167
      Width = 75
      Height = 25
      Caption = 'Demo Script'
      TabOrder = 3
      OnClick = Button22Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 15
    Top = 97
    Width = 445
    Height = 400
    Caption = ' Terminal '
    TabOrder = 2
    object terminalMemo: TMemo
      Left = 19
      Top = 30
      Width = 406
      Height = 321
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object ComboBox1: TComboBox
      Left = 19
      Top = 357
      Width = 289
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 1
    end
    object Button1: TButton
      Left = 350
      Top = 357
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 466
    Top = 251
    Width = 271
    Height = 65
    Caption = ' Control '
    TabOrder = 3
    object StopButton: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Stop'
      Enabled = False
      TabOrder = 0
      OnClick = StopButtonClick
    end
    object PauseButton: TButton
      Left = 97
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Pause'
      Enabled = False
      TabOrder = 1
      OnClick = PauseButtonClick
    end
    object Button21: TButton
      Left = 178
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Toolbox'
      TabOrder = 2
      OnClick = Button21Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 15
    Top = 3
    Width = 447
    Height = 94
    Caption = ' Connection '
    TabOrder = 4
    object Label2: TLabel
      Left = 24
      Top = 27
      Width = 50
      Height = 13
      Caption = 'Connector'
    end
    object Label3: TLabel
      Left = 24
      Top = 58
      Width = 32
      Height = 13
      Caption = 'Target'
    end
    object Button3: TButton
      Left = 369
      Top = 53
      Width = 65
      Height = 25
      Caption = 'Disconnect'
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button2: TButton
      Left = 369
      Top = 22
      Width = 65
      Height = 25
      Caption = 'Connect'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button17: TButton
      Left = 282
      Top = 22
      Width = 65
      Height = 25
      Caption = 'Setup'
      TabOrder = 2
      OnClick = Button17Click
    end
    object ComboBox2: TComboBox
      Left = 96
      Top = 24
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
  end
end
