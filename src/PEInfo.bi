#Include Once "windows.bi"
#include Once "crt.bi"

' Defines missing from winnt.bi
#define IMAGE_FILE_MACHINE_ARM       &H1C0
#define IMAGE_FILE_MACHINE_ALPHA64   &H284
#define IMAGE_FILE_MACHINE_IA64      &H200
#define IMAGE_FILE_MACHINE_M68K      &H268
#define IMAGE_FILE_MACHINE_MIPS16    &H266
#define IMAGE_FILE_MACHINE_MIPSFPU   &H366
#define IMAGE_FILE_MACHINE_MIPSFPU16 &H466
#define IMAGE_FILE_MACHINE_SH3       &H1A2
#define IMAGE_FILE_MACHINE_SH4       &H1A6
#define IMAGE_FILE_MACHINE_THUMB     &H1C2

' The following types don't seem to appear in the winnt.bi, probably
' because they are special cases for PE32+ 64bit
Type QWORD As ULongInt

Type IMAGE_OPTIONAL_HEADER_PLUS
	Magic As WORD
	MajorLinkerVersion As Byte
	MinorLinkerVersion As Byte
	SizeOfCode As DWORD
	SizeOfInitializedData As DWORD
	SizeOfUninitializedData As DWORD
	AddressOfEntryPoint As DWORD
	BaseOfCode As DWORD
	ImageBase As QWORD
	SectionAlignment As DWORD
	FileAlignment As DWORD
	MajorOperatingSystemVersion As WORD
	MinorOperatingSystemVersion As WORD
	MajorImageVersion As WORD
	MinorImageVersion As WORD
	MajorSubsystemVersion As WORD
	MinorSubsystemVersion As WORD
	Reserved1 As DWORD
	SizeOfImage As DWORD
	SizeOfHeaders As DWORD
	CheckSum As DWORD
	Subsystem As WORD
	DllCharacteristics As WORD
	SizeOfStackReserve As QWORD
	SizeOfStackCommit As QWORD
	SizeOfHeapReserve As QWORD
	SizeOfHeapCommit As QWORD
	LoaderFlags As DWORD
	NumberOfRvaAndSizes As DWORD
	DataDirectory(0 To 16-1) As IMAGE_DATA_DIRECTORY
End Type

Type IMAGE_NT_HEADERS_PLUS
	Signature As DWORD
	FileHeader As IMAGE_FILE_HEADER
	OptionalHeader As IMAGE_OPTIONAL_HEADER_PLUS
End Type

Type PEInfo
	Public:
	Declare Constructor()
   Declare Destructor()
   ' 1 = true , 0 = false
   Declare Function LoadFile(ByVal FilePath As String) As Integer
   Declare Sub FreeMem()
   Declare Function Chk_DOS_Sig() As Integer
   Declare Function Chk_NT_Sig() As Integer
   Declare Function Chk_PE32_Sig() As Integer
   Declare Function Get_DOS_Header() As IMAGE_DOS_HEADER Ptr
   Declare Function Get_NT_Headers() As IMAGE_NT_HEADERS Ptr
   Declare Function Get_NT_Headers_Plus() As IMAGE_NT_HEADERS_PLUS Ptr
   Declare Function Get_File_Header() As IMAGE_FILE_HEADER Ptr
   Declare Function Get_Optional_Header() As IMAGE_OPTIONAL_HEADER Ptr
   Declare Function Get_Optional_Header_Plus() As IMAGE_OPTIONAL_HEADER_PLUS Ptr
   Declare Function Get_Section_Headers() As IMAGE_SECTION_HEADER Ptr Ptr
   Private:
	Dim DOS_Header           As IMAGE_DOS_HEADER Ptr
	Dim NT_Headers           As IMAGE_NT_HEADERS Ptr
	Dim NT_Headers_Plus      As IMAGE_NT_HEADERS_PLUS Ptr
	Dim File_Header          As IMAGE_FILE_HEADER Ptr
	Dim Optional_Header      As IMAGE_OPTIONAL_HEADER Ptr
	Dim Optional_Header_Plus As IMAGE_OPTIONAL_HEADER_PLUS Ptr
	Dim Section_Headers      As IMAGE_SECTION_HEADER Ptr Ptr
	Dim inUse As Integer
End Type
