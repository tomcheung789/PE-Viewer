#Include Once "PEView.bi"

Constructor PEView()
	PEid = New PEInfo()
End Constructor

Destructor PEView()
	Delete PEid
	Delete[] SectionsTable
End Destructor

Function PEView.ViewFile(ByVal FilePath As String) As Integer

	Delete[] SectionsTable
	
	If PEid->LoadFile(FilePath) = 0 Then
		Return 0
	EndIf
	' check pe valid
	If PEid->Chk_DOS_Sig() = 0 Then
		Return 0
	EndIf
	If PEid->Chk_NT_Sig() = 0 Then
		Return 0
	EndIf
	If PEid->Chk_PE32_Sig() = 0 Then
		Return 0
	EndIf
	
	' get data pe32  pe32+
	Dim Magic As UShort = PEid->Get_NT_Headers()->OptionalHeader.Magic
	If Magic = &H10B Then
		Win = 32
		EntryPoint = PEid->Get_Optional_Header()->AddressOfEntryPoint
	ElseIf Magic = &H20B Then
		Win = 64
		EntryPoint = PEid->Get_Optional_Header_Plus()->AddressOfEntryPoint
	EndIf
	
	' get Number of section
   NumberOfSections = PEid->Get_File_Header->NumberOfSections
   SectionsTable = New Basic_Sections_Info[NumberOfSections]
   For i As Integer = 0 To NumberOfSections - 1
   	SectionsTable[i].sName = *cptr(Zstring Ptr, @PEid->Get_Section_Headers()[i]->Name(0))
   	SectionsTable[i].PointerToRawData = PEid->Get_Section_Headers()[i]->PointerToRawData
   	SectionsTable[i].SizeOfRawData = PEid->Get_Section_Headers()[i]->SizeOfRawData
   Next
	Return 1
End Function
