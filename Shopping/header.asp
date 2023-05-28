  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chu</title>
    <link rel="stylesheet" href="../assest/css/basehome.css">
    <link rel="stylesheet" href="../assest/css/bodyhome.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <section class="Header sticky-top" style="background-color: #e3f2fd;">
        <div class="container" >
            <div class="row">
                <div class="col-md py-4">
                    <a href="./home.asp">
                        <img src="../assest/img/DHDs.png" class="img-fluid" alt="logo" style="height: 100px;">
                    </a>
                </div>
                <div class="col-md-4 py-5">
                    <form action="./searchProduct.asp" method="post" accept-charset="UTF-8">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm"  aria-describedby="basic-addon1" name="TenSP" value="<%=TenSP%>">
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </div>
                    </form>
                </div>
            
                <div class="col-md py-5">
                    <button type="button" class="btn btn-outline-success ">
                        <a class="nav-link active" href="./shoppingcart.asp">
                            <strong>Giỏ hàng</strong> <i class="fa-solid fa-cart-shopping"></i>
                        </a>
                    </button>
                </div>
                <div class="col-md-2"> 
                    <div class="row py-5">
                        <div class="col-md-2 py-2"><i class="fa-solid fa-user"></i></div>
                        <div class="col-md-10">
                            <span>Xin chào !<br><strong><%=Session("username")%></strong></span></div>
                    </div>
                </div>
                
                <div class="col">
                    <div class="row py-5">
                        <div class="col-md-2 py-2"><i class="fa-solid fa-right-from-bracket"></i></div>
                        <div class="col-md-10 py-2">
                        <%
                            If (NOT isnull(Session("username"))) AND (TRIM(Session("username"))<>"") Then
                        %>   
                           <a class="nav-link active" href="../logout.asp"><strong>Đăng xuất</strong></a>
                        <%                        
                            Else
                        %>                
                            <a class="nav-link active" href="../login.asp"><strong>Đăng nhập</strong></a>
                        <%
                            End If
                        %>
                            
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="row py-5">
                        <div class="col-md-2 py-2"><i class="fa-solid fa-bars"></i></div>
                        <div class="col-md-10 py-2">
                        
                            <a class="nav-link active" href="#"><strong>Tài khoản</strong></a></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="container">
    <%
        If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
    %>
            <div class="alert alert-success" role="alert">
                <%=Session("Success")%>
            </div>
    <%
            Session.Contents.Remove("Success")
        End If
    %>
    <%
    ' Kiểm tra lỗi
        If (NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
    %>
            <div class="alert alert-danger" role="alert">
                <%=Session("Error")%>
            </div>
    <%
            Session.Contents.Remove("Error")
        End If
    %>
</div>
</body>
</html>