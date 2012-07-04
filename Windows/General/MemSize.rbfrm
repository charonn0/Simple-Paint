#tag Window
Begin Window MemSize
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   6.4e+1
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
   Placement       =   0
   Resizeable      =   False
   Title           =   "Max Memory"
   Visible         =   True
   Width           =   1.78e+2
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   56
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
      Top             =   35
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin TextField TextField1
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   16777215
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   ""
      Left            =   70
      LimitText       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Mask            =   "####"
      Password        =   ""
      ReadOnly        =   ""
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   8
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   52
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Pic = GetFramePicture("seesaw1.png")
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		Pic As Picture
	#tag EndProperty


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  Dim size As Integer = CDbl(TextField1.Text)
		  If size > 900 Then
		    MsgBox("Maximum must be 900MB or less.")
		    Return
		  Else
		    If size < MemoryManager.MaxMem Then
		      MemoryManager.MaxMem = size
		      Call MemoryManager.FlushCache()
		    Else
		      MemoryManager.MaxMem = size
		    End If
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextField1
	#tag Event
		Sub Open()
		  Me.Text = Str(MemoryManager.MaxMem \ 1024)
		End Sub
	#tag EndEvent
#tag EndEvents
