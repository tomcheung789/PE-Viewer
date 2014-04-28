#Include Once "PEInfo.bi"
#Include Once "md5.bi"

Type Basic_Sections_Info
	sName As String
	PointerToRawData As ULong
	SizeOfRawData As ULong
End Type

Type PEView
	Public:
	Declare Constructor()
   Declare Destructor()
   ' 1 = true , 0 = false
   Declare Function ViewFile(ByVal FilePath As String) As Integer
   'Private:
   Dim PEid As PEInfo Ptr
   ' Engine need the following informations of PE file
   Dim Win As Byte
   Dim EntryPoint As ULong
   Dim NumberOfSections As UShort
   Dim SectionsTable As Basic_Sections_Info Ptr
End Type
