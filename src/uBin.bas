#Include Once "uBin.bi"

Constructor uBin()

End Constructor

Destructor uBin()

End Destructor

Function uBin.IndexOf(bytes() As UByte, findbytes() As UByte, ByVal Start As Integer)As Integer
	On Local Error GoTo catch
	Dim As Integer bytesLen = UBound(bytes)-LBound(bytes)+1, findbytesLen=UBound(findbytes)-LBound(findbytes)+1
	Dim match As Integer =0
	If (bytesLen)< (Start +findbytesLen) Then
		GoTo catch
	EndIf
	For i As Integer = Start To bytesLen-1
		if (bytes(i) = findbytes(0)) Then
			match = 1
			For j As Integer = 1 To findbytesLen-1
				If (i + j > bytesLen-1) Then
					match =0
					Exit For
				EndIf
				If (bytes(i+j)<>findbytes(j)) Then
					match =0
					Exit For
				EndIf
			Next
			If (match) Then
				return i
			EndIf
		EndIf
	Next
	catch:
	return -1
End Function

Sub uBin.SubByte(bytes() As UByte, ByVal Start As Integer, ByVal length As Integer, OutBytes() As UByte)
	On Local Error GoTo catch
	Dim As Integer bytesLen = UBound(bytes)-LBound(bytes)+1
	if ( Start < 0 Or length <= 0) Then
		GoTo catch
	EndIf
	If (bytesLen < (Start + length)) Then
		GoTo catch
	EndIf
	ReDim OutBytes(length-1)
	For i As Integer=0 To length-1
		OutBytes(i)=bytes(Start +i)
	Next
	Exit Sub
	catch:
	ReDim OutBytes(0)
End Sub

Sub uBin.LeftByte(bytes() As UByte, ByVal length As Integer, OutBytes() As UByte)
	On Local Error GoTo catch
	Dim As Integer bytesLen = UBound(bytes)-LBound(bytes)+1
	If (bytesLen<length) Then
		GoTo catch
	EndIf
	ReDim OutBytes(length-1)
	For i As Integer =0 To length-1
		OutBytes(i)=bytes(i)
	Next
	Exit Sub
	catch:
	ReDim OutBytes(0)
End Sub

Sub uBin.RightByte(bytes() As UByte, ByVal length As Integer, OutBytes() As UByte)
	On Local Error GoTo catch
	Dim As Integer bytesLen = UBound(bytes)-LBound(bytes)+1, index
	If (bytesLen<length) Then
		GoTo catch
	EndIf
	ReDim OutBytes(length-1)
	index = bytesLen - length
	For i As Integer =0 To length-1
		OutBytes(i)=bytes(index)
		index+=1
	Next
	Exit Sub
	catch:
	ReDim OutBytes(0)
End Sub

Function uBin.Equals(bytes() As UByte, bytes2() As UByte)As Integer
	On Local Error GoTo catch
	Dim As Integer bytesLen = UBound(bytes)-LBound(bytes)+1, bytesLen2 = UBound(bytes2)-LBound(bytes2)+1
	If (bytesLen <> bytesLen2) Then
		GoTo catch
	EndIf
	For i As Integer =0 To bytesLen-1
		If (bytes(i)<>bytes2(i)) Then
			GoTo catch
		EndIf
	Next
	Return 1
	catch:
	Return 0
End Function

Sub uBin.Reverse(bytes() As UByte, OutBytes() As UByte)
	On Local Error GoTo catch
	Dim As Integer bytesLen = UBound(bytes)-LBound(bytes)+1
	ReDim OutBytes(bytesLen-1)
	For i As Integer =0 To bytesLen-1
		OutBytes(i)=bytes(bytesLen-i-1)
	Next
	Exit Sub
	catch:
	ReDim OutBytes(0)
End Sub