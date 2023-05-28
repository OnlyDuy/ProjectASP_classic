<!--#include file="../connect.asp"-->

<!DOCTYPE html>
<html>
<head>
        <title>Thay đổi mật khẩu</title>
            <!-- #include file="./header.asp" -->
</head>

<body>
        <section class="h-100 h-custom" style="background-color: #eee;">
            <div class="container py-2 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                        <%
                            'Lay ten nguoi dung
                            Dim cmdPrep
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            connDB.Open()
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.Prepared = True
    
                            If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
                                cmdPrep.CommandText = "SELECT HoTen, MatKhau FROM NguoiDung WHERE TaiKhoan = '"&Session("username")&"'"
                                Set rs = cmdPrep.execute 

                            Else If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
                                Dim  oldpass, newpass, repnewpass
                                oldpass = Request.Form("oldpass")
                                newpass = Request.Form("newpass")
                                repnewpass = Request.Form("repnewpass")
                                If (isnull(oldpass) or oldpass = ""  or isnull(newpass) or newpass = "" or isnull(repnewpass) or repnewpass = "") Then
                                    Session("Error") = "Hãy nhập mật khẩu mới và xác nhận nó"
                                    Response.Redirect("./chang_pass.asp")
                                Else
                                    'Kiểm tra mật khẩu mới có trùng khớp không
                                    If trim(newpass) <> trim(repnewpass) then
                                        Session("Error") = "Mật khẩu xác thực không khớp"
                                        Response.Redirect("./profile.asp")
                                    Else
                                        cmdPrep.CommandText = "SELECT * FROM NguoiDung WHERE TaiKhoan = '"&Session("username")&"'"
                                        Set rs = cmdPrep.execute 

                                        If not rs.EOF then
                                            Dim passwordcorrect
                                            passwordcorrect = rs("MatKhau")

                                            If Trim(oldpass) <> Trim(passwordcorrect) then
                                                Session("Error") = "Mật khẩu cũ không đúng"
                                                Response.Redirect("./chang_pass.asp")
                                            Else
                                                cmdPrep.commandText = "UPDATE NguoiDung SET MatKhau ='" &newpass& "' where TaiKhoan = '"&Session("username")&"'"            
                                                cmdPrep.execute                                   
                                                Session("Success") = "Thay đổi mật khẩu thành công"
                                                Response.Redirect("./user.asp")
                                            End if
                                        Else
                                            Session("Error") = "Người dùng không tồn tại"
                                            Response.Redirect("./user.asp")
                                        End If
                                    End If       
                                End If
                            End If
                                connDB.Close
                                Set connDB = Nothing
                            End If
                        %>
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-4 d-flex align-items-center">
                                        <div class="p-5" style = "margin-left: 80px">
                                            <h3 class="fw-bold mb-5 mt-2 pt-1"><i>Xin Chào,</i><br>
                                                <h3><% =rs("HoTen")%></h3>
                                            </h3>
                                
                                            <br>
                                            <button type="button" class="btn btn-outline-success ">
                                                <a class="nav-link active" href="./user.asp">
                                                    <strong>Chi tiết tài khoản</strong>
                                                </a>
                                            </button>
                                            <div class="row pt-5">
                                                <h6 class="mb-0 col-lg-10 pt-3"><a href="./home.asp" class="text-body"><i
                                                    class="fas fa-long-arrow-alt-left me-2"></i>Quay lại</a></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 border-start">
                                        <div class="p-5" style = "margin-left: 112px">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h2 class="fw-bold mb-0 text-primary">Đổi mật khẩu</h2>
                                            </div>
                                            <form action="chang_pass.asp" id="password_form" method="POST">    
                                                <div class="mb-3">
                                                    <label for="exampleInputPassword1" for="password" class="form-label"><b>Mật Khẩu Cũ</b></label>                                                     
                                                    <input type="password" class="form-control" id="oldpass" name="oldpass">                                                       
                                                </div>
                                                <div class="mb-3">
                                                    <label for="exampleInputPassword1" for="password" class="form-label"><b>Mật Khẩu Mới</b></label>                                                       
                                                    <input type="password" class="form-control" id="newpass" name="newpass">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="exampleInputPassword1" for="password" class="form-label"><b>Xác Nhận Mật Khẩu Mới</b></label>
                                                    <input type="password" class="form-control" id="repnewpass" name="repnewpass">
                                                </div>
                                                    
                                                <hr class="my-4">
                                                <button type="submit" class="btn btn-outline-success ">
                                                    <a class="nav-link active" href="./chang_pass.asp">
                                                        <strong>Đổi Mật Khẩu</strong>
                                                    </a>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

</body>

</html>