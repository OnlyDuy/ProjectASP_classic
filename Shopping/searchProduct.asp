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
    <title>Products</title>
    <link rel="stylesheet" href="../assest/font/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../assest/css/basehome.css">
    <link rel="stylesheet" href="../assest/css/bodyhome.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body>
<!--#include file="header.asp"-->
    <section style="background-color: #eee;">    
        <div class="container py-3">
        <div class="grid">
            <section id="Slider">
                <div class="aspect-radio-169">
                    <img src="../assest/img/in-banner-quang-cao-do-an-2.jpg" alt="">
                    <img src="../assest/img/in-banner-quang-cao-do-an-7-1.jpg" alt="">
                </div>
                <div class="dot-container">
                    <div class="dot active"></div>
                    <div class="dot"></div>
                </div>
            </section>
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
                                 Dim TenSP,StrSQL
                                If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
                                ' Lấy giá trị từ ô nhập liệu có name là "TenSP"
                                TenSP =Request.Form("TenSP")
                                End If
                                StrSQL="SELECT * FROM DoAn ORDER BY MaSP"
                                If (Not IsNull(TenSP) And Trim(TenSP) <> "")Then
                                StrSQL = "SELECT * FROM DoAn WHERE TenSP LIKE N'%"&TenSP&"%'"
                                End If
                                Set cmdPrep = Server.CreateObject("ADODB.Command")
                         
                                cmdPrep.ActiveConnection = connDB
                                cmdPrep.CommandType = 1
                                cmdPrep.Prepared = True
                                cmdPrep.CommandText = StrSQL
                       
                                Set rs = cmdPrep.execute
                                do while not rs.EOF
                            %>
                            <div class="grid__column-2-4">
                          
                                <a class="home-product-item" href="detailProduct.asp?idproduct=<%= rs("MaSP")%>">
                                    <div class="home-product-item__img" style="background-image: url(../assest/imgupload/<% = rs("AnhBia")%>);"></div>
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
<script language="javascript" src="../assest/js/slider.js">
    
</script>
</html>