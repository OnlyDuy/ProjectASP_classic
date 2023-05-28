<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=DUY\SQLEXPRESS;Database=QLDoAnNhanh;User Id=sa;Password=123456789"
connDB.ConnectionString = strConnection
'connDB.Open
%>