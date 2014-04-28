Type uBin
	Public:
	Dim as integer a
   Declare Constructor()
   Declare Destructor()
   Declare Function IndexOf(bytes() As UByte, findbytes() As UByte, ByVal Start As Integer)As Integer
   Declare Sub SubByte(bytes() As UByte, ByVal Start As Integer, ByVal length As Integer, OutBytes() As UByte)
   Declare Sub LeftByte(bytes() As UByte, ByVal length As Integer, OutBytes() As UByte)
   Declare Sub RightByte(bytes() As UByte, ByVal length As Integer, OutBytes() As UByte)
   Declare Function Equals(bytes() As UByte, bytes2() As UByte)As Integer
   Declare Sub Reverse(bytes() As UByte, OutBytes() As UByte)
End Type