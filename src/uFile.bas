#Include Once "uFile.bi"

Constructor ufile()
End Constructor

Destructor ufile()
End Destructor

Function ufile.FileExist (ByVal Path As String) As Integer
	On Local Error GoTo catch
	Return FileExists(Path)
	catch:
	Return 0
End Function

Function ufile.FileSizes (ByVal Path As String) As Integer
	On Local Error GoTo catch
	Return FileLen(Path)
	catch:
	Return 0
End Function

Sub ufile.ReadFileBytes (ByVal Path As String, FBin() As UByte)
	On Local Error GoTo catch
	Dim fileid As Integer
	fileid = FreeFile()
	filelength = FileSizes(path)
	If (filelength=0) Then
		GoTo catch
	EndIf
	If (Open (path For Binary Access Read As #fileid)=0)Then
		ReDim FBin(filelength-1) As UByte
		Get #fileid,,FBin()
		Close #fileid
	Else
		GoTo catch
	EndIf
	Exit Sub
	catch:
	ReDim FBin(0)
End Sub

Sub ufile.WriteFileBytes (ByVal Path As String, FBin() As UByte)
	On Local Error GoTo catch
	Dim fileid As Integer
	fileid = FreeFile()
	If (Open (path For Binary Access Write As #fileid)=0)Then
		put #fileid,,FBin()
		Close #fileid
	EndIf
	catch:
End Sub


