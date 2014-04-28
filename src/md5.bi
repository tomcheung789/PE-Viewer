#include once "crt.bi"

Type MD5Context
	buf(0 to 3) as unsigned integer
	bits(0 to 1) as unsigned integer
	in(0 to 63) as ubyte
end Type

Type md5
	Public:
	Dim As Byte o
	Declare Constructor()
   Declare Destructor()
   Declare Function MD5_FromFile(filename As String) As String
Declare Function MD5_FromString(st As String) As String
Declare Function MD5_FromByte(st() As UByte) As String
declare sub MD5Init(byval ctx as MD5Context ptr)
declare sub MD5Update(byval ctx as MD5Context ptr, byval buf as ubyte ptr, byval llen as unsigned integer)
declare sub MD5Final(byval digest as ubyte ptr, byval ctx as MD5Context ptr)
declare sub MD5Transform (byval buf as integer ptr, byval in as integer ptr)
End Type