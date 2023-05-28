<!-- #include file="../connect.asp" -->

<%
If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        IDadmin = Request.QueryString("IDadmin")
        If (isnull(IDadmin) OR trim(IDadmin) = "") then 
            IDadmin=0 
        End if
        If (cint(IDadmin)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Admin WHERE IDadmin=?"
            
            cmdPrep.Parameters(0)=IDadmin
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                username=Result("Username")
                password=Result("Password")
                name=Result("Name")
                address=Result("Address")
                email=Result("Email")
                phone=Result("Phone")
            End If
            Result.Close()
        End If
Else
        IDadmin=Request.QueryString("IDadmin")
        username=Request.form("username")
        password=Request.form("password")
        name=Request.form("name")
        address=Request.form("address")
        email=Request.form("email")
        phone=Request.form("phone")
if (isnull (IDadmin) OR trim(IDadmin) = "") then IDadmin=0 end if

if(cint(IDadmin=0)) then
   if(NOT isnull(username) and username<>"" and NOT isnull(password) and password<>"" and NOT isnull(name) and name<>"" and NOT isnull(address) and address<>"" and NOT isnull(email) and email<>"" and NOT isnull(phone) and phone<>"")then
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "INSERT INTO Admin(UserName,Password,Name,Address,Email,Phone) VALUES(?,?,?,?,?,?)"
        cmdPrep.parameters.Append cmdPrep.createParameter("username",202,1,255,username)
        cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
        cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
        cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
        cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,255,email)
        cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
        cmdPrep.execute
        If Err.Number = 0 Then  
            Session("Success") = "Nhân viên mới đã được thêm"                    
            Response.redirect("QLNS.asp")   
        Else  
            handleError(Err.Description)
            End If
            On Error GoTo 0
    else
        Session("Error") = "Bạn phải nhập đủ thông tin"
   End If
else
    if(NOT isnull(username) and username<>"" and NOT isnull(password) and password<>"" and NOT isnull(name) and name<>"" and NOT isnull(address) and address<>"" and NOT isnull(email) and email<>"" and NOT isnull(phone) and phone<>"")then
                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Admin SET UserName=?,Password=?,Name=?,Address=?,Email=?,Phone=?  WHERE IDadmin=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("username",202,1,255,username)
                cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
                cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,255,email)
                cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
                cmdPrep.parameters.Append cmdPrep.createParameter("IDadmin",3,1, ,IDadmin)

                cmdPrep.execute

                If Err.Number=0 Then
                    Session("Success") = "Nhân viên đã được sửa thông tin"
                    Response.redirect("QLNS.asp")
                Else
                    handleError(Err.Description)
                End If
                On Error Goto 0
            else
        end if
End If
End if
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body>
    <!-- #include file="../headerQL.asp" -->
    <div class="container py-3">
            <form method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="<%=username%>">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" value="<%=password%>">
                </div> 
                <div class="mb-3">
                    <label for="name" class="form-label">Họ tên</label>
                    <input type="text" class="form-control" name="name" value="<%=name%>">
                </div> 
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" name="address" value="<%=address%>">
                </div> 
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%=email%>" >
                </div> 
                <div class="mb-3">
                    <label for="phone" class="form-label">SĐT</label>
                    <input type="number" class="form-control" id="phone" name="phone" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}" value="<%=phone%>">
                </div> 
                <button type="submit" class="btn btn-primary">
                    <%
                        if (IDadmin=0) then
                            Response.write("Thêm nhân viên")
                        else
                            Response.write("Sửa thông tin nhân viên")
                        end if
                    %>
                </button>
                <a href="QLNS.asp" class="btn btn-info">Quay lại</a>           
            </form>
        </div>
       
          <!--#include file="../Shopping/footer.asp"-->
  </body>
</html>