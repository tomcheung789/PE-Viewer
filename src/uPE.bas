#Include Once "uPE.bi"

Constructor uPE()

End Constructor

Destructor uPE()

End Destructor

Sub uPE.UpdatePEBytes(bytes() As UByte)
	GenCommom(bytes())
	GenPEValid(bytes())
	If PEValid Then
		GenSectionTable(bytes())
		GenFileOffsetValid(bytes())
		If FileOffsetValid Then
			GenFileOffset(bytes())
		EndIf
	EndIf
End Sub


Sub uPE.GenCommom(bytes() As UByte)
	PEIndex=GettingConvert(bytes(), 60, 4)
	NumberOfSection=GettingConvert(bytes(), PEindex + 6, 2)
	EntryPoint=GettingConvert(bytes(), PEindex + 40, 4)
	EntryPointVA=GettingConvert(bytes(), PEindex + 44, 4)
End Sub

Sub uPE.GenPEValid(bytes() As UByte)
	Dim As Integer HaveMZ=0, HavePEHeader=0
	
	Dim MZ(0 To 1) As UByte ={77,90}
	Dim PE00(0 To 3) As UByte ={80, 69, 0, 0}
	ReDim TmpByte() As UByte
	
	bina.LeftByte(bytes(), 2, TmpByte())
	If ( bina.Equals(MZ(),TmpByte()) ) Then
		HaveMZ=1
	EndIf
	
	bina.SubByte(bytes(), PEindex, 4, TmpByte())
	If ( bina.Equals(PE00(),TmpByte()) ) Then
		HavePEHeader=1
	EndIf
	
	If ( HaveMZ And HavePEHeader ) Then
		PEValid= 1
	Else
		PEValid= 0
	EndIf
	
End Sub

Function uPE.GettingConvert(bytes() As UByte, ByVal start As Integer, ByVal length As Integer) As Integer
	ReDim As UByte tempb(),tempb2()
	bina.SubByte(bytes(),Start,length,tempb())
	bina.Reverse(tempb(),tempb2())
	Return CInt(Val("&h" + conv.ByteToHex(tempb2())))
End Function

Sub uPE.GenSectionTable(bytes() As UByte)
	Dim Sindex As Integer = PEindex + 248
	Dim TmpNameByte() As UByte
	Dim TmpName As String
	For i As Integer =0 To NumberOfSection-1
		'GetSectionNames
		bina.SubByte(bytes(), Sindex, 8, TmpNameByte())
		TmpName=""
		For j As Integer=0 To UBound(TmpNameByte)
			TmpName+=Chr(TmpNameByte(j))
		Next
		SectionNames(i)=RTrim(TmpName)
		'end
		
		SectionVASizes(i)=GettingConvert(bytes(), Sindex + 8 , 4)
		SectionVAOffset(i)=GettingConvert(bytes(), Sindex + 8 + 4, 4)
		SectionRDSizes(i)=GettingConvert(bytes(), Sindex + 8 + 4 +4, 4)
		SectionRDOffset(i)=GettingConvert(bytes(), Sindex + 8 + 4 + 4 +4, 4)
		
		bina.SubByte(bytes(), SectionRDOffset(i), SectionRDSizes(i), TmpNameByte())
		Sum(i)=md.MD5_FromByte(TmpNameByte())
		Sindex += 40
	Next
End Sub

Sub uPE.GenFileOffsetValid(bytes() As UByte)
   For i As Integer =0 To NumberOfSection-1
   	If (EntryPointVA = SectionVAOffset(i)) Then
   		If (SectionRDSizes(i) = 0 And EntryPoint >= SectionVAOffset(i)) Then
   			FileOffsetValid = 0
   		Else
   			FileOffsetValid = 1
   		EndIf
   	EndIf
   Next
End Sub

Sub uPE.GenFileOffset(bytes() As UByte)
	For i As Integer =0 To NumberOfSection-1
   	If (EntryPoint >= SectionVAOffset(i)) Then
   		If (NumberOfSection > i + 1) Then
   			If (EntryPoint < SectionVAOffset(i + 1)) Then
   				FileOffset = EntryPoint - SectionVAOffset(i) + SectionRDOffset(i)
   				EPSection=i
               Exit For
   			EndIf
   		Else
   			If (EntryPoint <= SectionVAOffset(i) + SectionVASizes(i)) Then
   				FileOffset = EntryPoint - SectionVAOffset(i) + SectionRDOffset(i)
   				EPSection=i
               Exit For
   			EndIf
   		EndIf
   	EndIf
   Next
End Sub