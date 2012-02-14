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
    Left = 434
    Top = 321
    Width = 273
    Height = 159
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
      Left = 97
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 9
    end
    object Button15: TButton
      Left = 178
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 10
    end
    object Button16: TButton
      Left = 16
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 11
    end
  end
  object GroupBox2: TGroupBox
    Left = 434
    Top = 3
    Width = 303
    Height = 241
    Caption = ' Quick Makro '
    TabOrder = 1
    object Memo2: TMemo
      Left = 16
      Top = 24
      Width = 273
      Height = 169
      Lines.Strings = (
        'Memo2')
      TabOrder = 0
    end
    object Button4: TButton
      Left = 118
      Top = 199
      Width = 75
      Height = 25
      Caption = 'Execute'
      TabOrder = 1
    end
    object Button18: TButton
      Left = 213
      Top = 199
      Width = 75
      Height = 25
      Caption = 'Save as ...'
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 15
    Top = 97
    Width = 413
    Height = 400
    Caption = ' Terminal '
    TabOrder = 2
    object Memo1: TMemo
      Left = 19
      Top = 30
      Width = 377
      Height = 321
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
    object ComboBox1: TComboBox
      Left = 19
      Top = 357
      Width = 289
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'ComboBox1'
    end
    object Button1: TButton
      Left = 321
      Top = 357
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 2
    end
  end
  object GroupBox4: TGroupBox
    Left = 434
    Top = 250
    Width = 303
    Height = 65
    Caption = ' Control '
    TabOrder = 3
    object Button19: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 0
    end
    object Button20: TButton
      Left = 97
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Pause'
      TabOrder = 1
    end
    object Button21: TButton
      Left = 217
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Toolbox'
      TabOrder = 2
    end
  end
  object GroupBox5: TGroupBox
    Left = 15
    Top = 3
    Width = 413
    Height = 94
    Caption = ' Connection '
    TabOrder = 4
    object Label1: TLabel
      Left = 24
      Top = 18
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 24
      Top = 37
      Width = 50
      Height = 13
      Caption = 'Connector'
    end
    object Label3: TLabel
      Left = 24
      Top = 65
      Width = 32
      Height = 13
      Caption = 'Target'
    end
    object Button3: TButton
      Left = 329
      Top = 60
      Width = 65
      Height = 25
      Caption = 'Disconnect'
      TabOrder = 0
    end
    object Button2: TButton
      Left = 329
      Top = 29
      Width = 65
      Height = 25
      Caption = 'Connect'
      TabOrder = 1
    end
    object Button17: TButton
      Left = 258
      Top = 29
      Width = 65
      Height = 25
      Caption = 'Setup'
      TabOrder = 2
    end
    object ComboBox2: TComboBox
      Left = 88
      Top = 37
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
    object ComboBox3: TComboBox
      Left = 88
      Top = 64
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
    end
  end
end
