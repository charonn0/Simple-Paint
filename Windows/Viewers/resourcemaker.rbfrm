#tag Window
Begin Window resourcemaker
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   521
   ImplicitInstance=   True
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
      Caption         =   "Create Resource"
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
	#tag Event
		Sub Open()
		  Clipper.Mode = CompositeContainer.Master_Mode_Display Or CompositeContainer.Mode_Draw_Freeform
		  Clipper.OverrideText = "Drop pictures here"
		  Clipper.Override = True
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		Items() As String
	#tag EndProperty


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  Dim vv As SafeVirtualVolume
		  Dim f As FolderItem = GetSaveFolderItem(FileTypes1.SimplePaintResourceFile, "icons")
		  
		  If f <> Nil Then
		    vv = New SafeVirtualVolume()
		    Call MemoryManager.FlushCache()
		    For i As Integer = 0 To UBound(Items)
		      Dim sf As StackFrame = GetFrame(Items(i))
		      If sf = Nil Then 
		        Continue
		      End If
		      sf.CopyTo(vv.Root.Child(Items(i)))
		    Next
		    vv.Save(f)
		    vv.Close
		    MsgBox("Done")
		  Else
		    MsgBox("No file")
		  End If
		  
		  
		Exception err As ResourceException
		  Static lossWin As New ExpectedExceptions
		  Call lossWin.ShowMe(err.Message)
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
		Function Added(Key As String) As Boolean
		  Items.Append(Key)
		End Function
	#tag EndEvent
	#tag Event
		Function DeleteItem(Key As String) As Boolean
		  MemoryManager.DeleteCachedImage(Key)
		  For i As Integer = 0 To UBound(Items)
		    If Items(i) = Key Then
		      Items.Remove(i)
		    End If
		  Next
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function DropObject(Obj As DragItem) As Boolean
		  If Obj.FolderItemAvailable Then
		    Do
		      Dim file As FolderItem = Obj.FolderItem
		      Dim no As dragObject
		      Dim key As String = LoadPicFile(File)
		      no = New dragObject(GetFramePicture(key))
		      no.Properties.Value("Key") = key
		      Clipper.addObject(no, key)
		    Loop Until Not Obj.NextItem
		    
		  ElseIf Obj.PictureAvailable Then
		    Do
		      Dim file As FolderItem = SpecialFolder.Temporary.Child("Simple Paint").Child(UUID)
		      Obj.Picture.Save(file, Picture.SaveAsMostComplete)
		      Dim no As dragObject
		      Dim key As String = LoadPicFile(File)
		      no = New dragObject(GetFramePicture(key))
		      no.Properties.Value("Key") = key
		      Clipper.addObject(no, key)
		      
		    Loop Until Not Obj.NextItem
		  End If
		  Clipper.Override = UBound(Items) = -1
		  Clipper.Arrange()
		  
		  Return False
		End Function
	#tag EndEvent
#tag EndEvents
