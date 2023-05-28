<!-- #include file="../connect.asp" -->
<!-- #include file="../assest/aspuploader/include_aspuploader.asp" -->

 <%
	Dim uploader
	Set uploader = new AspUploader
	uploader.MaxSizeKB=10240
	uploader.Name="AnhBia"
	uploader.InsertText="Upload File (Max 10M)"
    uploader.AllowedFileExtensions="*.jpg,*.png,*.gif,*.zip"
    uploader.SaveDirectory="/assest/imgupload"
        
%>

<%
If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        MaSP = Request.QueryString("MaSP")
        If (isnull(MaSP) OR trim(MaSP) = "") then 
            MaSP=0 
        End if
        If (cint(MaSP)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM DoAn WHERE MaSP=?"          
            cmdPrep.Parameters(0)=MaSP
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                TenSP=Result("TenSP")
                GiaBan=Result("GiaBan")
                GioiThieu=Result("GioiThieu")
                MoTaChiTiet=Result("MoTaChiTiet")
                AnhBia=Result("AnhBia")
            End If
            Result.Close()
        End If
Else					
			
        MaSP=Request.QueryString("MaSP")
        TenSP=Request.form("TenSP")
        GiaBan=Request.form("GiaBan")
        GioiThieu=Request.form("GioiThieu")
        MoTaChiTiet=Request.form("MoTaChiTiet")
        AnhBia=Request.form("AnhBia")
        
        dim mvcfile , picture
        Set mvcfile = uploader.GetUploadedFile(Request.Form("AnhBia")) 
        picture = mvcfile.FileName


        if (isnull (MaSP) OR trim(MaSP) = "") then MaSP=0 end if
        if(cint(MaSP=0)) then
               if(NOT isnull(TenSP) and TenSP<>"" and NOT isnull(GiaBan) and GiaBan<>"" and NOT isnull(GioiThieu) and GioiThieu<>"" and NOT isnull(MoTaChiTiet) and MoTaChiTiet<>"" and NOT isnull(AnhBia) and AnhBia<>"")then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO DoAn(TenSP,GiaBan,GioiThieu,MoTaChiTiet,AnhBia) VALUES(?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("TenSP",202,1,255,TenSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("GiaBan",202,1,255,GiaBan)
                cmdPrep.parameters.Append cmdPrep.createParameter("GioiThieu",202,1,255,GioiThieu)
                cmdPrep.parameters.Append cmdPrep.createParameter("MoTaChiTiet",202,1,255,MoTaChiTiet)
                cmdPrep.parameters.Append cmdPrep.createParameter("AnhBia",202,1,255,picture)
                cmdPrep.execute
        
                If Err.Number = 0 Then  
                    Session("Success") = "Đồ ăn mới đã được thêm"                    
                    Response.redirect("./QLSP.asp")  
                Else  
                    handleError(Err.Description)
                    End If
                    On Error GoTo 0
                else
                Session("Error") = "Bạn phải nhập đủ thông tin"             
            end if
        else
        if(NOT isnull(TenSP) and TenSP<>"" and NOT isnull(GiaBan) and GiaBan<>"" and NOT isnull(GioiThieu) and GioiThieu<>"" and NOT isnull(MoTaChiTiet) and MoTaChiTiet<>"" and NOT isnull(AnhBia) and AnhBia<>"")then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "UPDATE DoAn SET TenSP=?, GiaBan=?, GioiThieu=?, MoTaChiTiet=?,AnhBia=?  WHERE MaSP=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("TenSP",202,1,255,TenSP)
            cmdPrep.parameters.Append cmdPrep.createParameter("GiaBan",202,1,255,GiaBan)
            cmdPrep.parameters.Append cmdPrep.createParameter("GioiThieu",202,1,255,GioiThieu)
            cmdPrep.parameters.Append cmdPrep.createParameter("MoTaChiTiet",202,1,255,MoTaChiTiet)
            cmdPrep.parameters.Append cmdPrep.createParameter("AnhBia",202,1,255,picture)
            cmdPrep.parameters.Append cmdPrep.createParameter("MaSP",3,1, ,MaSP)
            cmdPrep.execute

            If Err.Number=0 Then
                Session("Success") = "Đồ ăn đã được sửa thông tin"
                Response.redirect("./QLSP.asp")
            Else
                handleError(Err.Description)
            End If
                On Error Goto 0
            else
        End If
    End if
End if
%>


<html lang="en">
    <head>
   <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
    <!-- #include file="../headerQL.asp" -->
    
    <div class="container py-3">
    <form method=post>
    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="floatingInput" placeholder="Tên sản phẩm" name="TenSP" value="<%=TenSP%>">
        <label for="floatingInput">Tên sản phẩm</label>
    </div>

    <div class="form-floating mb-3">
        <input type="number" class="form-control" id="floatingPassword" placeholder="Giá" name="GiaBan" value="<%=GiaBan%>">
        <label for="floatingPassword">Giá</label>
    </div>

    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="floatingPassword" placeholder="Giới thiệu" name="GioiThieu" value="<%=GioiThieu%>">
        <label for="floatingPassword">Giới thiệu</label>
    </div>

    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="floatingPassword" placeholder="Mô tả chi tiết" name="MoTaChiTiet" value="<%=MoTaChiTiet%>">
        <label for="floatingPassword">Mô tả chi tiết</label>
    </div>
    
    <div class="form-floating mb-3">
   
				<%=uploader.GetString() %>

    </div>
        <button type="submit" class="btn btn-primary">
            <%
                if (MaSP=0) then
                    Response.write("Thêm sản phẩm")
                else
                    Response.write("Sửa thông tin sản phẩm")
                end if
             %>
        </button>
                <a href="QLSP.asp" class="btn btn-info">Quay lại</a> 
    </form>
    </div>
    <!-- #include file="../Shopping/footer.asp" -->
    </body>
</html>
