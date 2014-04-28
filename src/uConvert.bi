Type uConvert
	Public:
	as integer a
   Declare Constructor()
   Declare Destructor()
   Declare Sub BytePtrToByte(vByte As UByte Ptr, ByVal bLen As Integer, outByte() As UByte)
   Declare Sub HexToByte(ByVal szHex As String, szBin() As UByte)
   Declare Function ByteToHex(vByte() As UByte) As String
   Declare Sub SplitByLine (FBin() As UByte, FStr() As String)
   Declare Sub SplitByChar (ByVal Text As String, ByVal Delim As String = " ", ByVal Count As Long = -1, Ret() As String)
End Type