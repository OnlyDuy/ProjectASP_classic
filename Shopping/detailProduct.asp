<!--#include file="../connect.asp"-->

<!DOCTYPE html>
<html lang="en">
    <!--#include file="./header.asp"-->
<body>
    <section style="background-color: #eee;">
        <div class="container pb-3">
            <div class="container py-2 h-100">
                <div class="category-top rows">
                    <a href="./home.asp" class="text-decoration-none text-secondary">
                        <p style="margin: 0px 10px;">Trang chủ</p>
                    </a>
                    <span style="font-size: 10px;
                        margin-top: 5px;">&#8212;</span>
                    <a href="./detailProduct.asp" class="text-decoration-none text-secondary">
                        <p style="margin: 0px 10px;">Chi tiết sản phẩm</p>
                    </a>
                </div>
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                            <%
                                Dim idProduct
                                idProduct = Request.QueryString("idproduct")
                                Dim cmdPrep, rs

                                Set cmdPrep = Server.CreateObject("ADODB.Command")
                                connDB.Open()
                                cmdPrep.ActiveConnection = connDB
                                cmdPrep.CommandType = 1
                               
                                cmdPrep.CommandText = "SELECT * FROM DoAn WHERE MaSP=?"
                                cmdPrep.Parameters(0)=idProduct
                                Set rs = cmdPrep.execute
                                                    
                                'do while not rs.EOF
                            %>
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-6 bg-secondary-subtle d-block">
                                        <div class="p-5">
                                            <div class="product-content-left">
                                                <div class="product-content-left__img">
                                                    <img src="../assest/imgupload/<% = rs("AnhBia")%>" alt="" style="width: 100%;" class="img-fluid rounded-3">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="p-5">
                                            <div class="product-content-right">
                                                <div class="product-content-right__product-name">
                                                    <h3><% =rs("TenSP")%></h3>
                                                </div>
                                                <div class="product-content-right__product-price">
                                                    <p class="text-danger" style="font-size: 20px;">
                                                    <%
                                                        = rs("GiaBan")
                                                    %>  <sup>đ</sup>
                                                    </p>
                                                </div>
                                                <div class="product-content-right__rating">
                                                    <i class="product-content-right__star--gold fa fa-star"></i>
                                                    <i class="product-content-right__star--gold fa fa-star"></i>
                                                    <i class="product-content-right__star--gold fa fa-star"></i>
                                                    <i class="product-content-right__star--gold fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <span class="product-content-right__sold">Đánh giá</span>
                                                </div>
                                                <div class="product-content-right__quatity">
                                                    <p style="font-weight: bold;margin-right: 5px;">Số lượng:</p>
                                                    <input type="number" min="0" value="1"
                                                        class="product-content-right__quatity--input">
                                                </div>
                                                <div class="product-content-right__product-button"
                                                    style="display: flex;">
                                                    <button style="margin-right: 30px;" class="rounded-3">
                                                        <i class="fa fa-shopping-cart"></i>
                                                        <a class="nav-link active" href="./addCart.asp?idproduct=<%= rs("MaSP")%>">
                                                            Thêm vào giỏ
                                                        </a>
                                                        
                                                    </button>
                                                    <!-- <button class="rounded-3">
                                                        <a href="addCart.asp?idproduct=<%= rs("MaSP")%>" class="text-decoration-none" style = "color: #BF8A49;">
                                                            <p style="margin-bottom: 0px;">Thêm vào giỏ</p>
                                                        </a>
                                                    </button> -->
                                                </div>
                                                <div class="product-content-right__describe">
                                                    <div class="product-content-right__describe-top">
                                                        &#8744;
                                                    </div>
                                                    <div class="product-content-right__describe-content">
                                                        <%
                                                            = rs("MoTaChiTiet")
                                                        %>  
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                                rs.MoveNext
                                'loop
                                rs.Close()
                                connDB.Close()
                            %>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>

    <!--#include file="./footer.asp"-->
</body>


</html>