#tag Window
Begin Window ClipViewer
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
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
   Title           =   "Clipboard View"
   Visible         =   True
   Width           =   600
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Clear From Clipboard"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   306
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
      Top             =   491
      Underline       =   ""
      Visible         =   True
      Width           =   123
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
      Left            =   171
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
      Top             =   491
      Underline       =   ""
      Visible         =   True
      Width           =   123
   End
   Begin CompositeContainer Clipper
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
      Font            =   "System"
      FontSize        =   11
      Height          =   485
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
      MagSize         =   ""
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
      Width           =   600
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function ShowMe(p() As String, Mode As Integer) As String
		  #pragma Unused Mode
		  Clipper.Mode = CompositeContainer.Master_Mode_Display Or CompositeContainer.Mode_Draw_Freeform
		  Clipper.OverrideText = "No image data on the clipboard."
		  Clipper.Override = (UBound(p) = -1)
		  If UBound(p) > -1 Then
		    Dim no As dragObject
		    For i As Integer = 0 To UBound(p)
		      Dim img As Picture = GetFramePicture(p(i))
		      no = New dragObject(img)
		      no.Properties.Value("Key") = p(i)
		      Clipper.addObject(no)
		    Next
		    Clipper.Arrange
		  Else
		    Clipper.Override = True
		  End If
		  Loading.Close
		  Me.ShowModal
		  
		  Return SelectedPic
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		SelectedPic As String
	#tag EndProperty


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  Dim cb As New Clipboard
		  cb.Picture = Nil
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Clipper
	#tag Event
		Function DropObject(Obj As DragItem) As Boolean
		  Dim cb As New Clipboard
		  If Obj.FolderItemAvailable Then
		    Dim p As Picture = GetFramePicture(LoadPicFile(Obj.FolderItem))
		    If p <> Nil Then
		      cb.Picture = p
		      Clipper.Override = False
		      Me.Refresh(True)
		    End If
		  ElseIf Obj.PictureAvailable Then
		    cb.Picture = Obj.Picture
		    Clipper.Override = False
		    Me.Refresh(True)
		  Else
		    cb.Picture = Nil
		  End If
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ItemSelected(Key As String) As Boolean
		  SelectedPic = Key
		End Function
	#tag EndEvent
	#tag Event
		Sub ItemQuickSelected(Key As String)
		  SelectedPic = Key
		  Close
		End Sub
	#tag EndEvent
	#tag Event
		Function DeleteItem(Key As String) As Boolean
		  #pragma Unused Key
		  Dim cb As New Clipboard
		  cb.Picture = Nil
		End Function
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  MsgBox(Key)
		End Function
	#tag EndEvent
#tag EndEvents
