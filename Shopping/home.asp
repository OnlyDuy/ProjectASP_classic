<!--#include file="../connect.asp"-->
<%
    ' code here to retrive the data from product table
    Dim sqlString, rs
    sqlString = "Select * from DoAn"
    connDB.Open()
    set rs = connDB.execute(sqlString)    
%>


<%
    'PHÂN TRANG
' ham lam tron so nguyen (làm tròn lên)
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")
'    Số bản ghi trong 1 trang
    limit = 10

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

'    Vị trí để lấy bản ghi ( từ vị trí nào đến vị trí nào)
    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(MaSP) AS count FROM DoAN"
    'connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang = tổng số dòng / số bản ghi trong 1 trang
    pages = Ceil(totalRows/limit)
%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="../assest/css/basehome.css">
    <link rel="stylesheet" href="../assest/css/bodyhome.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<style>

</style>
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
                        <%
                            If (NOT isnull(Session("username"))) AND (TRIM(Session("username"))<>"") Then
                        %>   
                           <a class="nav-link active" href="./user.asp?<%=Session("username")%>">
                                <strong>Tài khoản</strong>
                            </a>
                        <%                        
                            Else
                            Session("Error")="Bạn chưa đăng nhập"
                        %>                
                            <a class="nav-link active" href="./home.asp"><strong>Tài khoản</strong></a>
                            
                        <%
                            End If
                        %>  
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="Slider111">
        <div class="aspect-radio-169">
            <img src="../assest/img/in-banner-quang-cao-do-an-2.jpg" alt="">
            <img src="../assest/img/in-banner-quang-cao-do-an-7-1.jpg" alt="">
            <img src="../assest/img/in-banner-quang-cao-do-an-10.jpg" alt="">  
        </div>
        <div class="dot-container">
            <div class="dot active"></div>
            <div class="dot"></div>
            <div class="dot"></div>
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
    <section style="background-color: #eee;">    
        <div class="container py-3">
        <div class="grid">
                
                <div class="grid__row app__content">
                    <div class="grid__column-2">
                        <nav class="category">
                        <h3 class="category__heading">
                            <div class="category__heading-icon">
                                <li class="fa fa-list"></li>
                            </div>
                            DANH MỤC
                        </h3>
                        
                        <ul class="category-list">
                            <li class="category-item">
                                <a href="#" class="category-item__link">COMBO 1 NGƯỜI</a>
                            </li>
                            <li class="category-item">
                                <a href="#" class="category-item__link">COMBO NHÓM</a>
                            </li>
                            <li class="category-item category-item--active">
                                <a href="#" class="category-item__link">GÀ RÁN - GÀ QUAY</a>
                            </li>
                            <li class="category-item">
                                <a href="#" class="category-item__link">BURGER - CƠM - MÌ Ý</a>
                            </li>
                            <li class="category-item">
                                <a href="#" class="category-item__link">THỨC ĂN NHẸ</a>
                            </li>
                            <li class="category-item">
                                <a href="#" class="category-item__link">THỨC UỐNG & TRÁNG MIỆNG</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <div class="grid__column-10">
                    <div class="home-filter">
                        <span class="home-filter__label">Sắp xếp theo</span>
                        <button class="home-filter__btn btn btn-light">Phổ biến</button>
                        <button class="home-filter__btn btn btn-danger">Mới nhất</button>
                        <button class="home-filter__btn btn btn-light">Bán chạy</button>
                        
                        <div class="select-input">
                            <span class="select-input__label">Giá</span>
                            
                            <div class="select-input__icon">
                                <i class="fa fa-angle-down"></i>
                            </div>
                            
                            <ul class="select-input__list">
                                <li class="select-input__item">
                                    <a href="" class="select-input__link">Giá: Thấp đến cao</a>
                                </li>
                                <li class="select-input__item">
                                    <a href="" class="select-input__link">Giá: Cao đến thấp</a>
                                </li>
                            </ul>
                        </div>
                        <div class="home-filter__page">
                            <span class="home-filter__page-num">
                                <span class="home-filter__page-current">1</span>/14
                            </span>
                            
                            <div class="home-filter__page-control">
                                <a href="" class="home-filter__page-btn home-filter__page-btn--disabled">
                                    <div class="home-filter__page-icon">
                                        <i class="fa fa-angle-left"></i>
                                    </div>
                                </a>
                                <a href="" class="home-filter__page-btn">
                                    <div class="home-filter__page-icon">
                                        <i class="fa fa-angle-right"></i>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="home-product">
                        <div class="grid__row">
                            <!-- Product item -->
                            <%
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.Prepared = True
                            cmdPrep.CommandText = "SELECT * FROM DoAn ORDER BY MaSP OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                            cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                            cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)
                            
                                Set rs = cmdPrep.execute                          
                                do while not rs.EOF
                                %>
                                <div class="grid__column-2-4">
                                    
                                <a class="home-product-item" href="detailProduct.asp?idproduct=<%= rs("MaSP")%>">
                                    <div class="home-product-item__img" id="selectedImage" style="background-image: url(../assest/imgupload/<% = rs("AnhBia")%>);"></div>
                                    <h4 class="home-product-item__name">
                                        <b style="font-size: 16px;">
                                            <%
                                            = rs("TenSP")
                                            %>  
                                        </b>
                                        <br>
                                        <%
                                        = rs("GioiThieu")
                                        %>
                                    </h4>
                                    <div class="home-product-item__price">
                                        <span class="home-product-item__price-old">₫69.000</span>
                                        <span class="home-product-item__price-current">
                                            <%
                                                = rs("GiaBan")
                                                %>    
                                            </span>
                                        </div>
                                    
                                        <div class="home-product-item__favourite">
                                            <% 
                                            if rs("DoAnMoi") = False then
                                            %>
                                            <i class="fa fa-check"></i>
                                            <span>Mới</span>
                                            <% 
                                            else 
                                            %>
                                            <i class="fa fa-check" style = "display: none;"></i>
                                            <span style = "display: none;">Cũ</span>
                                            <% 
                                            end if 
                                            %>
                                        </div>
                                        
                                        <div class="home-product-item__sale-off">
                                            <span class="home-product-item__sale-off-percent">43%</span>
                                            <span class="home-product-item__sale-off-label">GIẢM</span>
                                    </div>
                                    <div class="d-flex flex-column" style="background-color: var(--white-color)">   
                                        
                                        <a class="btn btn-outline-success" href="./addCart.asp?idproduct=<%= rs("MaSP")%>">
                                            Thêm vào giỏ
                                        </a>
                                        
                                    </div>
                                </a>
                            </div> 
                            <%
                            rs.MoveNext
                            loop
                            rs.Close()
                            connDB.Close()
                            %>     
                        </div>
                    </div>
                    <nav aria-label="Page Navigation">
                        <ul class="pagination pagination-sm justify-content-center my-5">
                            <% if (pages>1) then
                            'kiem tra trang hien tai co >=2
                            if(Clng(page)>=2) then
                            %>
                            <li class="page-item"><a class="page-link" href="home.asp?page=<%=Clng(page)-1%>">Trước</a></li>
                            <%    
                            end if 
                            for i= 1 to pages
                            %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="home.asp?page=<%=i%>"><%=i%></a></li>
                            <% 
                            next
                            if (Clng(page)<pages) then
                            
                            %>
                            <li class="page-item"><a class="page-link" href="home.asp?page=<%=Clng(page)+1%>">Sau</a></li>
                            <%
                            end if    
                            end if
 
                        %>                           
                        </ul>
                    </nav>
                </div>
            </div>
        </div>   

        </div>
    </section>

        <!--#include file="./footer.asp"-->
</body>
<script language="javascript" src="../assest/js/HomeSlider.js">
    
</script>
</html>