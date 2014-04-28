#Include Once "uPE.bi"
#Include Once "uBin.bi"
#Include Once "uFile.bi"
#Include "PEView.bi"
On Error GoTo errorhandler


Dim pe As uPE
Dim b As uBin
Dim f As uFile
Dim pv As PEView

ReDim u() As UByte
f.ReadFileBytes(Command(1),u())
pe.UpdatePEBytes(u())

Print "File: ";Command(1)
   'Dim As String SectionNames(0 To MaxSections)
   'Dim As Integer SectionVAOffset(0 To MaxSections), SectionVASizes(0 To MaxSections), SectionRDOffset(0 To MaxSections), SectionRDSizes(0 To MaxSections)
Print "PEValid: ";pe.PEValid
Print "PEIndex: ";Hex(pe.PEIndex)
Print "FileOffsetValid: ";pe.FileOffsetValid
Print "FileOffset: ";Hex(pe.FileOffset)
Print "EntryPoint: ";Hex(pe.EntryPoint)
Print "EntryPointVA: ";Hex(pe.EntryPointVA)
Print "NumberOfSection: ";pe.NumberOfSection
Print "EPSection: ";pe.SectionNames(pe.EPSection)
Print

For i As Integer=0 To pe.NumberOfSection-1
	Print "SectionNames: ";pe.SectionNames(i)
	Print "VAOffset: ";Hex(pe.SectionVAOffset(i))
	Print "VASizes: ";Hex(pe.SectionVASizes(i))
	Print "RDOffset: ";Hex(pe.SectionRDOffset(i))
	Print "RDSizes: ";Hex(pe.SectionRDSizes(i))
	Print "MD5: ";pe.sum(i)
	Print 
Next

pv.ViewFile(Command(1))
Print pv.win
Print Hex(pv.EntryPoint)
   For i As Integer = 0 To pv.NumberOfSections - 1
   	Print pv.SectionsTable[i].sName
   	Print Hex(pv.SectionsTable[i].PointerToRawData)
   	Print Hex(pv.SectionsTable[i].SizeOfRawData)
   Next

errorhandler:
Print "Error #"; Err; "!"

Sleep
