<!--#include file="../connect.asp"-->
<%
    'lay ve danh sach product theo id trong my cart
    Dim idList, mycart, totalProduct, subtotal, statusViews, statusButtons, rs
    If (NOT IsEmpty(Session("mycart"))) Then
        statusViews = "d-none"
        statusButtons = "d-block"
        ' true
	    Set mycart = Session("mycart")
	    idList = ""
	    totalProduct=mycart.Count    
	    For Each List In mycart.Keys
		    If (idList="") Then
                ' true
			    idList = List
		    Else
			    idList = idList & "," & List
		    End if                               
	    Next
	    Dim sqlString
	    sqlString = "Select * from DoAn where MaSP IN (" & idList &")"
	    connDB.Open()
	    set rs = connDB.execute(sqlString)
	    calSubtotal(rs)
    Else
        'Session empty
        statusViews = "d-block"
        statusButtons = "d-none"
        totalProduct=0
    End If
    Sub calSubtotal(rs)
    ' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycart.Item(CStr(rs("MaSP")))) * CDbl(CStr(rs("GiaBan")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
    Sub defineItems(v)
        If (v>1) Then
            Response.Write(" Sản phẩm")
        Else
            Response.Write(" Item")
        End If
    End Sub
%>
<!DOCTYPE html>
<html lang="en">
    <title>Giỏ hàng</title>
    <!-- #include file="./header.asp" -->
