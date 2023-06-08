<!--#include file="../connect.asp"-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Thông tin khách hàng</title>
        <!-- #include file="./header.asp" -->
</head>

    <body>
        <section class="h-100 h-custom" style="background-color: #eee;">
            <div class="container py-2 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                        <%
                            Dim cmdPrep
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            connDB.Open()
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.Prepared = True
                        If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
                            ' Dim idUser
                            ' idUser = Request.QueryString("iduser")
                            ' Dim cmdPrep, rs
    
                            cmdPrep.CommandText = "SELECT HoTen, Email, DiaChi, DienThoai, GioiTinh, NgaySinh FROM NguoiDung WHERE TaiKhoan = '"&Session("username")&"'"
                            ' cmdPrep.Parameters(0) = idUser
                            Set rs = cmdPrep.execute 
                            ' Else If Not rs.EOF Then
                            '     Dim name, email, address, phonenumber, gender, birthday
                            '     name = rs("HoTen")
                            '     email = rs("Email")
                            '     address = rs("DiaChi")
                            '     phonenumber = rs("DienThoai")
                            '     gender= rs("GioiTinh")
                            '     birthday = rs("NgaySinh")
                            ' End If
                        Else
                            updatedName=Request.Form("name") 
                            updatedAddress=Request.Form("address") 
                            updatedGender=Request.Form("gender")
                            updatedBirthday=Request.Form("birthday") ' Cập nhật dữ liệu vào SQL Server
                            If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

                                cmdPrep.CommandText = "UPDATE NguoiDung SET HoTen='" & updatedName & "', DiaChi='" & updatedAddress & "', GioiTinh='" & updatedGender & "', NgaySinh='" & updatedBirthday & "' WHERE TaiKhoan= '"&Session("username")&"'"

                                cmdPrep.execute
                                Session("Success")="Thông tin khách hàng đã được sửa"
                                Response.Redirect "./user.asp"
                            End If
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
                                                <a class="nav-link active" href="./chang_pass.asp">
                                                    <strong>Đặt Lại Mật Khẩu</strong>
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
                                                <h2 class="fw-bold mb-0 text-primary">Thông tin khách hàng</h2>
                                            </div>
                                            <form action="user.asp" id="user_form" method="POST">
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="name"><b>Họ Và Tên</b></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" id="name" name="name" value="<% =rs("HoTen")%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="email"><b>Email</b></label>
                                                        <div class="col-sm-10 ">
                                                            <span class="form-control" id="email" name="email" disabled>
                                                                <% =rs("Email")%>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="address"><b>Địa Chỉ</b></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" id="address" name="address" value="<% =rs("DiaChi")%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="phonenumber"><b>SĐT</b></label>
                                                        <div class="col-sm-10">
                                                            <span class="form-control" id="phonenumber" name="phonenumber" disabled>
                                                                <% =rs("DienThoai")%>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="gender"><b>Giới Tính</b></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" id="gender" name="gender" value="<% =rs("GioiTinh")%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="birthday"><b>Ngày Sinh</b></label>
                                                        <div class="col-sm-10">
                                                            <input type="date" class="form-control" id="birthday" name="birthday" value="<% =rs("NgaySinh")%>">
                                                        </div>
                                                    </div>
                                                    <hr class="my-4">
                                                    <button type="submit" class="btn btn-outline-success ">
                                                        <a class="nav-link active" href="./user.asp">
                                                            <strong>Cập nhật thông tin</strong>
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
            </div>
        </section>
    </body>

    </html>