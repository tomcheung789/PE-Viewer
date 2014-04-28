#Include Once "uConvert.bi"

Constructor uConvert()
End Constructor

Destructor uConvert()
End Destructor

Sub uConvert.BytePtrToByte(vByte As UByte Ptr, ByVal bLen As Integer, outByte() As UByte)
	On Local Error GoTo catch
	ReDim outByte(bLen-1)
	If (bLen<=0) Then
		GoTo catch
	EndIf
	For i As Integer =0 To bLen-1
		outByte(i)=vByte[i]
	Next
	Exit Sub
	catch:
	ReDim outByte(0)
End Sub

Sub uConvert.HexToByte(ByVal szHex As String, szBin() As UByte)
	On Local Error GoTo catch
	Dim ndx As Integer
	Dim As Integer iLen = Len(szHex)
	If (iLen <= 0 Or 0 <> iLen Mod 2) Then
		Exit Sub
	EndIf
	ReDim szBin(iLen / 2 -1)
	For i As Integer= 1 To iLen Step 2
        szBin(ndx) = Val("&h" + Mid(szHex, i, 2))
        ndx = ndx + 1
	Next
	Exit Sub
	catch:
	ReDim szBin(0)
End Sub

Function uConvert.ByteToHex(vByte() As UByte) As String
	On Local Error GoTo catch
	Dim HexStr As String
	Dim As Integer iLen = UBound(vByte)-LBound(vByte)+1
	For i As Integer =0 To iLen-1
		If (vByte(i)<16) Then
			HexStr=HexStr+"0"
		EndIf
		HexStr=HexStr+Hex(vByte(i))
	Next
	catch:
	Return HexStr
End Function

Sub uConvert.SplitByLine (FBin() As UByte, FStr() As String)
	On Local Error GoTo catch
	Dim i As Integer
	Dim j As Integer =0
	For i =0 To UBound(FBin)-LBound(FBin)
		If (fbin(i)=13 And fbin(i+1)=10)Then
			j=j+1
			i=i+1
		EndIf
	Next
	Dim l As Integer =0
	If (j>0)Then
		ReDim Fstr(j)
		For i =0 To UBound(FBin)-LBound(FBin)
			If (fbin(i)=13 And fbin(i+1)=10)Then
				l=l+1
				i=i+1
			Else
				fstr(l)=fstr(l)+Chr(fbin(i))
			EndIf
		Next
	EndIf
	Exit Sub 
	catch:
	ReDim Fstr(0)
End Sub

Sub uConvert.SplitByChar (ByVal Text As String, ByVal Delim As String = " ", ByVal Count As Long = -1, Ret() As String)
	On Local Error GoTo catch
	Dim As Long x, p
	If Count < 1 Then
		Do
			x = Instr(x + 1, Text, Delim)
			p += 1
		Loop Until x = 0
		Count = p - 1
	Elseif Count = 1 Then
		Redim Ret(Count - 1)
		Ret(0) = Text
	Else
		Count -= 1
   End If
   Dim RetVal(Count) As Long
   x = 0
   p = 0
   Do Until p = Count
   	x = Instr(x + 1,Text,Delim)
      RetVal(p) = x
      p += 1
   Loop
   Redim Ret(Count)
   Ret(0) = Left(Text, RetVal(0) - 1 )
   p = 1
   Do Until p = Count
   	Ret(p) = Mid(Text, RetVal(p - 1) + 1, RetVal(p) - RetVal(p - 1) - 1 )
      p += 1
   Loop
   Ret(Count) = Mid(Text, RetVal(Count - 1) + 1)
   Exit Sub 
   catch:
	ReDim Ret(0)
End Sub