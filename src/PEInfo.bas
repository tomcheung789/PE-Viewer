#Include Once "PEInfo.bi"

Constructor PEInfo()
	inUse = 0
End Constructor

Destructor PEInfo()
	FreeMem()
End Destructor

Function PEInfo.LoadFile(ByVal FilePath As String) As Integer
	Dim hFile As FILE Ptr
	Dim t_pos As Integer
	' Allocate some memory for the headers
	FreeMem()
	inUse = 1
	DOS_Header = CAllocate(sizeof(IMAGE_DOS_HEADER))
	NT_Headers = CAllocate(sizeof(IMAGE_NT_HEADERS))           ' PE32
	NT_Headers_Plus = CAllocate(sizeof(IMAGE_NT_HEADERS_PLUS)) ' PE32+
	' Open the input file, return false if cannot open
	hFile = fopen(Strptr(FilePath), "rb")
	If hFile = NULL Then
		Return 0
	End If
	
	' Read in the DOS Header
	fread(DOS_Header, 1, sizeof(IMAGE_DOS_HEADER), hFile)
	
	' Seek past DOS header and stub
	fseek(hFile, DOS_Header->e_lfanew, SEEK_SET)
	
	' Save current file position for later (in case PE32+)
	t_pos = ftell(hFile)
	
	' Read NT Headers
	fread(NT_Headers, 1, sizeof(IMAGE_NT_HEADERS), hFile)
	
	' Set other header pointers to correct address
	File_Header = CPtr(IMAGE_FILE_HEADER Ptr, @NT_Headers->FileHeader)
	Optional_Header = CPtr(IMAGE_OPTIONAL_HEADER Ptr, @NT_Headers->OptionalHeader)
	
	' If format is PE32+ then rewind to saved position, and re-read using 
	' the types for PE32+
	If NT_Headers->OptionalHeader.Magic = &H20B Then
		fseek(hFile, t_pos, SEEK_SET)
		fread(NT_Headers_Plus, 1, sizeof(IMAGE_NT_HEADERS_PLUS), hFile)
		File_Header = CPtr(IMAGE_FILE_HEADER Ptr, @NT_Headers_Plus->FileHeader)
		Optional_Header_Plus = CPtr(IMAGE_OPTIONAL_HEADER_PLUS Ptr, @NT_Headers_Plus->OptionalHeader)
	End If
	
	' Allocate memory for the section headers ptr array
	Section_Headers = CAllocate(sizeof(IMAGE_SECTION_HEADER Ptr) * File_Header->NumberOfSections)

	' Allocate memory for each section, and read it in
	For i As Integer = 0 To File_Header->NumberOfSections - 1
		Section_Headers[i] = CAllocate(sizeof(IMAGE_SECTION_HEADER))
		fread(Section_Headers[i], 1, sizeof(IMAGE_SECTION_HEADER), hFile)
	Next i
	
	' Finished reading, close file
	fclose(hFile)
	Return 1
End Function

Sub PEInfo.FreeMem()
	If inUse = 0 Then
		Exit Sub 
	EndIf
	' Clean up
	For i As Integer = 0 To File_Header->NumberOfSections - 1
		DeAllocate(section_headers[i])
	Next i
	DeAllocate(Section_Headers)
	
	DeAllocate(NT_Headers_Plus)
	DeAllocate(NT_Headers)
	DeAllocate(DOS_Header)
	inUse = 0
End Sub

Function PEInfo.Chk_DOS_Sig() As Integer
	' Check DOS sig
	If DOS_Header->e_magic <> IMAGE_DOS_SIGNATURE Then
		Return 0
	End If
	Return 1
End Function

Function PEInfo.Chk_NT_Sig() As Integer
	' Check NT sig
	If NT_Headers->Signature <> IMAGE_NT_SIGNATURE Then
		Return 0
	End If
	Return 1
End Function

Function PEInfo.Chk_PE32_Sig() As Integer
   ' Check the magic is PE32 or PE32+
	If (NT_Headers->OptionalHeader.Magic <> &H10B) And (NT_Headers->OptionalHeader.Magic <> &H20B) Then
		Return 0
	End If
	Return 1
End Function

Function PEInfo.Get_DOS_Header() As IMAGE_DOS_HEADER Ptr
	Return DOS_Header
End Function

Function PEInfo.Get_NT_Headers() As IMAGE_NT_HEADERS Ptr
	Return NT_Headers
End Function

Function PEInfo.Get_NT_Headers_Plus() As IMAGE_NT_HEADERS_PLUS Ptr
	Return NT_Headers_Plus
End Function

Function PEInfo.Get_File_Header() As IMAGE_FILE_HEADER Ptr
	Return File_Header
End Function

Function PEInfo.Get_Optional_Header() As IMAGE_OPTIONAL_HEADER Ptr
	Return Optional_Header
End Function

Function PEInfo.Get_Optional_Header_Plus() As IMAGE_OPTIONAL_HEADER_PLUS Ptr
	Return Optional_Header_Plus
End Function

Function PEInfo.Get_Section_Headers() As IMAGE_SECTION_HEADER Ptr Ptr
	Return Section_Headers
End Function
