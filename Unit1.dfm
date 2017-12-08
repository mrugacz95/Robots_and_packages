object Form1: TForm1
  Left = 422
  Top = 157
  Width = 1040
  Height = 713
  Caption = 'Roboty - Marcin Mrugas'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnKeyDown = Memo1KeyDown
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnPaint = FormCreate
  OnResize = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 901
    Top = 0
    Width = 131
    Height = 679
    Align = alRight
    AutoSize = True
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 57
      Height = 13
      Caption = 'Bok planszy'
    end
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 117
      Height = 13
      Caption = 'Wykona'#322' Marcin Mrugas'
    end
    object Label3: TLabel
      Left = 7
      Top = 536
      Width = 66
      Height = 13
      Caption = '% zape'#322'nienia'
      Visible = False
    end
    object Label4: TLabel
      Left = 7
      Top = 280
      Width = 69
      Height = 13
      Caption = 'Liczba paczek'
    end
    object lpedit: TLabel
      Left = 79
      Top = 280
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label6: TLabel
      Left = 7
      Top = 296
      Width = 68
      Height = 13
      Caption = 'liczba robot'#243'w'
    end
    object lredit: TLabel
      Left = 79
      Top = 296
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label5: TLabel
      Left = 7
      Top = 512
      Width = 60
      Height = 13
      Caption = 'interwa'#322' [ms]'
      Visible = False
    end
    object Edit1: TEdit
      Left = 82
      Top = 33
      Width = 32
      Height = 21
      TabOrder = 0
      Text = '25'
    end
    object RadioGroup1: TRadioGroup
      Left = 1
      Top = 64
      Width = 121
      Height = 81
      Caption = 'Co rysowac?'
      TabOrder = 1
    end
    object radiorobot: TRadioButton
      Left = 18
      Top = 80
      Width = 81
      Height = 18
      Caption = 'robot'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object radiopaczka: TRadioButton
      Left = 18
      Top = 96
      Width = 81
      Height = 18
      Caption = 'paczka'
      TabOrder = 3
    end
    object radioprzeszkoda: TRadioButton
      Left = 18
      Top = 112
      Width = 81
      Height = 26
      Caption = 'przeszkoda'
      TabOrder = 4
    end
    object Button1: TButton
      Left = 9
      Top = 152
      Width = 113
      Height = 26
      Caption = 'Krok'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 9
      Top = 216
      Width = 113
      Height = 26
      Caption = 'czyszczenie callosci'
      TabOrder = 6
      OnClick = Button2Click
    end
    object Checkboxsciezki: TCheckBox
      Left = 10
      Top = 377
      Width = 97
      Height = 17
      Caption = 'Kraw'#281'dzie'
      TabOrder = 7
      Visible = False
      OnClick = CheckboxsciezkiClick
    end
    object Checkboxwierzcholki: TCheckBox
      Left = 10
      Top = 361
      Width = 88
      Height = 17
      Caption = 'Wierzcholki'
      TabOrder = 8
      Visible = False
      OnClick = CheckboxwierzcholkiClick
    end
    object Checklista: TCheckBox
      Left = 10
      Top = 457
      Width = 97
      Height = 17
      Caption = 'Lista krawedzi'
      TabOrder = 9
      Visible = False
      OnClick = ChecklistaClick
    end
    object Checknaroz: TCheckBox
      Left = 10
      Top = 489
      Width = 97
      Height = 17
      Caption = 'Naro'#380'niki'
      Checked = True
      State = cbChecked
      TabOrder = 10
      Visible = False
      OnClick = ChecknarozClick
    end
    object CheckRPP: TCheckBox
      Left = 10
      Top = 553
      Width = 97
      Height = 17
      Caption = 'RPP'
      TabOrder = 11
      Visible = False
      OnClick = CheckRPPClick
    end
    object Checkdijkstrpoko: TCheckBox
      Left = 10
      Top = 393
      Width = 104
      Height = 17
      Caption = 'Dijkstra po kolei'
      TabOrder = 12
      Visible = False
      OnClick = CheckdijkstrpokoClick
    end
    object Checknajdroga: TCheckBox
      Left = 10
      Top = 409
      Width = 104
      Height = 17
      Caption = 'Najkrotsza droga'
      TabOrder = 13
      Visible = False
      OnClick = ChecknajdrogaClick
    end
    object Checksasiedzi: TCheckBox
      Left = 10
      Top = 425
      Width = 97
      Height = 17
      Caption = 'S'#261'siedzctwo'
      TabOrder = 14
      Visible = False
      OnClick = ChecksasiedziClick
    end
    object Checklistawierzcholkow: TCheckBox
      Left = 10
      Top = 441
      Width = 104
      Height = 17
      Caption = 'Lista wierzcho'
      TabOrder = 15
      Visible = False
      OnClick = ChecklistawierzcholkowClick
    end
    object Checkkolorkraw: TCheckBox
      Left = 10
      Top = 569
      Width = 104
      Height = 17
      Caption = 'Koloruj kraw'#281'dzie'
      TabOrder = 16
      Visible = False
      OnClick = CheckkolorkrawClick
    end
    object Checkryssciane: TCheckBox
      Left = 9
      Top = 312
      Width = 121
      Height = 17
      Caption = 'Rysuj sciane(Ctrl)'
      TabOrder = 17
      OnClick = CheckrysscianeClick
    end
    object Checkkasujsciane: TCheckBox
      Left = 9
      Top = 328
      Width = 121
      Height = 17
      Caption = 'Kasuj sciane(Shift)'
      TabOrder = 18
      OnClick = CheckkasujscianeClick
    end
    object Checklistkrawgraf2: TCheckBox
      Left = 10
      Top = 584
      Width = 120
      Height = 17
      Caption = 'Lista kraw w grafie 2'
      TabOrder = 19
      Visible = False
      OnClick = Checklistkrawgraf2Click
    end
    object losplan: TButton
      Left = 9
      Top = 248
      Width = 113
      Height = 25
      Caption = 'Losowa plansza'
      TabOrder = 20
      OnClick = losplanClick
    end
    object opcje: TCheckBox
      Left = 9
      Top = 344
      Width = 121
      Height = 17
      Caption = 'Opcje'
      TabOrder = 21
      OnClick = opcjeClick
    end
    object dokonca: TButton
      Left = 9
      Top = 184
      Width = 113
      Height = 25
      Caption = 'Do ko'#324'ca'
      TabOrder = 22
      OnClick = dokoncaClick
    end
    object stop: TButton
      Left = 10
      Top = 184
      Width = 113
      Height = 25
      Caption = 'STOP'
      TabOrder = 23
      Visible = False
      OnClick = stopClick
    end
    object Edit3: TEdit
      Left = 80
      Top = 528
      Width = 33
      Height = 21
      TabOrder = 24
      Text = '30'
      Visible = False
    end
    object lepiejbox: TCheckBox
      Left = 10
      Top = 472
      Width = 114
      Height = 17
      Caption = 'Ze zmian'#261' przy lr>1'
      TabOrder = 25
      Visible = False
    end
    object Edit4: TEdit
      Left = 80
      Top = 504
      Width = 33
      Height = 21
      TabOrder = 26
      Text = '100'
      Visible = False
    end
  end
  object listwierzch: TListBox
    Left = 8
    Top = 176
    Width = 217
    Height = 153
    ItemHeight = 13
    TabOrder = 1
    Visible = False
  end
  object sasiedz: TStringGrid
    Left = 8
    Top = 8
    Width = 217
    Height = 153
    DefaultColWidth = 15
    TabOrder = 2
    Visible = False
  end
  object listkrawgraf: TListBox
    Left = 632
    Top = 16
    Width = 209
    Height = 153
    ItemHeight = 13
    TabOrder = 3
    Visible = False
  end
  object sasiedzigraf2: TStringGrid
    Left = 272
    Top = 8
    Width = 145
    Height = 169
    DefaultColWidth = 15
    TabOrder = 4
    Visible = False
  end
  object listkolej: TStringGrid
    Left = 440
    Top = 0
    Width = 145
    Height = 169
    DefaultColWidth = 15
    TabOrder = 5
    Visible = False
  end
  object Edit2: TEdit
    Left = 80
    Top = 616
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit2'
    Visible = False
  end
  object ListBox1: TListBox
    Left = 8
    Top = 344
    Width = 217
    Height = 153
    ItemHeight = 13
    TabOrder = 7
    Visible = False
  end
end
