    <section class="Header " style="background-color: antiquewhite;">
        <div class="container">
            <div class="row">
                <div class="col-md-2 py-3 ">
                    <img src="../assest/img/DHDs.png" class="img-fluid" alt="logo" style="height: 100px;">
                </div>
                <div class="col-md-4 py-5"><strong>HỆ THỐNG QUẢN LÝ CỬA HÀNG</strong></div>
                <div class="col-md-3 py-5">
                    <div class="row">
                        <div class="col-md ">
                            <div class="row">
                                <div class="col-md-3 py-1 "><i class="fa-solid fa-people-roof"></i></div>
                                <div class="col-md-8"><strong>Xin chào</strong><br><%=Session("nameAdmin")%></div>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="row">
                                <div class="col-md-3 py-1 "><i class="fa-solid fa-right-from-bracket"></i></div>
                                <div class="col-md-9">
                                    <a class="nav-link active" href="../EmployeeManager/loginManager.asp"><strong>Đăng xuất</strong></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="MyMainMemu bg-info">
        <div class="container">
            <div class="row">
                <div class="col-md-3 text-white py-3">
                    <div class="row">
                        <div class="col-md-1 py-1 "><i class="fa-solid fa-toolbox"></i></div>
                        <div class="col-md-11"><strong>Công cụ quản lý</strong></div>
                    </div>
                </div>
                <div class="col-md-9">
                    <nav class="navbar navbar-expand-lg ">
                        <div class="container-fluid">
                            <a class="navbar-brand d-none" href="#">Navbar</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <li class="nav-item">
                                        <a class="nav-link text-white active" aria-current="page" href="#">Trang chủ</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-white" href="../EmployeeManager/QLNS.asp">Quản lý nhân sự</a>
                                    </li>
                                    <li class="nav-item ">
                                        <a class="nav-link text-white" href="../ProductManagement/QLSP.asp">
                                            Quản lý sản phẩm
                                        </a>
                                    </li>
                                    <li class="nav-item ">
                                        <a class="nav-link text-white" href="../BillManager/bill.asp">
                                            Quản lý đơn hàng
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-white " href="../Statistic/statistic.asp">Thống kê</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </nav>
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