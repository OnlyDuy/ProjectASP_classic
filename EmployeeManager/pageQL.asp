<!-- #include file="../connect.asp" -->
<%
    ' Kiểm tra xem người dùng đã đăng nhập chưa
    If Not Session("LoggedIn") Then
        ' Nếu người dùng chưa đăng nhập, điều hướng họ đến trang đăng nhập
        Response.Redirect("./loginManager.asp")
    End If
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <title>Trang chủ</title>
    </head>
<body>
      <!--#include file="../headerQL.asp"-->
    <section class="h-custom" style="background-color: #eee;">
            <div class="container py-2">
                <div class="row d-flex justify-content-center align-items-center">
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
                            cmdPrep.CommandText = "SELECT Name, Email, Address, Phone FROM Admin WHERE UserName = '"&Session("nameAdmin")&"'"
                            Set rs = cmdPrep.execute  
                        End If
                        %>
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-4 d-flex align-items-center">
                                        <div class="p-5" style = "margin-left: 60px">
                                            <h3 class="fw-bold mb-5 mt-2 pt-1"><i>Xin Chào Admin,</i><br>
                                                <h3><% =rs("Name")%></h3>
                                            </h3>            
                                            <br>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 border-start">
                                        <div class="p-5" style = "margin-left: 112px">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h2 class="fw-bold mb-0 text-primary">Thông tin Admin</h2>
                                            </div>
                                            <form action="user.asp" id="user_form" method="POST">
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="name"><b>Họ Và Tên</b></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" id="name" name="name" value="<% =rs("Name")%>">
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
                                                            <input type="text" class="form-control" id="address" name="address" value="<% =rs("Address")%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row mb-3">
                                                        <label class="col-sm-2 col-form-label" for="phonenumber"><b>SĐT</b></label>
                                                        <div class="col-sm-10">
                                                            <span class="form-control" id="phonenumber" name="phonenumber" disabled>
                                                                <% =rs("Phone")%>
                                                            </span>
                                                        </div>
                                                    </div>
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
        </section>>
    
</body>
        <!--#include file="../Shopping/footer.asp"-->
</html>