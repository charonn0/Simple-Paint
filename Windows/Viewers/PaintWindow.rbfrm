#tag Window
Begin Window PaintWindow
   BackColor       =   65369
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   600
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1871163391
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   800
   Placement       =   2
   Resizeable      =   True
   Title           =   "Simple Paint"
   Visible         =   True
   Width           =   800
   Begin CompositeContainer PaintTarget1
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      Backdrop        =   ""
      CancelDraw      =   ""
      currentObject   =   -1
      DoubleBuffer    =   False
      DragEndX        =   -1
      DragEndY        =   -1
      DragStartX      =   -1
      DragStartY      =   -1
      Enabled         =   True
      EraseBackground =   True
      Font            =   "System"
      FontSize        =   11
      Height          =   550
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      lastX           =   0
      lastY           =   0
      Left            =   0
      LineWidth       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MagLevel        =   2
      MagSize         =   0
      Mode            =   0
      MustScroll      =   ""
      Override        =   ""
      ReDoable        =   ""
      Resizing        =   ""
      Scope           =   0
      Scrolling       =   ""
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Taint           =   ""
      Top             =   0
      UnDoable        =   ""
      UseFocusRing    =   True
      ViewX           =   0
      ViewY           =   0
      Visible         =   True
      Width           =   784
   End
   Begin ColorPicker ColorPicker2
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   30
      HelpTag         =   "Color Palette"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   570
      UseFocusRing    =   True
      Visible         =   True
      Width           =   654
   End
   Begin Canvas Canvas2
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   30
      HelpTag         =   "Current Color (Double Click For Color Selector)"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   657
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   570
      UseFocusRing    =   True
      Visible         =   True
      Width           =   25
   End
   Begin Label Label1
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   694
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      Text            =   "0x0"
      TextAlign       =   2
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   580
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   86
   End
   Begin ScrollBar Vertical
      AcceptFocus     =   true
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   550
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   784
      LineStep        =   1
      LiveScroll      =   ""
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Maximum         =   100
      Minimum         =   0
      PageStep        =   20
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Value           =   0
      Visible         =   False
      Width           =   16
   End
   Begin ScrollBar Horitontal
      AcceptFocus     =   true
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LineStep        =   1
      LiveScroll      =   ""
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Maximum         =   100
      Minimum         =   0
      PageStep        =   20
      Scope           =   0
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   552
      Value           =   0
      Visible         =   False
      Width           =   784
   End
   Begin Timer Timer1
      Height          =   32
      Index           =   -2147483648
      Left            =   1077
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   -54
      Width           =   32
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Untitled"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   156
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   -54
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin placardButton placardButton1
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      Backdrop        =   352524287
      bold            =   0
      caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      hasIcon         =   True
      Height          =   16
      HelpTag         =   ""
      Icon            =   "HelpIcon.png"
      Index           =   -2147483648
      InitialParent   =   ""
      invertTextColor =   ""
      isSticky        =   True
      italic          =   0
      Left            =   784
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      textColor       =   0
      textFont        =   "System"
      textSize        =   0
      Top             =   584
      underline       =   0
      UseFocusRing    =   True
      value           =   0
      Visible         =   True
      Width           =   16
   End
   Begin Timer capturetimer
      Height          =   32
      Index           =   -2147483648
      Left            =   1088
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   552
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  #pragma Unused appQuitting
		  If Tainted Then
		    Select Case MsgBox("Would you like to save your changes? Click Yes to save, No to quit without saving, or Cancel to continue painting.", _
		      51 + 256, "Unsaved changes - " + PaintTarget1.FileName)
		    Case 6  //Yes
		      SaveFile()
		      Me.Error = True
		      Return False
		    Case 7  //No
		      Me.Error = True
		      Return False
		    Case 2  //Cancel
		      Return True
		    End Select
		    
		  Else
		    Error = True
		  End If
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  //File Menu
		  Self.MenuBar.Item(0).Item(0).Icon = GetFrameThumbnail("document-new.png")  //New
		  Self.MenuBar.Item(0).Item(1).Icon = GetFrameThumbnail("folder_open_document.png")  //Open
		  Self.MenuBar.Item(0).Item(2).Icon = GetFrameThumbnail("save-document.png")  //Save
		  Self.MenuBar.Item(0).Item(3).Icon = GetFrameThumbnail("quitIcon.png")  //Exit
		  
		  //Edit Menu
		  Self.MenuBar.Item(1).Item(0).Icon = GetFrameThumbnail("copyicon.png")  //Copy
		  Self.MenuBar.Item(1).Item(1).Icon = GetFrameThumbnail("paste-icon.png")  //Paste
		  Self.MenuBar.Item(1).Item(2).Icon = GetFrameThumbnail("Cut-silk.png")  //Cut
		  Self.MenuBar.Item(1).Item(3).Icon = GetFrameThumbnail("Undo.png")  //Undo
		  Self.MenuBar.Item(1).Item(4).Icon = GetFrameThumbnail("Redo.png")  //Redo
		  Self.MenuBar.Item(1).Item(5).Icon = GetFrameThumbnail("select_rectangle_up.png")  //Select
		  Self.MenuBar.Item(1).Item(6).Icon = GetFrameThumbnail("edit-clear.png")  //Clear
		  
		  //Tools Menu
		  Self.MenuBar.Item(2).Item(0).Icon = GetFrameThumbnail("viewredo.png")  //View redo
		  Self.MenuBar.Item(2).Item(1).Icon = GetFrameThumbnail("viewundo.png")  //View undo
		  Self.MenuBar.Item(2).Item(2).Icon = GetFrameThumbnail("Clipboard-icon.png")  //View Clipboard
		  Self.MenuBar.Item(2).Item(3).Icon = GetFrameThumbnail("image_resize.png")  //scale
		  Self.MenuBar.Item(2).Item(4).Icon = GetFrameThumbnail("compositor.png")  //Compositor
		  Self.MenuBar.Item(2).Item(5).Icon = GetFrameThumbnail("magnifying_glass.png")  //magnifyer
		  //Separator
		  Self.MenuBar.Item(2).Item(7).Icon = GetFrameThumbnail("paint-brush.png")  //View brushes
		  Self.MenuBar.Item(2).Item(8).Icon = GetFrameThumbnail("INVALID_DEFAULT.png")  //load brush
		  Self.MenuBar.Item(2).Item(9).Icon = GetFrameThumbnail("NewResource.png")  //new resource
		  Self.MenuBar.Item(2).Item(10).Icon = GetFrameThumbnail("INVALID_DEFAULT.png")  //create brush
		  Self.MenuBar.Item(2).Item(11).Icon = GetFrameThumbnail("INVALID_DEFAULT.png")  //suppress brush errors
		  
		  //Help menu
		  Self.MenuBar.Item(3).Item(0).Icon = GetFrameThumbnail("INVALID_DEFAULT.png")  //View Help
		  Self.MenuBar.Item(3).Item(1).Icon = GetFrameThumbnail("INVALID_DEFAULT.png")  //View About
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  If PaintTarget1.ActualSize.Left > Me.Width Or PaintTarget1.ActualSize.Right > Me.Height Then
		    PaintTarget1.MustScroll = True
		  Else
		    PaintTarget1.MustScroll = False
		  End If
		  
		  If PaintTarget1.MustScroll Then
		    Dim p As Pair = PaintTarget1.ActualSize
		    Vertical.Maximum = p.Right
		    Horitontal.Maximum = p.Left
		    Vertical.Value = 0
		    Horitontal.Value = 0
		    Vertical.Visible = True
		    Horitontal.Visible = True
		  Else
		    Vertical.Visible = False
		    Horitontal.Visible = False
		  End If
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function AboutMENU() As Boolean Handles AboutMENU.Action
			aboutwin.ShowModal
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ChangePalette() As Boolean Handles ChangePalette.Action
			ColorPicker2.SwitchPalette
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function clearTool() As Boolean Handles clearTool.Action
			PaintTarget1.Clear
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CompositeMenu() As Boolean Handles CompositeMenu.Action
			
			Dim mb As MemoryBlock = PaintTarget1.buffer.GetData(Picture.FormatBMP)
			Dim fi As FreeImage = FreeImage.LoadFromMemory(mb)
			Dim ed As New wEditor(fi)
			ed.Show
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CopyMenu() As Boolean Handles CopyMenu.Action
			If PaintTarget1.Mode =PaintTarget1.Select_Mode_Wait Then
			Call PaintTarget1.SelectionEnd(PaintTarget1.Select_Mode_Copy)
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CutMenu() As Boolean Handles CutMenu.Action
			If PaintTarget1.Mode =PaintTarget1.Select_Mode_Wait Then
			Call PaintTarget1.SelectionEnd(PaintTarget1.Select_Mode_Cut)
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ExitMenu() As Boolean Handles ExitMenu.Action
			Self.Close
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpItem() As Boolean Handles HelpItem.Action
			HelpViewer.Show
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function MagMenu() As Boolean Handles MagMenu.Action
			MagOn = True
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function MakeTrans() As Boolean Handles MakeTrans.Action
			'Self.Visible = False
			OldY = Self.Top
			Self.Top = Self.Top * -10000
			
			capturetimer.Mode = Timer.ModeSingle
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function MaxMemSet() As Boolean Handles MaxMemSet.Action
			MemSize.Show
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function NewMenu() As Boolean Handles NewMenu.Action
			Dim s As XYZ = NewPic.ShowMe
			If s.X > 0 Then
			Dim p As New Picture(s.X, s.Y, s.Z)
			PaintTarget1.Open(p)
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function NewResource() As Boolean Handles NewResource.Action
			resourcemaker.Show
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function OpenMenu() As Boolean Handles OpenMenu.Action
			Dim f As FolderItem = GetOpenFolderItem(FileTypes1.AllSupportedImageTypes)
			If f <> Nil Then
			PaintTarget1.Open(f)
			If PaintTarget1.MustScroll Then
			Dim p As Pair = PaintTarget1.ActualSize
			Vertical.Maximum = p.Right
			Horitontal.Maximum = p.Left
			Vertical.Value = 0
			Horitontal.Value = 0
			Vertical.Visible = True
			Horitontal.Visible = True
			Else
			Vertical.Visible = False
			Horitontal.Visible = False
			End If
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PasteMenu() As Boolean Handles PasteMenu.Action
			MsgBox("Not Implemented.")
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function RedoMeni() As Boolean Handles RedoMeni.Action
			If PaintTarget1.ReDo() Then
			PaintTarget1.Taint = False
			Self.Title = "Simple Paint - " + PaintTarget1.FileName + " *"
			Canvas2.Refresh(False)
			TheToolsWin.LineSize.ListIndex = PaintTarget1.LineWidth
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function RotateMenu() As Boolean Handles RotateMenu.Action
			PaintTarget1.Rotate()
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SaveMenu() As Boolean Handles SaveMenu.Action
			SaveFile()
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ScaleMenu() As Boolean Handles ScaleMenu.Action
			PaintTarget1.Scale
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SelectMenu() As Boolean Handles SelectMenu.Action
			CurrentMode = PaintTarget1.Mode
			PaintTarget1.Mode =PaintTarget1.Mode_Select_Rect
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SuppressErrors() As Boolean Handles SuppressErrors.Action
			Me.MenuBar.Item(2).Item(10).Checked = Not Me.MenuBar.Item(2).Item(10).Checked
			SuppressError = Me.MenuBar.Item(2).Item(10).Checked
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function UndoItem() As Boolean Handles UndoItem.Action
			If Not PaintTarget1.UnDo() Then
			PaintTarget1.Taint = False
			Self.Title = "Simple Paint - " + PaintTarget1.FileName
			End If
			Canvas2.Refresh(False)
			TheToolsWin.LineSize.ListIndex = PaintTarget1.LineWidth
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewCacheMenu() As Boolean Handles ViewCacheMenu.Action
			Loading.ShowMe("Loading all cache items", "This may take some time.")
			Dim p() As String
			Dim sv As New StackViewer
			Dim key As String = sv.ShowMe(p, 2)
			If key <> "" Then
			PaintTarget1.Open(GetFramePicture(Key))
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewClip() As Boolean Handles ViewClip.Action
			Loading.ShowMe("Preparing Clipboard")
			Dim cv As New ClipViewer
			Dim cb As New Clipboard
			If cb.PictureAvailable Then
			Dim sf As New StackFrame(cb.Picture)
			'AddStackFrame(sf)
			Dim i() As String
			i.Append(sf.Key)
			Dim s As String = cv.ShowMe(i, CompositeContainer.Master_Mode_Display)
			If s <> "" Then
			PaintTarget1.Open(GetFramePicture(sf.key))
			End If
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewRedo() As Boolean Handles ViewRedo.Action
			Loading.ShowMe("Loading redo history", "This may take some time.")
			PaintTarget1.ShowRedoStack
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewUndo() As Boolean Handles ViewUndo.Action
			Loading.ShowMe("Loading undo history", "This may take some time.")
			PaintTarget1.ShowUndoStack
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub DrawTransparentBG()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Load() As Boolean
		  CurrentCursor = System.Cursors.FingerPointer
		  
		  If TheToolsWin = Nil Then
		    TheToolsWin = New ToolsWin
		  End If
		  TheToolsWin.Show
		  Me.ShowModal
		  'If Brushes <> Nil Then Brushes.Close
		  Return Error
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewBrushLoaded()
		  MsgBox("New brush successfully loaded.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveFile()
		  If PaintTarget1.BackingFile = Nil Then
		    Dim f As FolderItem = GetSaveFolderItem(FileTypes1.AllSupportedImageTypes, "image")
		    If f <> Nil Then
		      PaintTarget1.BackingFile = f
		    Else
		      Return
		    End If
		  End If
		  Dim i As Integer
		  Select Case PaintTarget1.BackingFile.Extension
		  Case "bmp"
		    i = Picture.SaveAsWindowsBMP
		  Case "png"
		    i = Picture.SaveAsPNG
		  Case "jpg", "jpeg", "jfif"
		    i = Picture.SaveAsJPEG
		  End Select
		  PaintTarget1.Save(PaintTarget1.BackingFile, i)
		  Tainted = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentCursor As MouseCursor
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		DropperMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Error As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OldY As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Slides() As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Tainted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TheToolsWin As ToolsWin
	#tag EndProperty


#tag EndWindowCode

#tag Events PaintTarget1
	#tag Event
		Sub MouseEnter()
		  Me.MouseCursor = CurrentCursor
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = System.Cursors.StandardPointer
		End Sub
	#tag EndEvent
	#tag Event
		Sub CoordChanged(X As Integer, Y As Integer)
		  Dim rX, rY As Integer
		  Dim p As Pair = PaintTarget1.ActualSize
		  rX = p.Left
		  rY = p.Right
		  If X <= rX And Y <= rY Then
		    Label1.Text = Str(X) + "x" + Str(Y)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, deltaX as Integer, deltaY as Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  #pragma Unused deltaX
		  #pragma Unused deltaY
		  
		  'If PaintTarget1.ViewY <= 0 And Sign(deltaY) = -1 Then Return False
		  'If PaintTarget1.ViewY >= PaintTarget1.ActualSize.Right.Int32Value - PaintTarget1.buffer.Height Then Return False  //Right = (x,Y)
		  Static lastY As Integer
		  If Sign(deltaY) = 1 Then
		    lastY = lastY - 10
		  Else
		    lastY = lastY + 10
		  End If
		  If Not MagOn Then
		    PaintTarget1.ViewY = lastY
		    PaintTarget1.Refresh(False)
		  Else
		    If Not Keyboard.AsyncControlKey Then
		      If Sign(deltaY) = 1 Then
		        Me.MagLevel = Me.MagLevel - 0.1
		      Else
		        Me.MagLevel = Me.MagLevel + 0.1
		      End If
		    Else
		      If Sign(deltaY) = 1 Then
		        Me.MagSize = Me.MagSize - 10
		      Else
		        Me.MagSize = Me.MagSize + 10
		      End If
		    End If
		    
		    Me.Refresh(False)
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Tainted(NewFile As Boolean)
		  If NewFile Then
		    Self.Title = "Simple Paint - " + PaintTarget1.FileName
		    Tainted = False
		  Else
		    Self.Title = "Simple Paint - " + PaintTarget1.FileName + " *"
		    Tainted = True
		  End If
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SetTitle(NewTitle As String)
		  Self.Title = "Simple Paint - " + NewTitle
		End Sub
	#tag EndEvent
	#tag Event
		Function DropObject(Obj As DragItem) As Boolean
		  Dim f() As FolderItem
		  Dim p() As Picture
		  
		  If Obj.FolderItemAvailable Then
		    Do
		      f.Append(Obj.FolderItem)
		    Loop Until Not Obj.NextItem
		    If UBound(f) > 0 Then
		      For x As Integer = 0 To UBound(f)
		        p.Append(GetFramePicture(LoadPicFile(f(x))))
		      Next
		    Else
		      PaintTarget1.Open(f(0))
		      Return True
		    End If
		  ElseIf Obj.PictureAvailable Then
		    Do
		      p.Append(Obj.Picture)
		    Loop Until Not Obj.NextItem
		    If UBound(p) = 0 Then
		      PaintTarget1.Open(p(0))
		      Return True
		    End If
		  End If
		  
		  Dim i As Integer = MsgBox("You have dropped multiple pictures." + EndOfLine + "Initiate slideshow mode now?", 36, "Secret Feature Discovered")
		  If i = 6 Then
		    ReDim Slides(-1)
		    Slides = p
		    Timer1.Mode = Timer.ModeMultiple
		    PaintTarget1.FileName = "Slideshow"
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If Key = Chr(&hC8) Then
		    HelpWin.ShowMe("Main")
		    'hw.Show
		  End If
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If DropperMode Then
		    DropperMode = False
		    Self.MouseCursor = CurrentCursor
		    PaintTarget1.CurrentColor = System.Pixel(System.MouseX, System.MouseY)
		    ColorPicker2.SelectedColor = PaintTarget1.CurrentColor
		    Canvas2.Refresh(False)
		    TheToolsWin.ModeButton(7).value = False
		  End If
		  
		  If HelpSelectMode Then
		    HelpWin.ShowMe("Main.Canvas")
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function CancelOpen() As Boolean
		  If Tainted Then
		    Select Case MsgBox("Would you like to save your changes? Click Yes to save, No to continue without saving, or Cancel to continue painting.", _
		      51 + 256, "Unsaved changes - " + PaintTarget1.FileName)
		    Case 6  //Yes
		      SaveFile()
		      Return False
		    Case 2  //Cancel
		      Return True
		    End Select
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ColorPicker2
	#tag Event
		Sub ColorSelected(NewColor As Color)
		  PaintTarget1.CurrentColor = NewColor
		  Me.SelectedColor = NewColor
		  Canvas2.Refresh(False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Me.SampleColor = System.Pixel(System.MouseX, System.MouseY)
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If HelpSelectMode Then
		    HelpWin.ShowMe("Main.Color Selector")
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  PaintTarget1.CurrentColor = Me.SelectedColor
		  Canvas2.Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  Me.SelectedColor = PaintTarget1.CurrentColor
		End Sub
	#tag EndEvent
	#tag Event
		Sub SampleChanged(NewSample As Color)
		  Label1.Text = "#" + NewSample.ColorToHex
		  Label1.Refresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Canvas2
	#tag Event
		Sub Paint(g As Graphics)
		  g.ForeColor = PaintTarget1.CurrentColor
		  g.FillRect(0, 0, g.Width, g.Height)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick(X As Integer, Y As Integer)
		  #pragma Unused X
		  #pragma Unused Y
		  Dim c As Color = PaintTarget1.CurrentColor
		  Call SelectColor(c, "Choose a Color")
		  PaintTarget1.CurrentColor = c
		  Me.Refresh(False)
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If HelpSelectMode Then
		    HelpWin.ShowMe("Main.Current Color")
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Label1
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If HelpSelectMode Then
		    HelpWin.ShowMe("Main.Meta")
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Vertical
	#tag Event
		Sub ValueChanged()
		  Static lastVal As Integer
		  PaintTarget1.Scrolling = True
		  PaintTarget1.Scroll(0, Me.Value)
		  PaintTarget1.Scrolling = False
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If HelpSelectMode Then
		    HelpWin.ShowMe("Main.Vertical Slider")
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Horitontal
	#tag Event
		Sub ValueChanged()
		  PaintTarget1.Scrolling = True
		  PaintTarget1.Scroll(Me.Value, 0)
		  PaintTarget1.Scrolling = False
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If HelpSelectMode Then
		    HelpWin.ShowMe("Main.Horizontal Slider")
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Timer1
	#tag Event
		Sub Action()
		  #pragma BreakOnExceptions Off
		  Static i As Integer
		  If UBound(Slides) > -1 Then
		    PaintTarget1.Replace(Slides(i))
		    i = i + 1
		  Else
		    Me.Mode = Timer.ModeOff
		    i = 0
		    PaintTarget1.Open(New Picture(500, 500, 32))
		    PaintTarget1.FileName = "New Picture"
		  End If
		  
		Exception
		  Me.Mode = Timer.ModeOff
		  i = 0
		  PaintTarget1.Open(New Picture(500, 500, 32))
		  PaintTarget1.FileName = "New Picture"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  If HelpSelectMode Then HelpSelectMode = False
		  If MagOn Then MagOn = False
		  PaintTarget1.Refresh(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events placardButton1
	#tag Event
		Sub Action()
		  HelpSelectMode = Me.value
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  HelpSelectMode = Me.value
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If HelpSelectMode Then
		    HelpWin.ShowMe("Main.Help Button")
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events capturetimer
	#tag Event
		Sub Action()
		  Dim l, t, w, h As Integer
		  l = PaintTarget1.Left + Self.Left
		  t = OldY
		  w = PaintTarget1.Width
		  h = PaintTarget1.Height
		  
		  Dim p As Picture = Platform.GetPartialScreenShot(l, t, w, h)
		  PaintTarget1.Open(p)
		  Self.Top = OldY
		End Sub
	#tag EndEvent
#tag EndEvents
