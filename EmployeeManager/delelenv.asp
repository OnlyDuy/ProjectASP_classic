<!-- #include file="../connect.asp" -->
<%
IDadmin = Request.QueryString("IDadmin")

 Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM Admin WHERE IDadmin=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("IDadmin",3,1, ,IDadmin)

    cmdPrep.execute
    connDB.Close()
    Session("Success") = "Thông tin nhân viên đã xóa"
    
    Response.Redirect("QLNS.asp")
%>