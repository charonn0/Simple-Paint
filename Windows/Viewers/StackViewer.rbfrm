#tag Window
Begin Window StackViewer
   BackColor       =   8421504
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   True
   Height          =   521
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   True
   Title           =   "Stack View"
   Visible         =   True
   Width           =   600
   Begin CompositeContainer dragContainer1
      AcceptFocus     =   ""
      AcceptTabs      =   ""
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
      Height          =   521
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
      Untitled        =   0
      UseFocusRing    =   True
      ViewX           =   0
      ViewY           =   0
      Visible         =   True
      Width           =   600
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Restore"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   612
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   -64
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   704
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   -64
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButton3
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Composite"
      Default         =   ""
      Enabled         =   False
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   1084
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   -71
      Underline       =   ""
      Visible         =   False
      Width           =   83
   End
   Begin ComboBox ComboBox1
      AutoComplete    =   False
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialValue    =   "Rotate 90 degrees left\r\nRotate 90 degrees right\r\nGreyscale\r\nMerge Multiple\r\nScale"
      Italic          =   ""
      Left            =   913
      ListIndex       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   -71
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   False
      Width           =   165
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Resized()
		  'dragContainer1.Arrange()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Destructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowMe(p() As String, Mode As Integer) As String
		  dragContainer1.Mode = CompositeContainer.Master_Mode_Display Or CompositeContainer.Mode_Draw_Freeform
		  ReDim Pics(-1)
		  Select Case Mode
		  Case 0 //Redo
		    Self.Title = "Redo Stack"
		    dragContainer1.OverrideText = "One may not rehash the future."
		  Case 1 //Undo
		    Self.Title = "Undo Stack"
		    dragContainer1.OverrideText = "You must act before you may repent."
		  Case 2 //Stack View
		    Self.Title = "Stack - All"
		    dragContainer1.OverrideText = "This area intentionally left blank."
		    For i As Integer = 0 To Icons.Count - 1
		      Dim no As New dragObject(GetFramePicture(Icons.Key(i)))
		      no.Properties.Value("Key") = Icons.Key(i)
		      dragContainer1.addObject(no, Icons.Key(i))
		    Next
		    
		    dragContainer1.Override = dragContainer1.objects.Ubound = -1
		    Loading.Close
		    Me.ShowModal
		    Return SelectedIndex
		  End Select
		  
		  If UBound(p) > -1 Then
		    Dim no As dragObject
		    For i As Integer = 0 To UBound(p)
		      no = New dragObject(GetFramePicture(p(i)))
		      no.Properties.Value("Key") = p(i)
		      dragContainer1.addObject(no)
		      Pics.Append(p(i))
		    Next
		    dragContainer1.Arrange
		  Else
		    dragContainer1.Override = True
		  End If
		  Loading.Close
		  Me.ShowModal
		  
		  Return SelectedIndex
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Pics() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectedIndex As String
	#tag EndProperty


	#tag Constant, Name = DSTINVERT, Type = Double, Dynamic = False, Default = \"&h00550009", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events dragContainer1
	#tag Event
		Sub ItemQuickSelected(Key As String)
		  SelectedIndex = Key
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Function ItemSelected(Key As String) As Boolean
		  SelectedIndex = Key
		End Function
	#tag EndEvent
	#tag Event
		Function DeleteItem(Key As String) As Boolean
		  MemoryManager.DeleteCachedImage(Key)
		  For i As Integer = 0 To UBound(Pics)
		    If Pics(i) = Key Then
		      Pics.Remove(i)
		    End If
		  Next
		  SelectedIndex = ""
		  Me.Refresh(False)
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  If SelectedIndex <> "" Then
		    Self.Close
		  Else
		    MsgBox("No item selected to restore.")
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  SelectedIndex = ""
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton3
	#tag Event
		Sub Action()
		  'Dim rj As New RenderJob
		  'For i As Integer = 0 To UBound(Items)
		  'rj.SourceImages.Append(SourcePics(Items(i)))
		  'Next
		  '
		  'Dim Renderer As New RenderThread(rj)
		  'AddHandler Renderer.Done, AddressOf Donehandler
		  'Renderer.Run
		End Sub
	#tag EndEvent
#tag EndEvents
