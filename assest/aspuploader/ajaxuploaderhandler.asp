<%@ Language="VBScript" %><!-- #include file="include_aspuploader.asp" --><%

Dim uploader,mvcfile
Set uploader=new AspUploader

Set mvcfile=uploader.GetValidatingFile()

If mvcfile.FileName="thisisanotvalidfile" Then
	uploader.WriteValidationError("My custom error : Invalid file name. ")
	Response.End()
End If


uploader.WriteValidationOK()

%>