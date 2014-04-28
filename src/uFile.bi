#Include Once "file.bi"

Type uFile
	Public:
   Declare Constructor()
   Declare Destructor()
   Declare Function FileExist (ByVal Path As String) As Integer
   Declare Function FileSizes (ByVal Path As String) As Integer
   Declare Sub ReadFileBytes (ByVal Path As String, FBin() As UByte)
   Declare Sub WriteFileBytes (ByVal Path As String, FBin() As UByte)
   Private:
   Dim as integer filelength
End Type
