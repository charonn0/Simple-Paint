#tag Window
Begin Window Supervisor
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   68
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   False
   Title           =   "Canvas Supervisor"
   Visible         =   True
   Width           =   213
   Begin Label Label1
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   54
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   42
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      Text            =   "If you can see this, then something is broken. Fixing..."
      TextAlign       =   1
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   128
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Call MemoryManager.CleanUp()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Visible = False
		  
		  If Not MemoryManager.ExtractIcons() Then
		    Static lossWin As New ExpectedExceptions
		    Call lossWin.ShowMe("The icons.res file is corrupt. While this error is 'non-fatal' it will make using this program rather difficult.")
		  End If
		  
		  Dim error As Boolean
		  While Not error
		    error = Start()
		  Wend
		  
		  Quit()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Start() As Boolean
		  Me.Visible = False
		  MainWindow = Nil
		  MainWindow = New PaintWindow
		  MainWindow.PaintTarget1.Mode = CompositeContainer.Mode_Draw_Freeform Or CompositeContainer.Master_Mode_Paint
		  Return MainWindow.Load()
		End Function
	#tag EndMethod


#tag EndWindowCode

