<!-- #include file="../connect.asp" -->
<%
MaSP = Request.QueryString("MaSP")

 Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM DoAn WHERE MaSP = ?"
    cmdPrep.parameters.Append cmdPrep.createParameter("MaSP",3,1, ,MaSP)
    cmdPrep.execute
    connDB.Close()
    Session("Success") = "Sản phẩm đã được xóa"
    Response.Redirect("QLSP.asp")
%>