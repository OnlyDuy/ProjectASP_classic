<!--#include file="../connect.asp"-->

<%
Dim nameAdmin, passAdmin
nameAdmin = Request.Form("username")
passAdmin = Request.Form("password") 
'Kiểm tra xem đã nhập username và password chưa
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
    If (NOT isnull(nameAdmin) AND NOT isnull(passAdmin) AND TRIM(nameAdmin)<>"" AND TRIM(passAdmin)<>"") Then
        connDB.Open
        Dim rs
        Set rs = connDB.Execute("SELECT UserName, Password FROM Admin WHERE UserName='" & nameAdmin & "' AND Password='" & passAdmin & "'")
        If Not rs.EOF Then
            ' Nếu đúng, chuyển hướng đến trang chính
            Session("nameAdmin")=rs("UserName")
            Session("Success")="Đăng nhập thành công"
            Session("LoggedIn") = True
            Response.Redirect "../EmployeeManager/pageQL.asp"
        Else
            If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
            Response.Write("<script>alert('Tên đăng nhập hoặc mật khẩu không đúng. Vui lòng thử lại!');</script>")
            End If
        End If
        rs.Close
        connDB.Close
    Else
        If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
            Response.Write("<script>alert('Chưa nhập tên đăng nhập hoặc mật khẩu. Vui lòng thử lại!');</script>")
        End if
    End If
End If
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assest/css/lot.css">
    <title>Đăng Nhập</title>
</head>

<body>
    <div class="header">
        <div class="logo">
            <img src="../assest/img/DHDs.png" alt="Logo" onclick="location.href='#'">
        </div>
        <div class="list_header">
            <ul>
                <li>Combo 1 Người</li>
                <li>Combo Nhóm</li>
                <li>Thức Ăn Nhẹ</li>
                <li>Đồ Uống & Tráng Miệng</li>
            </ul>
        </div>
    </div>
    <div class="container">
        <div class="img_ads">
            <img src="../assest/img/in-banner-quang-cao-do-an-7-1.jpg" alt="Salad" onclick="location.href='#'">
        </div>
        <div class="login_fm">
            <form action="" id="login_form" method="post">
                <div class="login_title">Đăng nhập</div>
                <label for="username">Tên Đăng Nhập</label>
                <input type="text" name="username" id="username">
                <label for="password">Mật Khẩu</label>
                <input type="password" name="password" id="password">
                <input type="submit" value="Đăng Nhập" id="login">
            </form>
        </div>
    </div>
    <div class="footer">

    </div>
</body>
</html>