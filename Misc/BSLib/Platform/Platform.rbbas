#tag Module
Protected Module Platform
	#tag Method, Flags = &h1
		Protected Function AboutBox(AboutTitle As String, AboutOther As String, parentWindow As Integer = 0) As Boolean
		  //Shows the standard WinVer window, with the specified title and additional info
		  //Pass the Window.Handle for the parent window, if desired.
		  
		  #If TargetWin32 Then
		    Declare Function ShellAboutW Lib "Shell32" (HWND As Integer, msgString As WString, otherStuff As WString, hIcon As Integer) As Boolean
		    Call ShellAboutW(parentWindow, AboutTitle, AboutOther, 0)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AdjustPrivilegeToken(PrivilegeName As String, mode As Integer) As Integer
		  //Modifies the calling process' security token
		  //See the SE_* Constants in Win32Constants for privilege names.
		  //Returns 0 on success, or a Win32 error number on failure.
		  #If TargetWin32 Then
		    Declare Function OpenProcessToken Lib "AdvApi32" (handle As Integer, access As Integer, ByRef tHandle As Integer) As Boolean
		    Declare Function LookupPrivilegeValueW Lib "AdvApi32" (sysName As WString, privName As WString, Luid As Ptr) As Boolean
		    Declare Function AdjustTokenPrivileges Lib "AdvApi32" (tHandle As Integer, disableAllPrivs As Boolean, newState As Ptr, buffLength As Integer, prevPrivs As Ptr, ByRef retLen As Integer) As Boolean
		    
		    Dim thisProc As Integer = CurrentProcess()
		    Dim tHandle As Integer
		    If OpenProcessToken(thisProc, TOKEN_ADJUST_PRIVILEGES Or TOKEN_QUERY, tHandle) Then
		      Dim luid As New MemoryBlock(8)
		      If LookupPrivilegeValueW(Nil, PrivilegeName, luid) Then
		        Dim newState As New MemoryBlock(16)
		        newState.UInt32Value(0) = 1
		        newState.UInt32Value(4) = luid.UInt32Value(0)
		        newState.UInt32Value(8) = luid.UInt32Value(4)
		        newState.UInt32Value(12) = mode  //mode can be enable, disable, or remove. See: EnablePrivilege, DisablePrivilege, and DropPrivilege.
		        Dim retLen As Integer
		        Dim prevPrivs As Ptr
		        If AdjustTokenPrivileges(tHandle, False, newState, newState.Size, prevPrivs, retLen) Then
		          Return 0
		        Else
		          Return LastErrorCode
		        End If
		      Else
		        Return LastErrorCode
		      End If
		    Else
		      Return LastErrorCode
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Args() As String()
		  //Returns a String array of the application's arguments, like the args() parameter of the console application's Run event.
		  Return Tokenize(System.CommandLine)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailablePageFile() As UInt64
		  //Returns an Unsigned 64 bit Integer representing the number of bytes of page file currently available.
		  
		  #If TargetWin32 Then Return GlobalMemoryStatus.AvailablePageFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailablePhysicalRAM() As UInt64
		  //Returns an Unsigned 64 bit Integer representing the number of bytes of physical RAM which are free.
		  
		  #If TargetWin32 Then Return GlobalMemoryStatus.AvailablePhysicalMemory
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableProcessAddressSpace() As UInt64
		  //Returns an Unsigned 64 bit Integer representing the number of bytes of virtual address space available (unallocated)
		  //to the current process after Windows takes its cut. Since RB is only 32-bit, this will be 2GB minus actual commited virtual
		  //addresses 99.8% of the time and 3GB minus actual commited virtual addresses in rare setups that specify the /3GB switch
		  //in the boot parameters of 32 bit Windows.
		  //See also: TotalProcessAddressSpace
		  
		  #If TargetWin32 Then Return GlobalMemoryStatus.CurrentProcessAvailableAddressSpace
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Beep(freq As Integer, duration As Integer)
		  //This function differs from the built-in Beep method in that both the frequency and duration of the beep can (must) be specified.
		  //Windows Vista and XP64 omit this function.
		  #If TargetWin32 Then
		    If System.IsFunctionAvailable("Beep", "Kernel32") Then
		      Soft Declare Function WinBeep Lib "Kernel32" Alias "Beep" (freq As Integer, duration As Integer) As Boolean
		      Call WinBeep(freq, duration)
		    Else
		      #If TargetHasGUI Then Realbasic.Beep  //Built-in beep not available in ConsoleApplications? Weird.
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BIOSDate() As String
		  //Returns the date string of the BIOS as reported in the Windows registry.
		  #If TargetWin32 Then
		    If Platform.IsAtLeast(Platform.WinVista) Then
		      Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		      Return reg.Child("BIOS").Value("BIOSReleaseDate")
		    Else
		      Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		      Return reg.Child("BIOS").Value("SystemBiosDate")
		    End If
		  #endif
		Exception err As RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BIOSVendor() As String
		  //Returns the Vendor string of the BIOS as reported in the Windows registry.
		  #If TargetWin32 Then
		    If Platform.IsAtLeast(Platform.WinVista) Then
		      Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		      Return reg.Child("BIOS").Value("BIOSVendor")
		    Else
		      Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		      Return reg.Child("BIOS").Value("SystemBiosVersion")
		    End If
		  #endif
		  
		  
		Exception err As RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BIOSVersion() As String
		  //Returns the Version string of the BIOS as reported in the Windows registry.
		  
		  #If TargetWin32 Then
		    If Platform.IsAtLeast(Platform.WinVista) Then
		      Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		      Return reg.Child("BIOS").Value("BIOSVersion")
		    Else
		      Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		      Return reg.Child("BIOS").Value("SystemBiosVersion")
		    End If
		  #endif
		  
		  
		Exception err As RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CaptureScreen() As Picture
		  //Calls GetPartialScreenShot with a rectangle comprising all of the desktop rectangle. Returns a Picture
		  
		  #If TargetWin32 Then Return GetPartialScreenShot(0, ScreenVirtualWidth, 0, ScreenVirtualHeight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloseDrive(Extends f As FolderItem)
		  //Given a FolderItem, this function commands the drive containing the FolderItem to close. If the drive is not an ejectable drive, or if
		  //the drive is already closed then this does nothing
		  
		  #If TargetWin32 Then
		    Declare Function GetVolumeNameForVolumeMountPointW Lib "Kernel32" (mountPoint As WString, volumeName As Ptr, bufferSize As Integer) As Boolean
		    
		    Dim dhandle As Integer
		    Dim mb As New MemoryBlock(55)
		    Dim nilBuffer As New MemoryBlock(0)
		    
		    If GetVolumeNameForVolumeMountPointW(f.AbsolutePath, mb, mb.Size) Then
		      Dim drvRoot As String = "\\.\" + mb.StringValue(0, 55)
		      dhandle = Platform.CreateFile(drvRoot, GENERIC_READ, FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0)
		    Else
		      Return
		    End If
		    
		    Dim IOCTL_STORAGE_LOAD_MEDIA As Integer = Platform.CTL_CODE(IOCTL_STORAGE_BASE, &h0203, METHOD_BUFFERED, FILE_READ_ACCESS)
		    Call DeviceIoControl(dhandle, IOCTL_STORAGE_LOAD_MEDIA, nilBuffer, 0, nilBuffer, 0, nilBuffer, 0)
		    Call Platform.CloseHandle(dhandle)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CloseHandle(Handle As Integer) As Boolean
		  #If TargetWin32 Then
		    Declare Function MyCloseHandle Lib "Kernel32" Alias "CloseHandle" (HWND As Integer) As Boolean
		    
		    Return MyCloseHandle(Handle)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ComputerName() As String
		  //Returns the system's NetBIOS name.
		  #If TargetWin32 Then
		    Declare Function GetComputerNameW Lib "Kernel32" (name As Ptr, ByRef size As Integer) As Boolean
		    
		    Dim mb As New MemoryBlock(16)
		    Dim size As Integer = mb.Size
		    Call GetComputerNameW(mb, size)
		    Return mb.WString( 0 )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CPUArchitecture() As Integer
		  //Returns the CPU architecture of the installed operating system. See the PROCESSOR_ARCHITECTURE_* constants for possible return values
		  //This may differ from the information provided by OSArchitecture since a 32 bit OS can run on a 64 bit capable processor (see below)
		  
		  #If TargetWin32 Then
		    Dim info As SYSTEM_INFO
		    
		    If OSArchitecture = 64 Then
		      //The RB compiler, as of the time this function is being written, is incapable of creating 64 bit Windows executables.
		      //As a result, all RB applications under 64 bit Windows are executed within the Win32 subsystem of Win64 (WoW64)
		      //WoW64 accomplishes its task by, primarily, lying to the application about its environment. We have to
		      //specifically ask not to be lied to in these cases. Hence, this function call:
		      Soft Declare Sub GetNativeSystemInfo Lib "Kernel32" (ByRef info As SYSTEM_INFO)
		      GetNativeSystemInfo(info)
		    Else
		      Soft Declare Sub GetSystemInfo Lib "Kernel32" (ByRef info As SYSTEM_INFO)
		      GetSystemInfo(info)
		    End If
		    
		    Return info.OEMID
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CPUID() As String
		  //Returns the description for the installed processor as stored in the registry.
		  //e.g. "Intel64 Family 6 Model 42 Stepping 7"
		  
		  #If TargetWin32 Then
		    Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0", False)
		    Return reg.Value("Identifier")
		  #endif
		  
		Exception RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CPUSpeed() As Integer
		  //Returns the default speed in MHz of the processor. (this will not reflect overclocking)
		  #If TargetWin32 Then
		    Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0", False)
		    Return Val(reg.Value("~MHZ"))
		  #endif
		  
		Exception RegistryAccessErrorException
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CPUUsage() As CPUUsagePercents
		  //Returns a CPUUsagePercents structure representing the system-wide CPU usage percents (user mode, kernel mode, and idle.)
		  
		  #If TargetWin32 Then
		    Declare Function GetSystemTimes Lib "kernel32.dll" (idleTime As Ptr, kernelTime As Ptr, userTime As Ptr) As Boolean
		    Declare Function FileTimeToSystemTime Lib "kernel32.dll" (fileTime As Ptr, systemTime As Ptr) As Boolean
		    Dim user, kernel, idle As MemoryBlock
		    user = New MemoryBlock(8)
		    kernel = New MemoryBlock(8)
		    idle = New MemoryBlock(8)
		    Call GetSystemTimes(idle, kernel, user)
		    
		    Dim k, i, u As UInt64
		    Static oldK, oldI, oldU As UInt64
		    k = kernel.UInt64Value(0) - oldK
		    i = idle.UInt64Value(0) - oldI
		    u = user.UInt64Value(0) - oldU
		    oldK = kernel.UInt64Value(0)
		    oldI = idle.UInt64Value(0)
		    oldU = user.UInt64Value(0)
		    
		    Dim ret As CPUUsagePercents
		    Dim sys As Double = k + u
		    
		    ret.UserMode = ((sys - i) * 100 / sys)
		    ret.KernelMode = ((sys - i - u) * 100 / sys)
		    ret.Idle = (100 - ret.UserMode - ret.KernelMode)
		    
		    Return ret
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateFile(name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, CreateDisp As Integer, flags As Integer, template As Integer) As Integer
		  //Used everywhere.
		  #If TargetWin32 Then
		    Declare Function CreateFileW Lib "Kernel32"(name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, _
		    CreateDisp As Integer, flags As Integer, template As Integer) As Integer
		    Return CreateFileW(name, access, sharemode, SecAtrribs, CreateDisp, flags, template)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateProcess(AppName As WString, commandline As Ptr, ProcessAttribs As SECURITY_ATTRIBUTES, ThreadAttribs As SECURITY_ATTRIBUTES, inheritHandles As Boolean, flags As Integer, environ As Ptr, currentDir As Ptr, startInfo As STARTUPINFO, ByRef info As PROCESS_INFORMATION) As Boolean
		  Declare Function CreateProcessW Lib "Kernel32" (AppName As WString, commandline As Ptr, ProcessAttribs As SECURITY_ATTRIBUTES, ThreadAttribs As SECURITY_ATTRIBUTES, _
		  inheritHandles As Boolean, flags As Integer, environ As Ptr, currentDir As Ptr, startInfo As STARTUPINFO, ByRef info As PROCESS_INFORMATION) As Boolean
		  Return CreateProcessW(AppName, commandline, ProcessAttribs, ThreadAttribs, inheritHandles, flags, environ, currentDir, startInfo, info)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CTL_CODE(lngDevFileSys As Integer, lngFunction As Integer, lngMethod As Integer, lngAccess As Integer) As Integer
		  //This function generates IOCTL control codes used in calls to DeviceIoControl
		  
		  lngDevFileSys = lngDevFileSys * 2^16
		  lngAccess = lngAccess * 2^14
		  lngFunction = lngFunction * 2^2
		  Return lngDevFileSys Or lngAccess Or lngFunction Or lngMethod
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CurrentProcess() As Integer
		  //Returns a handle to the current process.
		  #If TargetWin32 Then
		    Declare Function GetCurrentProcess Lib "Kernel32" () As Integer
		    Return GetCurrentProcess()
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CurrentUser() As String
		  //Returns the username of the account under which the application is running.
		  //On Error, returns an empty string
		  //Do not use this function to determine if the user is the Administrator. Use IsAdmin instead.
		  
		  #If TargetWin32 Then
		    Declare Function GetUserNameW Lib "AdvApi32" (buffer As Ptr, ByRef buffSize As Integer) As Boolean
		    
		    Dim mb As New MemoryBlock(0)
		    Dim nmLen As Integer = mb.Size
		    Call GetUserNameW(mb, nmLen)
		    mb = New MemoryBlock(nmLen * 2)
		    nmLen = mb.Size
		    If GetUserNameW(mb, nmLen) Then
		      Return mb.WString(0)
		    Else
		      Return ""
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DeviceIoControl(hDevice As Integer, dwIoControlCode As Integer, lpInBuffer As Ptr, nInBufferSize As Integer, lpOutBuffer As Ptr, nOutBufferSize As Integer, lpBytesReturned As Ptr, lpOverlapped As Integer) As Integer
		  //Used for sending control messages to hardware devices, e.g. EjectDrive
		  #If TargetWin32 Then
		    Declare Function MyDeviceIoControl Lib "Kernel32" Alias "DeviceIoControl" (hDevice As Integer, dwIoControlCode As Integer, lpInBuffer As Ptr, _
		    nInBufferSize As Integer, lpOutBuffer As Ptr, nOutBufferSize As Integer, lpBytesReturned As Ptr, lpOverlapped As Integer) As Integer
		    
		    Return MyDeviceIOControl(hDevice, dwIoControlCode, lpInBuffer, nInBufferSize, lpOutBuffer, nOutBufferSize, lpBytesReturned, lpOverlapped)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DisablePrivilege(PrivilegeName As String) As Boolean
		  //This function attempts to disable the privilege designated by PrivilegeName in the process' security token.
		  //Privilege names are documented here: http://msdn.microsoft.com/en-us/library/windows/desktop/bb530716%28v=vs.85%29.aspx
		  //This function will fail and return False if the processes security token did not already posess the requested privilege, if the privilege
		  //requested does not exist, if the process does not have TOKEN_ADJUST_PRIVILEGES and TOKEN_QUERY access to itself, or if the Privilege was not
		  //previously enabled.
		  
		  #If TargetWin32 Then Return AdjustPrivilegeToken(PrivilegeName, 0) = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DriveType(target As FolderItem) As Integer
		  //Returns an Integer corresponding to one of the Bus* constants (e.g. BusATA or BusUSB) See the Win32Constants.Bus* constants.
		  
		  #If TargetWin32 Then
		    Dim IO_CODE As Integer = Platform.CTL_CODE(FILE_DEVICE_MASS_STORAGE, &h0500, 0, 0)
		    
		    Dim drvRoot As String = "\\.\" + Left(target.AbsolutePath, 2)
		    Dim drvHWND As Integer = Platform.CreateFile(drvRoot, GENERIC_READ, FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0)
		    Dim mb As New MemoryBlock(34)
		    Dim bRet As New MemoryBlock(4)
		    
		    If DeviceIoControl(drvHWND, IO_CODE, mb, mb.Size, mb, mb.Size, bRet, 0) <> 0 Then
		      Return mb.Byte(8)
		    Else
		      Return BusUnknown
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DropPrivilege(PrivilegeName As String) As Boolean
		  //This function attempts remove the privilege designated by PrivilegeName in the process' security token. This is different
		  //from merely disabling the Privilege since future attempts to enable it will fail with ERROR_PRIVILEGE_NOT_HELD.
		  //Once a privilege is dropped, it cannot be reacquired.
		  //On Windows XP SP1 and earlier, privileges cannot be dropped.
		  //Privilege names are documented here: http://msdn.microsoft.com/en-us/library/windows/desktop/bb530716%28v=vs.85%29.aspx
		  //This function will fail and return False if the processes security token did not already posess the requested privilege, if the privilege
		  //requested does not exist, or if the process does not have TOKEN_ADJUST_PRIVILEGES and TOKEN_QUERY access to itself.
		  
		  #If TargetWin32 Then Return AdjustPrivilegeToken(PrivilegeName, SE_PRIVILEGE_REMOVED) = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EjectDrive(Extends f As FolderItem)
		  //Given a FolderItem, this function commands the drive containing the FolderItem to eject. If the drive is not an ejectable drive
		  //then this does nothing
		  #If TargetWin32 Then
		    Declare Function GetVolumeNameForVolumeMountPointW Lib "Kernel32" (mountPoint As WString, volumeName As Ptr, bufferSize As Integer) As Boolean
		    
		    Dim dhandle As Integer
		    Dim mb As New MemoryBlock(55)
		    Dim nilBuffer As New MemoryBlock(0)
		    
		    If GetVolumeNameForVolumeMountPointW(f.AbsolutePath, mb, mb.Size) Then
		      Dim drvRoot As String = "\\.\" + mb.StringValue(0, 55)
		      dhandle = Platform.CreateFile(drvRoot, GENERIC_READ, FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0)
		    Else
		      Return
		    End If
		    
		    Dim IOCTL_STORAGE_EJECT_MEDIA As Integer = Platform.CTL_CODE(IOCTL_STORAGE_BASE, &h0202, METHOD_BUFFERED, FILE_READ_ACCESS)
		    Call DeviceIoControl(dhandle, IOCTL_STORAGE_EJECT_MEDIA, nilBuffer, 0, nilBuffer, 0, nilBuffer, 0)
		    Call Platform.CloseHandle(dhandle)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EnablePrivilege(PrivilegeName As String) As Boolean
		  //This function attempts to enable the privilege designated by PrivilegeName in the process' security token.
		  //Privilege names are documented here: http://msdn.microsoft.com/en-us/library/windows/desktop/bb530716%28v=vs.85%29.aspx
		  //This function will fail and return False if the processes security token did not already posess the requested privilege, if the privilege
		  //requested does not exist, or if the process does not have TOKEN_ADJUST_PRIVILEGES and TOKEN_QUERY access to itself.
		  
		  #If TargetWin32 Then Return AdjustPrivilegeToken(PrivilegeName, SE_PRIVILEGE_ENABLED) = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ErrorMessageFromCode(err As Integer) As String
		  //Returns the error message corresponding to a given windows error number. If no message is available, returns the error number as a string.
		  //To get the REAL last error code, you should call LastErrorCode *immediately* to avoid having another function change the last error.
		  
		  #If TargetWin32 Then
		    Declare Function FormatMessageW Lib "Kernel32" (dwFlags As Integer, lpSource As Integer, dwMessageId As Integer, dwLanguageId As Integer, lpBuffer As ptr, _
		    nSize As Integer, Arguments As Integer) As Integer
		    
		    Dim buffer As New MemoryBlock(2048)
		    If FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM, 0, err, 0 , Buffer, Buffer.Size, 0) <> 0 Then
		      Return Buffer.WString(0)
		    Else
		      Return str(err)
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExitWindows(mode As Integer) As Integer
		  //Shuts down, reboots, or logs off the computer. Returns 0 on success, or a Win32 error code on error.
		  
		  #If TargetWin32 Then
		    Declare Function ExitWindowsEx Lib "User32" (flags As Integer, reason As Integer) As Boolean
		    If EnablePrivilege("SeShutdownPrivilege") Then
		      Call ExitWindowsEx(mode, 0)
		    End If
		    Return LastErrorCode
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExpandEnvironmentVariable(EnvVar As String) As String
		  //Expands all environment variables in the passed string.
		  //For example, ExpandEnvironmentVariable("%systemroot%") might expand to "C:\Windows"
		  
		  #If TargetWin32 Then
		    Declare Function ExpandEnvironmentStringsW Lib "Kernel32" (EnvString As WString, parsedString As Ptr, buffSize As Integer) As Integer
		    Dim mb As New MemoryBlock(0)
		    mb = New MemoryBlock(2 * ExpandEnvironmentStringsW(EnvVar, mb, mb.Size))
		    If ExpandEnvironmentStringsW(EnvVar, mb, mb.Size) > 0 Then
		      Return mb.WString(0)
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FatalExit(ErrorMessage As String)
		  //Displays the Windows default fatal error message box, with the passed ErrorMessage, then exits the application.
		  //Vista and newer only.
		  
		  If System.IsFunctionAvailable("FatalAppExitW", "Kernel32") Then
		    Soft Declare Sub FatalAppExitW Lib "Kernel32" (Action As Integer, Message As WString)
		    FatalAppExitW(0, ErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FileFromProcessID(processID As Integer) As FolderItem
		  //Given a processID number of an active process, tries to resolve the executable file for the program.
		  //Returns Nil if it cannot resolve the file. Most likely this would be due to insufficient access rights
		  
		  #If TargetWin32 Then
		    Declare Function OpenProcess Lib "Kernel32" (dwDesiredAccessAs As Integer, bInheritHandle As Integer, dwProcId As Integer) As Integer
		    Dim cleanup As Boolean = EnablePrivilege(SE_DEBUG_PRIVILEGE)
		    
		    If Platform.IsExactly(Platform.Win2000) Then
		      //Windows 2000 only
		      Soft Declare Function GetModuleFileNameExW Lib "PSAPI" (hProcess As Integer, hModule As Integer, ModuleName As Ptr, nSize As Integer) As Integer
		      Dim Modules As New MemoryBlock(255)  // 255 = SIZE_MINIMUM * sizeof(HMODULE)
		      Dim ModuleName As New MemoryBlock(255)
		      Dim nSize As Integer
		      
		      Dim hProcess As Integer = OpenProcess(PROCESS_QUERY_INFORMATION Or PROCESS_VM_READ, 0, processID)
		      Dim Result As String
		      If hProcess <> 0 Then
		        ModuleName = New MemoryBlock(255)
		        nSize = 255
		        Call GetModuleFileNameExW(hProcess, Modules.Int32Value(0), ModuleName, 255)
		        Result=Result+ModuleName.WString(0)
		      Else
		        Return Nil
		      End If
		      Call Platform.CloseHandle(hProcess)
		      
		      Result = Replace(Result, "\??\", "")
		      Result = Replace(Result, "\SystemRoot\", SpecialFolder.Windows.AbsolutePath)
		      Dim ret As FolderItem
		      
		      If Result <> "" Then
		        ret = GetFolderItem(Result)
		      End If
		      Return ret
		    ElseIf Platform.IsAtLeast(Platform.WinXP) Then
		      Declare Function QueryDosDeviceW Lib "Kernel32" (devicePath As WString, drivePath As Ptr, drivePathSize As Integer) As Integer
		      Dim pHandle As Integer
		      Dim realsize As Integer
		      
		      If Platform.IsOlderThan(Platform.WinVista) Then
		        pHandle = OpenProcess(PROCESS_QUERY_INFORMATION, 0, processID)
		      Else
		        pHandle = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, 0, processID)
		      End If
		      Dim path As New MemoryBlock(255)
		      If System.IsFunctionAvailable("GetProcessImageFileNameW", "Kernel32") Then
		        Soft Declare Function GetProcessImageFileNameW Lib "Kernel32" (pHandle As Integer, path As Ptr, pathsize As Integer) As Integer
		        If pHandle <> 0 Then
		          realsize = GetProcessImageFileNameW(pHandle, path, path.Size)
		        Else
		          Return Nil
		        End If
		        
		      Else
		        
		        Soft Declare Function GetProcessImageFileNameW Lib "PSAPI" (pHandle As Integer, path As Ptr, pathsize As Integer) As Integer
		        If pHandle <> 0 Then
		          realsize = GetProcessImageFileNameW(pHandle, path, path.Size)
		        Else
		          Return Nil
		        End If
		      End If
		      
		      If realsize > 0 Then
		        Dim retpath As String = path.WString(0)
		        Dim t As String = "\Device\" + NthField(retpath, "\", 3)
		        retpath = retpath.Replace(t, "")
		        
		        For i As Integer = 65 To 90  //A-Z in ASCII
		          Dim mb As New MemoryBlock(255)
		          Call QueryDosDeviceW(Chr(i) + ":", mb, mb.Size)
		          If mb.Wstring(0) = t Then
		            retpath = Chr(i) + ":" + retpath
		            Return GetFolderItem(retpath)
		          End If
		        Next
		      End If
		    End If
		    If cleanup Then Call DisablePrivilege(SE_DEBUG_PRIVILEGE)
		  #endif
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindFileOnPath(fileName As String, searchDir As FolderItem = Nil) As FolderItem
		  Declare Function PathResolve Lib "Shell32" (path As Ptr, startDir As Ptr, flags As Integer) As Boolean
		  Const PRF_VERIFYEXISTS = &h0001
		  Const PRF_TRYPROGRAMEXTENSIONS = &h0002
		  Const PRF_FIRSTDIRDEF  = &h0004
		  Const PRF_DONTFINDLNK  = &h0008      // if PRF_TRYPROGRAMEXTENSIONS is specified
		  Const PRF_REQUIREABSOLUTE = &h0010
		  
		  Dim mb As New MemoryBlock(255)
		  Dim bm As MemoryBlock
		  If searchDir <> Nil Then bm = searchDir.AbsolutePath
		  
		  Dim flags As Integer = PRF_REQUIREABSOLUTE Or PRF_VERIFYEXISTS
		  If PathResolve(mb, Nil, flags) Then
		    Return GetFolderItem(mb.WString(0) + "\" + fileName)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCPUCurrentMhz(cpuNumber As Integer) As Integer
		  //Returns the current clock rate of the specified CPU. CPUs are counted starting at zero.
		  //If the maximum clock = the current clock, then no power-scheme related throttling is taking place. (see: GetCPUCurrentMhz)
		  
		  Const ProcessorInformation = 11
		  Dim procs() As PROCESSOR_POWER_INFORMATION = NTPowerInfoHelper(ProcessorInformation)
		  Return procs(cpuNumber).CurrentMhz
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCPUMaxMhz(cpuNumber As Integer) As Integer
		  //Returns the maximum clock rate of the specified CPU. CPUs are counted starting at zero.
		  //If the maximum clock = the current clock, then no power-scheme related throttling is taking place. (see: GetCPUCurrentMhz)
		  
		  Const ProcessorInformation = 11
		  Dim procs() As PROCESSOR_POWER_INFORMATION = NTPowerInfoHelper(ProcessorInformation)
		  Return procs(cpuNumber).MaxMhz
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetMetric(metric As Integer) As Integer
		  //Queries sundry system metrics. Available metrics are listed here: http://msdn.microsoft.com/en-us/library/windows/desktop/ms724385%28v=vs.85%29.aspx
		  
		  #If TargetWin32 Then
		    Declare Function GetSystemMetrics Lib "User32"  (nIndex As Integer) As integer
		    Return GetSystemMetrics(metric)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetPartialScreenShot(X As Integer, Y As Integer, width As Integer, height As Integer) As Picture
		  //Returns a Picture of the defined rectangle from current desktop.
		  //Rectangle coordinates are relative to the upper left corner of the user's leftmost screen, in pixels
		  
		  #If TargetWin32 Then
		    Declare Function GetDesktopWindow Lib "User32" () As Integer
		    Declare Function GetDC Lib "User32" (HWND As Integer) As Integer
		    Declare Function BitBlt Lib "GDI32" (DCdest As Integer, xDest As Integer, yDest As Integer, nWidth As Integer, nHeight As Integer, _
		    DCdource As Integer, xSource As Integer, ySource As Integer, rasterOp As Integer) As Boolean
		    Declare Function ReleaseDC Lib "User32" (HWND As Integer, DC As Integer) As Integer
		    
		    Dim screenCap As New Picture(Width, Height, 24)
		    Dim deskHWND As Integer = GetDesktopWindow()
		    Dim deskHDC As Integer = GetDC(deskHWND)
		    Call BitBlt(screenCap.Graphics.Handle(Graphics.HandleTypeHDC), 0, 0, Width, Height, DeskHDC, X, Y, SRCCOPY Or CAPTUREBLT)
		    Call ReleaseDC(DeskHWND, deskHDC)
		    
		    Return screenCap
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetWindowText(HWND As Integer) As String
		  //Returns the title or caption of the window or control specified by HWND. You must acquire a handle yourself
		  //for windows and controls not part of you app.
		  #If TargetWin32 Then
		    Declare Function GetWindowTextW Lib "user32" ( hWnd As integer, lpString As ptr, cch As integer ) As integer
		    Dim mb As New MemoryBlock(255)
		    Call GetWindowTextW(HWND, mb, mb.Size)
		    Return mb.WString(0)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GlobalMemoryStatus() As MEMORYSTATUSEX
		  //Returns a MEMEORYSTATUSEX structure.
		  
		  #If TargetWin32 Then
		    Declare Function GlobalMemoryStatusEx Lib "Kernel32" (ByRef MemStatus As MEMORYSTATUSEX) As Boolean
		    
		    Dim info As MEMORYSTATUSEX
		    info.sSize = info.Size
		    If GlobalMemoryStatusEx(info) Then
		      Return info
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HostName() As String
		  //Returns the system's HostName
		  #If TargetWin32 Then
		    Declare Function GetHostName Lib "ws2_32" (name As Ptr, size As Integer) As Integer
		    
		    Dim mb As New MemoryBlock(1024)
		    If gethostname(mb, mb.Size) = 0 Then
		      Return mb.CString(0)
		    End
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IPAdaptors() As Dictionary()
		  //Returns an array of dictionaries, each Dictionary containing a Name, Description, local IP, subnet mask, and Gateway address
		  //for a local Network adpater, as strings.
		  
		  #If TargetWin32 Then
		    Declare Function GetAdaptersInfo Lib "Iphlpapi" (info As Ptr, ByRef size As Integer) As Integer
		    Dim x, y As Integer
		    Dim info As New MemoryBlock(1280)
		    y = info.Size
		    x = GetAdaptersInfo(info, y)
		    Dim d() As Dictionary
		    If x = 0 Then
		      While True
		        Dim e As New Dictionary
		        Try
		          Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}")
		          e.Value("Name") = reg.Child(info.CString(8)).Child("Connection").Value("name")
		        Catch RegistryAccessErrorException
		          e.Value("Name") = ""
		        End Try
		        e.Value("Description") = info.CString(&h10C)
		        e.Value("IP Address") = info.CString(&h1B0)
		        e.Value("Subnet Mask") = info.CString(&h1C0)
		        e.Value("Gateway") = info.CString(&h1D8)
		        d.Append(e)
		        If Info.UInt32Value(0) > 0 Then
		          Try
		            info = info.Ptr(0)
		          Catch
		            Exit While
		          End Try
		        Else
		          Exit While
		        End If
		      Wend
		    End If
		    Return d
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IPStats() As MIB_IPSTATS
		  //Returns a MIB_IPSTATS structure. Refer to the Win32Structs.MIB_IPSTATS structure.
		  
		  #If TargetWin32 Then
		    Declare Function GetIpStatistics Lib "Iphlpapi" (ByRef Info As MIB_IPSTATS) As Integer
		    Dim ib As MIB_IPSTATS
		    If GetIpStatistics(ib) = 0 Then
		      Return ib
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAdmin() As Boolean
		  //Returns true if the application is running with administrative privileges
		  //Note that even if this Returns True, that not all privileges many be enabled. See: EnablePrivilege
		  
		  #If TargetWin32 Then
		    Declare Function IsUserAnAdmin Lib "Shell32" () As Boolean
		    Return IsUserAnAdmin()
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAtLeast(OSVersion As Double) As Boolean
		  //Returns True if the current OS is the same version or newer than the specified OSVersion
		  //For example on a computer running Windows XP, Platform.IsAtLeast(WinVista) Will Return False
		  //but Platform.IsAtLeast(WinXP) will Return True.
		  //See also: Platform.IsOlderThan and Platform.IsExactly
		  
		  #If TargetWin32 Then Return KernelVersion >= OSVersion
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsComputerOn() As Boolean
		  //Returns True if the local machine is receiving electrical power and is operating properly,
		  //otherwise the return value is undefined.
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsExactly(OSVersion As Double) As Boolean
		  //Returns True if the current OS version is exactly the same as the OSVersion specified.
		  //For example on a computer running Windows XP, Vista, 98, NT4, etc. Platform.IsExactly(Win2000) Will Return False
		  //Server versions of consumer Windows will generally match the kernel version of the consumer version.
		  //For example, Windows Server 2008 and Windows Vista are both 6.0 but Windows XP and Windows Server 2003 are 5.1 and 5.2 respectively.
		  //See also: Platform.IsAtLeast and Platform.IsOlderThan
		  
		  #If TargetWin32 Then Return KernelVersion = OSVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsOlderThan(OSVersion As Double) As Boolean
		  //Returns True if the current OS kernel version is older than the OSVersion specified.
		  //For example on a computer running Windows XP, Platform.IsOlderThan(Win2000) and Platform.IsOlderThan(WinXP) will both Return False
		  //Whereas on a computer running Windows 2000, Platform.IsOlderThan(WinXP) returns True.
		  //See also: Platform.IsAtLeast and Platform.IsExactly
		  
		  #If TargetWin32 Then Return KernelVersion < OSVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsShuttingDown() As Boolean
		  //Returns True if Windows is shutting down or logging off.
		  Return GetMetric(&h2000) <> 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSystemDrive(Extends f As FolderItem) As Boolean
		  //Returns True if the specified FolderItem (probably) resides on the System drive.
		  
		  #If TargetWin32 Then
		    Dim sysDrive As FolderItem = SpecialFolder.Windows.Parent  //Assumes that Windows is installed in a first-level directory
		    Dim drive As String = NthField(f.AbsolutePath, "\", 1) + "\"
		    Return sysDrive.AbsolutePath = drive
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LastErrorCode() As Integer
		  //Returns the last error for the current process.
		  //Error codes are documented here: http://msdn.microsoft.com/en-us/library/ms681381%28v=VS.85%29.aspx
		  
		  #If TargetWin32 Then
		    Declare Function GetLastError Lib "Kernel32" () As Integer
		    Return GetLastError()
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LeftHandedMouse() As Boolean
		  //Returns True if the user has configured the Right mouse button as the primary
		  //rather than secondary mouse button (i.e. a left-handed user)
		  Return GetMetric(23) <> 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LogOff()
		  //Logs off the current user
		  
		  Call ExitWindows(EWX_LOGOFF)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MACAddress() As String
		  //Returns the MAC Address of the first network adapter
		  #If Not TargetWin32 Then
		    #pragma Error "This function is not available on the target platform."
		  #endif
		  
		  '#pragma Warning "Fixme: This is unreliable."
		  #If TargetWin32 Then
		    Dim sh As New Shell
		    Dim dump(), MAC As String
		    
		    sh.Execute("ipconfig /all")
		    dump = Split(sh.Result, EndOfLine)
		    
		    For Each line As String in dump
		      if InStr(line, "Physical Address") > 0 Then
		        MAC = NthField(line, ": ", 2)
		        Exit For
		      end if
		    Next
		    
		    Return MAC.Trim
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MemoryUse() As Integer
		  //Returns an Integer representing the percent of system memory currently in use.
		  
		  #If TargetWin32 Then Return GlobalMemoryStatus.MemLoad
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MotherboardManufacturer() As String
		  //Returns the Vendor string of the Motherboard as reported in the Windows registry.
		  
		  #If TargetWin32 Then
		    Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		    Return reg.Child("BIOS").Value("BaseBoardManufacturer")
		  #endif
		  
		Exception err As RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MotherboardModel() As String
		  //Returns the model string of the Motherboard as reported in the Windows registry.
		  
		  #If TargetWin32 Then
		    Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		    Return reg.Child("BIOS").Value("BaseBoardProduct")
		  #endif
		  
		Exception err As RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MotherboardModelRevision() As String
		  //Returns the model revision string of the Motherboard as reported in the Windows registry.
		  
		  #If TargetWin32 Then
		    Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		    Return reg.Child("BIOS").Value("BaseBoardVersion")
		  #endif
		  
		Exception err As RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MouseButtonCount() As Integer
		  //Returns the number of mouse buttons
		  Return GetMetric(43)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NTPowerInfoHelper(InfoLevel As Integer) As PROCESSOR_POWER_INFORMATION()
		  Declare Function CallNtPowerInformation Lib "PowrProf" (infoLevel As Integer, InputBuffer As Ptr, _
		  buffSize As Integer, OutputBuffer As Ptr, outbufferSize As Integer) As Integer
		  
		  Dim info As New MemoryBlock(24 * NumberOfProcessors)
		  Call CallNtPowerInformation(InfoLevel, Nil, 0, info, info.Size)
		  
		  Dim ret() As PROCESSOR_POWER_INFORMATION
		  For i As Integer = 0 To info.Size - 24 Step 24
		    Dim ppi As PROCESSOR_POWER_INFORMATION
		    ppi.ProcessorNumber = info.UInt32Value(i)
		    ppi.MaxMhz = info.UInt32Value(i + 4)
		    ppi.CurrentMhz = info.UInt32Value(i + 8)
		    ppi.MhzLimit = info.UInt32Value(i + 12)
		    ppi.MaxIdleState = info.UInt32Value(i + 16)
		    ppi.CurrentIdleState = info.UInt32Value(i + 20)
		    ret.Append(ppi)
		  Next
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NumberOfProcessors() As Integer
		  //Returns the number of LOGICAL processor cores. e.g. a quad core processor with hyperthreading will have 8 logical cores.
		  
		  #If TargetWin32 Then
		    Declare Sub GetSystemInfo Lib "Kernel32" (ByRef info As SYSTEM_INFO)
		    
		    Dim info As SYSTEM_INFO
		    GetSystemInfo(info)
		    
		    Return info.numberOfProcessors
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OEM() As String
		  //Returns the OEM manufacturer's name as recorded in the OEMINFO.INI file, if any.
		  
		  Dim f As FolderItem = SpecialFolder.System.Child("OEMINFO.INI")
		  If f <> Nil Then
		    If f.Exists Then
		      Dim tis As TextInputStream
		      tis = tis.Open(f)
		      While Not tis.EOF
		        Dim line As String = tis.ReadLine
		        If NthField(line, "=", 1) = "Manufacturer" Then
		          Return NthField(line, "=", 2)
		        End If
		      Wend
		    End If
		  End If
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OSArchitecture() As Integer
		  //Returns 64 if the current operating system is a 64 bit build, 32 for 32 bit build, -1 on error or unknown architecture.
		  //This function assumes that the application itself is a 32 bit executable. Therefore, if REALSoftware one day releases a 64 bit
		  //capable compiler then the results of this function will become unreliable and I will be immensely pleased.
		  
		  #If TargetWin32 Then
		    Declare Function OpenProcess Lib "Kernel32" (ByVal dwDesiredAccessAs As Integer, ByVal bInheritHandle As Integer, _
		    ByVal dwProcId As Integer) As Integer
		    Declare Function IsWow64Process Lib "Kernel32" (handle As Integer, ByRef is64 As Boolean) As Boolean
		    Dim pHandle As Integer = OpenProcess(PROCESS_QUERY_INFORMATION, 0, CurrentProcess)
		    
		    Dim is64 As Boolean
		    If IsWow64Process(pHandle, is64) Then
		      If is64 Then
		        Return 64
		      Else
		        Return 32
		      End If
		    Else
		      Return -1
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ProcessorName() As String
		  //Returns the name of the processor recorded in the registry. e.g. "Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz"
		  
		  #If TargetWin32 Then
		    Dim reg As New RegistryItem("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\", False)
		    Return reg.Child("CentralProcessor").Child("0").Value("ProcessorNameString")
		  #endif
		  
		Exception RegistryAccessErrorException
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PublicIP() As String
		  //Returns the public IP address of the computer.
		  //NOTICE: This function makes direct contact with a script hosted on boredomsoft.org and I DO log it.
		  //You can host your own version of the script on pretty much any PHP-capable server as it's very simple.
		  //Here is the PHP script used on my server:
		  //
		  '<?php
		  '$ip = $_SERVER['REMOTE_ADDR'];
		  'header("X-Client: " . $ip . "");
		  //
		  //I do NOT guarentee that the script on my server will continue to be available for any length of time.
		  
		  Dim h As New HTTPSocket
		  Call h.Get("http://www.boredomsoft.org/ip.php", 10)
		  Try
		    Return h.PageHeaders.Value("X-Client")
		  Catch
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Reboot()
		  //Reboots the computer
		  
		  Call ExitWindows(EWX_REBOOT)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScreenCount() As Integer
		  //Returns the number of screens/monitors used on the current desktop.
		  Return GetMetric(80)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScreenHeight() As Integer
		  //Returns the height of the main screen, in pixels
		  Return GetMetric(1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScreenVirtualHeight() As Integer
		  //Returns the height of the bounding rectangle around all monitors. On single-screen systems this is identical to ScreenHeight
		  Return GetMetric(79)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScreenVirtualWidth() As Integer
		  //Returns the width of the bounding rectangle around all monitors. On single-screen systems this is identical to ScreenWidth
		  Return GetMetric(78)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScreenWidth() As Integer
		  //Returns the width of the main screen, in pixels
		  Return GetMetric(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowSounds() As Boolean
		  //True if the user requires an application to present information visually in situations where it would otherwise
		  //present the information only in audible form. i.e. for deaf users.
		  Return GetMetric(70) <> 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShutDown()
		  //Shuts the computer down.
		  Call ExitWindows(EWX_SHUTDOWN)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SystemParametersInfo(action as UInt32, param1 as UInt32, param2 as Ptr, change as UInt32)
		  #If TargetWin32 Then
		    Declare Function SystemParametersInfoW Lib "User32" (action as UInt32, param1 as UInt32, param2 as Ptr, change as UInt32) As Boolean
		    Call SystemParametersInfoW(action, param1, param2, Change )
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Timezone() As String
		  //This function returns a string representing the name of the current time zone. e.g. "EST" or "Pacific Daylight Time." This name
		  //is localized and may be up to 32 characters long.
		  //On error, returns an empty string.
		  
		  #If TargetWin32 Then
		    Declare Function GetTimeZoneInformation Lib "Kernel32" (ByRef TZInfo As TIME_ZONE_INFORMATION) As Integer
		    
		    Const daylightSavingsOn = 2
		    Const daylightSavingsOff = 1
		    Const daylightSavingsUnknown = 0
		    Const invalidTimeZone = &hFFFFFFFF
		    
		    Dim TZInfo As TIME_ZONE_INFORMATION
		    Dim dlsStatus As Integer = GetTimeZoneInformation(TZInfo)
		    
		    If dlsStatus = daylightSavingsOn Or dlsStatus = daylightSavingsOff Or dlsStatus = daylightSavingsUnknown Then
		      Return TZInfo.StandardName
		    Else
		      Return ""
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TotalPageFile() As UInt64
		  //Returns an Unsigned 64 bit Integer representing the number of bytes allocated for all pagefiles.
		  
		  #If TargetWin32 Then Return GlobalMemoryStatus.TotalPageFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TotalPhysicalRAM() As UInt64
		  //Returns an Unsigned 64 bit Integer representing the number of bytes of physical RAM installed.
		  
		  #If TargetWin32 Then Return GlobalMemoryStatus.TotalPhysicalMemory
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TotalProcessAddressSpace() As UInt64
		  //Returns an Unsigned 64 bit Integer representing the number of bytes of virtual address space for
		  //the current process after Windows takes its cut. Since RB is only 32-bit, this will be 2GB 99.8% of the time and 3GB
		  //in rare setups that specify the /3GB switch in the Windows boot parameters.
		  //See also: AvailableProcessAddressSpace
		  
		  #If TargetWin32 Then Return GlobalMemoryStatus.PerProcessAddressSpace
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UACStatus() As Integer
		  Dim ret As Integer
		  #If TargetWin32 Then
		    If System.IsFunctionAvailable("RtlQueryElevationFlags", "NTDLL") Then
		      Soft Declare Function RtlQueryElevationFlags Lib "NTDLL" (ByRef flags As Integer) As Integer
		      Call RtlQueryElevationFlags(ret)
		    End If
		  #endif
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UAC_IsEnabled() As Boolean
		  //Returns True if UAC is enabled.
		  Return BitwiseAnd(UACStatus, &h1) = &h1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UAC_IsSetupDetected() As Boolean
		  //Returns True if Windows will detect and elevate applications with "setup" in their name.
		  Return BitwiseAnd(UACStatus, &h4) = &h4
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UAC_IsVirtualizationEnabled() As Boolean
		  //Returns True if file and registry virtualization is enabled.
		  Return BitwiseAnd(UACStatus, &h2) = &h2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UTCOffset() As Double
		  //This function returns a double representing the number of hours the computer's set timezone is offset from UTC.
		  //Postive Return values indicate timezones ahead of UTC, negative indicates a time zone behind UTC.
		  //On error, returns an impossible offset (-48)
		  
		  #If TargetWin32 Then
		    Declare Function GetTimeZoneInformation Lib "Kernel32" (ByRef TZInfo As TIME_ZONE_INFORMATION) As Integer
		    
		    Const daylightSavingsOn = 2
		    Const daylightSavingsOff = 1
		    Const daylightSavingsUnknown = 0
		    Const invalidTimeZone = &hFFFFFFFF
		    
		    Dim TZInfo As TIME_ZONE_INFORMATION
		    Dim dlsStatus As Integer = GetTimeZoneInformation(TZInfo)
		    
		    If dlsStatus = daylightSavingsOn Or dlsStatus = daylightSavingsOff Or dlsStatus = daylightSavingsUnknown Then
		      Return TZInfo.Bias / 60
		    Else
		      Return -48
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VersionString() As String
		  //Returns a human-readable string corresponding to the version, SKU, service pack, and architecture of
		  //the currently running version of Windows.
		  //e.g. "Windows 7 Ultimate x64 Service Pack 1"
		  
		  #If TargetWin32 Then
		    Declare Function GetVersionExA Lib "Kernel32" (ByRef info As OSVERSIONINFOEX)As Boolean
		    Dim info As OSVERSIONINFOEX
		    info.StructSize = Info.Size
		    
		    If GetVersionExA(info) Then
		      Dim ret As String
		      Select Case info.MajorVersion
		        
		      Case 6
		        If info.MinorVersion = 1 Then
		          If info.ProductType = &h0000003 Then
		            ret = "Windows Server 2008 R2"
		          ElseIf info.ProductType = &h0000001 Then
		            If (BitwiseOr(info.SuiteMask, &h00000200) > 0) Then
		              ret = "Windows 7 Home Premium"
		            ElseIf (BitwiseOr(info.SuiteMask, 1) > 0) Then
		              ret = "Windows 7 Ultimate"
		            ElseIf (BitwiseOr(info.SuiteMask, 6) > 0) Then
		              ret = "Windows 7 Business"
		            ElseIf (BitwiseOr(info.SuiteMask, 4) > 0) Then
		              ret = "Windows 7 Enterprise"
		            ElseIf (BitwiseOr(info.SuiteMask, 2) > 0) Then
		              ret = "Windows 7 Home Basic"
		            ElseIf (BitwiseOr(info.SuiteMask, 11) > 0) Then
		              ret = "Windows 7 Starter"
		            End If
		          End If
		        Else
		          If info.MinorVersion = 2 Then
		            ret = "Windows 8"
		            If info.ProductType = 1 Then ret = ret + " Ultimate"
		            If info.SuiteMask = &h100 Then ret = ret + " (Consumer Preview, build " + Str(info.BuildNumber) + ")"
		          ElseIf info.ProductType = &h0000003 Then
		            If (BitwiseOr(info.SuiteMask, 7) > 0) Or (BitwiseOr(info.SuiteMask, 13) > 0) Then
		              ret = "Windows Server 2008"
		            ElseIf (BitwiseOr(info.SuiteMask, 8) > 0) Or (BitwiseOr(info.SuiteMask, 12) > 0) Then
		              ret = "Windows Server 2008 Datacenter"
		            ElseIf (BitwiseOr(info.SuiteMask, 10) > 0) Or (BitwiseOr(info.SuiteMask, 14) > 0) Then
		              ret = "Windows Server 2008 Enterprise"
		            ElseIf (BitwiseOr(info.SuiteMask, 15) > 0) Then
		              ret = "Windows Server 2008 Webserver"
		            ElseIf (BitwiseOr(info.SuiteMask, 8) > 0) Then
		              ret = "Windows Server 2008 Enterprise IA64"
		            ElseIf (BitwiseOr(info.SuiteMask, 1) > 0) Then
		              ret = "Windows Server 2008 Datacenter"
		            ElseIf info.ProductType = &h0000003 Then
		              ret = "Windows Server 2008 R2"
		            ElseIf (BitwiseOr(info.SuiteMask, &h00000200) > 0) Then
		              ret = "Windows Vista Home Premium"
		            ElseIf (BitwiseOr(info.SuiteMask, 1) > 0) Then
		              ret = "Windows Vista Ultimate"
		            ElseIf (BitwiseOr(info.SuiteMask, 6) > 0) Then
		              ret = "Windows Vista Business"
		            ElseIf (BitwiseOr(info.SuiteMask, 4) > 0) Then
		              ret = "Windows Vista Enterprise"
		            ElseIf (BitwiseOr(info.SuiteMask, 2) > 0) Then
		              ret = "Windows Vista Home Basic"
		            ElseIf (BitwiseOr(info.SuiteMask, 11) > 0) Then
		              ret = "Windows Vista Starter"
		            End If
		          End If
		        End If
		        
		      Case 5
		        Select Case info.MinorVersion
		        Case 2
		          If info.ProductType = &h0000001 Then
		            ret = "Windows XP Professional x64 Edition"
		          Else
		            ret = "Windows Server 2003"
		          End If
		        Case 1
		          If info.SuiteMask = &h00000200 Then
		            ret = "Windows XP Home Edition"
		          Else
		            ret = "Windows XP Professional Edition"
		          End If
		        End Select
		        
		      Case 4
		        If info.MinorVersion = 0 Then
		          ret = "Windows 95 or Windows NT 4.0"
		        ElseIf info.MinorVersion = 10 Then
		          ret = "Windows 98"
		        ElseIf info.MinorVersion = 90 Then
		          ret = "Windows ME"
		        End If
		      Else
		        ret = "Unknown Windows"
		      End Select
		      
		      Select Case CPUArchitecture
		      Case PROCESSOR_ARCHITECTURE_AMD64
		        ret = ret + " x64"
		      Case PROCESSOR_ARCHITECTURE_IA64
		        ret = ret + " Itanium"
		      Case PROCESSOR_ARCHITECTURE_INTEL
		        ret = ret + " x86"
		      Else
		        ret = ret + " Unknown CPU Architecture"
		      End Select
		      
		      
		      ret = ret + " " + info.ServicePackName
		      Return ret
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VolumeInfo(volume As FolderItem) As Dictionary
		  //Given a FolderItem, returns a Dictionary containing the properties of the containing volume. On error, returns Nil.
		  
		  #If TargetWin32 Then
		    Declare Function GetVolumeInformationW Lib "Kernel32" (path As WString, volumeName As Ptr, volnameSize As Integer, _
		    volumeSerialNumber As Ptr, ByRef maximumNameLength As Integer, ByRef FSFlags As Integer, filesystem As Ptr, fsNameSize As Integer) As Boolean
		    
		    Dim volumeName As New MemoryBlock(255)
		    Dim fsName As New MemoryBlock(255)
		    Dim drive As String = NthField(volume.AbsolutePath, "\", 1) + "\"
		    Dim serialNumber As New MemoryBlock(255)
		    Dim maxLen, flags As Integer
		    
		    If GetVolumeInformationW(drive, volumeName, volumeName.Size, serialNumber, maxLen, flags, fsName, fsName.Size) Then
		      Dim ret As New Dictionary
		      ret.Value("Filesystem") = fsName.WString(0)
		      ret.Value("Label") = volumeName.WString(0)
		      ret.Value("MaxNameLen") = maxLen
		      ret.Value("Root") = drive
		      ret.Value("Flags") = flags
		      ret.Value("StreamSupport") = BitwiseAnd(flags, &h00040000) = &h00040000
		      ret.Value("ReadOnly") = BitwiseAnd(flags, &h00080000) = &h00080000
		      ret.Value("EFSSupport") = BitwiseAnd(flags, &h00020000) = &h00020000
		      ret.Value("HardLinkSupport") = BitwiseAnd(flags, &h00400000) = &h00400000
		      ret.Value("ReparsePointSupport") = BitwiseAnd(flags, &h00000080) = &h00000080
		      Return ret
		    Else
		      Return Nil
		    End If
		  #endif
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns an integer corresponding to the current boot mode:
			  //0 = Normal boot mode
			  //1 = Safe Mode
			  //2 = Safe Mode with networking.
			  
			  #If TargetWin32 Then Return GetMetric(SM_CLEANBOOT)
			End Get
		#tag EndGetter
		Protected BootMode As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns True if the current process is "system critical"
			  //Always returns false unless you set it to True first.
			  
			  return mBSODIfAppQuits
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  //Sets whether the current process is "system critical"
			  //                                          WARNING!!
			  //Setting this to TRUE will do EXACTLY WHAT THE NAME SAYS. If your process dies, so does Windows.
			  //(Though the user must have lauched your app with Admin rights.)
			  #pragma Unused value
			  #If TargetWin32 Then
			    If EnablePrivilege(SE_DEBUG_PRIVILEGE) Then
			      Declare Function RtlSetProcessIsCritical Lib "NTDLL" (NewStatus As Boolean, ByRef OldStatus As Boolean, needscb As Boolean) As Boolean
			      If RtlSetProcessIsCritical(value, mBSODIfAppQuits, False) Then
			        mBSODIfAppQuits = value
			      End If
			    End If
			  #endif
			End Set
		#tag EndSetter
		Protected BSODIfAppQuits As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns the Kernel build number as an Integer
			  //On error, returns 0
			  
			  #If TargetWin32 Then
			    Declare Function GetVersionExA Lib "Kernel32" (ByRef info As OSVERSIONINFOEX) As Boolean
			    Dim info As OSVERSIONINFOEX
			    info.StructSize = Info.Size
			    
			    If GetVersionExA(info) Then
			      Return info.BuildNumber
			    Else
			      Return 0
			    End If
			  #endif
			End Get
		#tag EndGetter
		Protected BuildNumber As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  #If TargetWin32 Then
			    Declare Function GetCurrentThreadId Lib "Kernel32" () As Integer
			    Return GetCurrentThreadId()
			  #endif
			End Get
		#tag EndGetter
		Protected CurrentThreadID As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Dim mb as new MemoryBlock( 1024 )
			  Const SPI_GETDESKWALLPAPER = &h73
			  SystemParametersInfo(SPI_GETDESKWALLPAPER, mb.Size, mb, 0)
			  Return GetFolderItem(mb.WString(0))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Nil Then Return
			  Const SPI_SETDESKWALLPAPER = &h14
			  Dim mb As New MemoryBlock(2048)
			  Dim wallpaper As String = Value.AbsolutePath
			  mb.WString(0) = wallpaper
			  SystemParametersInfo(SPI_SETDESKWALLPAPER, mb.Size, mb, 0)
			End Set
		#tag EndSetter
		Protected CurrentWallpaper As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns True if the computer is a tablet PC.
			  
			  #If TargetWin32 Then
			    Declare Function IsOS Lib "Shlwapi" (OSFeature As Integer) As Boolean
			    Const OS_SERVER = 23
			    Return IsOS(OS_SERVER)
			  #endif
			End Get
		#tag EndGetter
		Protected IsAServer As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns the Kernel version of Windows as a Double (MajorVersion.MinorVersion)
			  //For example, Windows 2000 returns 5.0, XP Returns 5.1, Vista Returns 6.0 and Windows 7 returns 6.1
			  //On error, returns 0.0
			  
			  #If TargetWin32 Then
			    Declare Function GetVersionExA Lib "Kernel32" (ByRef info As OSVERSIONINFOEX) As Boolean
			    Dim info As OSVERSIONINFOEX
			    info.StructSize = Info.Size
			    
			    If GetVersionExA(info) Then
			      Return info.MajorVersion + (info.MinorVersion / 10)
			    Else
			      Return 0.0
			    End If
			  #endif
			End Get
		#tag EndGetter
		Protected KernelVersion As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns the system default locale name. This is usually something like "en-US" for United States English or
			  //"dv-MV" for Divehi (Maldives). The returned string can be up to 85 (wide) characters long.
			  
			  #If TargetWin32 Then
			    If Platform.IsAtLeast(Platform.WinVista) Then
			      Soft Declare Function GetSystemDefaultLocaleName Lib "Kernel32" (buffer As Ptr, buffSize As Integer) As Integer
			      Dim mb As New MemoryBlock(85)
			      Dim buffSize As Integer = mb.Size
			      buffSize = GetSystemDefaultLocaleName(mb, buffSize)
			      If buffSize > 0 Then
			        Return mb.WString(0)
			      End If
			    End If
			  #endif
			End Get
		#tag EndGetter
		Protected LocaleName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBSODIfAppQuits As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns the service pack number of Windows as a Double (ServicePackMajor.ServicePackMinor)
			  //For example, Windows XP SP0 returns 0.0, XP SP1 Returns 1.0, etc.
			  //On error, returns -0.0
			  
			  #If TargetWin32 Then
			    Declare Function GetVersionExA Lib "Kernel32" (ByRef info As OSVERSIONINFOEX) As Boolean
			    Dim info As OSVERSIONINFOEX
			    info.StructSize = Info.Size
			    
			    If GetVersionExA(info) Then
			      Return info.ServicePackMajor + (info.ServicePackMinor / 10)
			    Else
			      Return -0.0
			    End If
			  #endif
			End Get
		#tag EndGetter
		Protected ServicePack As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //From the WFS. Gets the current volume level (0-65535). Note: on Vista and newer, this method is deprecated and may not
			  //work at all if the sound card implements Protected Path.
			  #If TargetWin32 Then
			    If Platform.IsAtLeast(Platform.WinVista) Then Return 0   //Vista and newer MAY work, but often not.
			    
			    Declare Function mixerOpen Lib "winmm" ( ByRef handle As Integer, id As Integer, _
			    callback As Integer, instance As Integer, open As Integer ) As Integer
			    Declare Function mixerGetNumDevs Lib "winmm" () As Integer
			    Declare Function mixerGetControlDetailsA Lib "winmm" ( handle As Integer, details As Ptr, flags As Integer ) As Integer
			    Declare Sub mixerGetLineInfoA Lib "winmm" ( handle As Integer, line As Ptr, flags As Integer )
			    Declare Sub mixerGetLineControlsA Lib "winmm" ( handle As Integer, lineCtl As Ptr, flags As Integer )
			    
			    Dim i, count As Integer
			    count = mixerGetNumDevs - 1
			    
			    Dim device As Integer
			    for i = 0 to count
			      if mixerOpen( device, i, 0, 0, 0 ) = 0 then
			        exit
			      end
			    next
			    
			    Dim lineThinger As new MemoryBlock( 80 + 40 + 32 + 16 )
			    lineThinger.Long( 0 ) = lineThinger.Size
			    lineThinger.Long( 24 ) = 4
			    mixerGetLineInfoA( device, lineThinger, 3 )
			    Dim otherLineThinger As new MemoryBlock( 24 )
			    Dim mixerControl As new MemoryBlock( 80 + (18 * 4))
			    otherLineThinger.Long( 0 ) = otherLineThinger.Size
			    otherLineThinger.Long( 4 ) = lineThinger.Long( 12 )
			    otherLineThinger.Long( 8 ) = &h50000000 + &h30000 + 1
			    otherLineThinger.Long( 12 ) = 1
			    otherLineThinger.Long( 16 ) = mixerControl.Size
			    otherLineThinger.Ptr( 20 ) = mixerControl
			    mixerGetLineControlsA( device, otherLineThinger, 2 )
			    
			    Dim details As new MemoryBlock( 24 )
			    Dim vals As new MemoryBlock( 4 )
			    
			    details.Long( 0 ) = details.Size
			    details.Long( 4 ) = mixerControl.Long( 4 )
			    details.Long( 8 ) = 1
			    details.Long( 16 ) = 4
			    details.Ptr( 20 ) = vals
			    
			    If mixerGetControlDetailsA( device, details, 0 ) <> 0 Then
			      //Couldn't read the volume
			    End If
			    
			    return vals.Long( 0 )
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  //From the WFS. Sets the current volume level (0-65535). Note: on Vista and newer, this method is deprecated and may not
			  //work at all if the sound card implements Protected Path.
			  
			  #If TargetWin32 Then
			    If Platform.IsAtLeast(Platform.WinVista) Then Return   //Vista and newer MAY work, but often not.
			    
			    Declare Function mixerOpen Lib "winmm" ( ByRef handle As Integer, id As Integer, _
			    callback As Integer, instance As Integer, open As Integer ) As Integer
			    Declare Function mixerGetNumDevs Lib "winmm" () As Integer
			    Declare Function mixerSetControlDetails Lib "winmm" ( handle As Integer, details As Ptr, flags As Integer ) As Integer
			    Declare Sub mixerGetLineInfoA Lib "winmm" ( handle As Integer, line As Ptr, flags As Integer )
			    Declare Sub mixerGetLineControlsA Lib "winmm" ( handle As Integer, lineCtl As Ptr, flags As Integer )
			    
			    Dim i, count As Integer
			    count = mixerGetNumDevs - 1
			    
			    Dim device As Integer
			    for i = 0 to count
			      if mixerOpen( device, i, 0, 0, 0 ) = 0 then
			        exit
			      end
			    next
			    
			    ' Get the line information for the Speakers
			    Dim lineThinger As new MemoryBlock( 80 + 40 + 32 + 16 )
			    lineThinger.Long( 0 ) = lineThinger.Size
			    lineThinger.Long( 24 ) = 4
			    mixerGetLineInfoA( device, lineThinger, 3 )
			    
			    ' Get the volume control for the speakers
			    Dim otherLineThinger As new MemoryBlock( 24 )
			    Dim mixerControl As new MemoryBlock( 80 + (18 * 4))
			    otherLineThinger.Long( 0 ) = otherLineThinger.Size
			    otherLineThinger.Long( 4 ) = lineThinger.Long( 12 )
			    otherLineThinger.Long( 8 ) = &h50000000 + &h30000 + 1
			    otherLineThinger.Long( 12 ) = 1
			    otherLineThinger.Long( 16 ) = mixerControl.Size
			    otherLineThinger.Ptr( 20 ) = mixerControl
			    mixerGetLineControlsA( device, otherLineThinger, 2 )
			    
			    Dim details As new MemoryBlock( 24 )
			    Dim vals As new MemoryBlock( 4 )
			    vals.Long( 0 ) = value
			    
			    details.Long( 0 ) = details.Size
			    details.Long( 4 ) = mixerControl.Long( 4 )
			    details.Long( 8 ) = 1
			    details.Long( 16 ) = 4
			    details.Ptr( 20 ) = vals
			    
			    If mixerSetControlDetails( device, details, 0 ) <> 0 Then
			      //Couldn't set the volume
			    End If
			  #endif
			End Set
		#tag EndSetter
		Protected SoundVolume As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //Returns True if the computer is a tablet PC.
			  
			  #If TargetWin32 Then
			    Declare Function IsOS Lib "Shlwapi" (OSFeature As Integer) As Boolean
			    Const OS_TABLETPC = 33
			    Return IsOS(OS_TABLETPC)
			  #endif
			End Get
		#tag EndGetter
		Protected TabletPC As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = PROCESSOR_ARCHITECTURE_AMD64, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROCESSOR_ARCHITECTURE_IA64, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROCESSOR_ARCHITECTURE_INTEL, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROCESSOR_ARCHITECTURE_UNKNOWN, Type = Double, Dynamic = False, Default = \"&hffff", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Win2000, Type = Double, Dynamic = False, Default = \"5.0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Win7, Type = Double, Dynamic = False, Default = \"6.1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Win8, Type = Double, Dynamic = False, Default = \"6.2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WinServer2003, Type = Double, Dynamic = False, Default = \"5.2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WinServer2008, Type = Double, Dynamic = False, Default = \"6.0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WinServer2008r2, Type = Double, Dynamic = False, Default = \"6.1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WinVista, Type = Double, Dynamic = False, Default = \"6.0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WinXP, Type = Double, Dynamic = False, Default = \"5.1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WinXPx64, Type = Double, Dynamic = False, Default = \"5.2", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = CPUUsagePercents, Flags = &h0
		KernelMode As Double
		  UserMode As Double
		Idle As Double
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
