#Include Once "uBin.bi"
#Include Once "uConvert.bi"
#Include Once "md5.bi"

Type uPE
	Public:
   Declare Constructor()
   Declare Destructor()
   Declare Sub UpdatePEBytes(bytes() As UByte)
   
   Dim As Integer FileOffsetValid, PEValid
   Dim As Integer FileOffset, PEIndex, NumberOfSection, EntryPoint, EntryPointVA, EPSection
   Const As Integer MaxSections = 50
   Dim As String SectionNames(0 To MaxSections), Sum(0 To MaxSections)
   Dim As Integer SectionVAOffset(0 To MaxSections), SectionVASizes(0 To MaxSections), SectionRDOffset(0 To MaxSections), SectionRDSizes(0 To MaxSections)
   Private:
   Dim md As md5
   Dim bina As uBin
   Dim conv As uConvert
   Declare Sub GenPEValid(bytes() As UByte)
   Declare Sub GenCommom(bytes() As UByte)
   Declare Sub GenFileOffsetValid(bytes() As UByte)
   Declare Sub GenFileOffset(bytes() As UByte)
   Declare Sub GenSectionTable(bytes() As UByte)
   Declare Function GettingConvert(bytes() As UByte, ByVal start As Integer, ByVal length As Integer) As Integer
End Type