<body>
    <section class="h-100 h-custom" style="background-color: #eee;">
        <div class="container py-2 h-100">
            <div class="category-top rows">
                <a href="./home.asp" class="text-decoration-none text-secondary">
                    <p style="margin: 0px 10px;">Trang chủ</p>
                </a>
                <span style="font-size: 10px;
                    margin-top: 5px;">&#8212;</span>
                <a href="./shoppingcart.asp" class="text-decoration-none text-secondary">
                    <p style="margin: 0px 10px;">Giỏ hàng</p>
                </a>
            </div>
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12">
                    <div class="card card-registration card-registration-2" style="border-radius: 15px;">
        
                        <div class="card-body p-0">
                            <div class="row g-0">
                                <div class="col-lg-8">
                                    <div class="p-5">
                                        <div class="d-flex justify-content-between align-items-center mb-5">
                                            <h1 class="fw-bold mb-0 text-black">Giỏ hàng</h1>
                                            <h6 class="mb-0 text-muted"><%= totalProduct %> <%call defineItems(totalProduct) %></h6>
                                        </div>
                                        <form action="removecart.asp" method=post>
                                            <hr class="my-4">
                                            <h5 class="mt-3 text-center text-body-secondary <%= statusViews %>">Bạn không có sản phẩm nào được thêm vào giỏ hàng của bạn.</h5>
                                            <%
                                                If (totalProduct<>0) Then
                                                do while not rs.EOF
                                            %>
                                            <div class="row mb-4 d-flex justify-content-between align-items-center">
                                                <div class="col-md-2 col-lg-2 col-xl-2">
                                                    <img
                                                        src="../assest/imgupload/<% = rs("AnhBia")%>"
                                                        class="img-fluid rounded-3" alt="Cotton T-shirt">
                                                </div>
                                                <div class="col-md-3 col-lg-3 col-xl-3">
                                                    <h5 class="text-muted"><b><%=rs("TenSP")%></b></h5>
                                                    <p class="text-black mb-0" style ="font-size: 14px;"><%=rs("GioiThieu")%></p>
                                                </div>
                                                <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                                                    <button class="btn btn-link px-2"
                                                        onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                                                        <i class="fas fa-minus"></i>
                                                    </button>

                                                    <input id="form1" min="0" name="quantity" value="<%
                                                                    Dim id
                                                                    id  = CStr(rs("MaSP"))
                                                                    Response.Write(mycart.Item(id))                                     
                                                                    %>" type="number"
                                                        class="form-control form-control-sm" />

                                                    <button class="btn btn-link px-2"
                                                        onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                                <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                                                    <h6 class="mb-0"><%= rs("GiaBan")%> VNĐ</h6>
                                                </div>
                                                <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                    <a href="removecart.asp?id=<%= rs("MaSP")%>" class="text-muted"><i class="fas fa-times"></i></a>
                                                </div>
                                            </div>

                                            <hr class="my-4">
                                            <%
                                                rs.MoveNext
                                                loop
                                                'phuc vu cho viec update subtotal
                                                rs.MoveFirst
                                                End If
                                            %> 
                
                                            <div class="row pt-2">
                                                <h6 class="mb-0 col-lg-10 pt-3"><a href="./home.asp" class="text-body"><i
                                                    class="fas fa-long-arrow-alt-left me-2"></i>Quay lại để chọn đồ ăn</a></h6>
                                                    <input type="submit" name="update" value="Update" class="btn btn-warning btn-block btn-lg text-white col-lg-2 <%= statusButtons %>"
                                                data-mdb-ripple-color="dark"/>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-lg-4 bg-secondary-subtle <%= statusButtons %>">
                                <%
                                If Session("payment_completed") = False Then
                                    ' Chuyển hướng đến trang thanh toán hoặc hiển thị thông báo lỗi
                                    Session("Error")="Bạn chưa thanh toán"
                                Else
                                    Dim cmdPrep
                                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                                    'connDB.Open()
                                    cmdPrep.ActiveConnection = connDB
                                    cmdPrep.CommandType = 1
                                    cmdPrep.Prepared = True

                                    Madh = Session("madh")
                                    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

                                        Dim item, quantity
                                        Set mycart = Session("mycart")
                                        For Each item In mycart
                                            MaSP = item
                                            quantity = mycart(item)
                                            cmdPrep.CommandText = "SELECT * FROM DoAn WHERE MaSP=?"          
                                            cmdPrep.Parameters(0)=item
                                            Set rs = cmdPrep.execute 

                                            If not rs.EOF then                                         
                                                Session("GiaBan")=rs("GiaBan")
                                                Giaban = Session("GiaBan")
                                            End If

                                            Dim ThanhTien
                                            ThanhTien = Giaban * quantity
                                            cmdPrep.CommandText = "INSERT INTO ChiTietDonHang(MaDH, MaSP, SoLuong, DonGia, ThanhTien) VALUES('" & Madh & "','" & MaSP & "','" & quantity & "','" & Giaban & "','" &ThanhTien & "')"
                                            'cmdPrep.CommandText = "INSERT INTO ChiTietDonHang(MaDH, MaSP, SoLuong, ThanhTien) VALUES('" & Madh & "','" & MaSP & "','" & quantity & "','" &ThanhTien & "')"


                                            cmdPrep.execute
                                        Next
                                        Session("Success")="Đơn hàng đã dược đặt"
                                        Response.Redirect "./shoppingcart.asp"                                      
                                    End If
                                End If        
                                %>
                                    <form action="" method="POST">
                                        <div class="p-5">
                                            <h3 class="fw-bold mb-5 mt-2 pt-1">Tạm tính</h3>
                                            <hr class="my-4">
    
                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="text-uppercase"><%= totalProduct %> <%call defineItems(totalProduct) %></h5>
                                                <div>
                                                <h5 class="text-end">Tổng</h5>
                                                <h5><%= subtotal%> VNĐ</h5>
                                            </div>                   
                                        </div>
    
                                        <hr class="my-4">
    
                                        <div class="d-flex justify-content-between mb-5">
                                            <h5 class="text-uppercase">Thành tiền</h5>
                                            <h5><%= subtotal %> VNĐ</h5>
                                        </div>
                                        <div class="row">
                                            <button type="button" class="btn btn-lg"
                                            data-mdb-ripple-color="dark">
                                                <%
                                                    If (NOT isnull(Session("username"))) AND (TRIM(Session("username"))<>"") Then
                                                %>   
                                                    <a class="btn btn-primary" href="./pay.asp" role="button">Thanh toán</a>
                                                <%                        
                                                    Else
                            
                                                %>                
                                                    <a class="btn btn-primary" href="../login.asp" role="button">Thanh toán</a>
                            
                                                <%
                                                    End If
                                                %>
                                                
                                            </button>
                                
                                        </div>
                                        <hr class="my-4">
                                        <div class="row">
                                            <button type="submit" class="btn btn-success btn-lg"
                                            data-mdb-ripple-color="dark">
                                                Đặt hàng
                                            </button>
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
    </section>

 <!--#include file="./footer.asp"-->
</body>

</html>
