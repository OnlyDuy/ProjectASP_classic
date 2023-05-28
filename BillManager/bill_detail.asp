<!--#include file="../connect.asp"-->
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Bills</title>

        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="./assest/font/font-awesome-4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

        <style>
            #bill_detail{
                color: green;
                background-color: white;
            }
            #bill_detail:hover{
                color: white;
                background-color: green;
            }
        </style>
    </head>
    <body>
        <!--#include file="../headerQL.asp"-->
        <div class="container">
            <br>
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Chi tiết hóa đơn</h2></div>
            </div>
            <div class="table_responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Tên Sản Phẩm</th>
                            <th scope="col">Đơn Giá</th>
                            <th scope="col">Số Lượng</th>
                            <th scope="col">Thành Tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            MaDH = Request.QueryString("MaDH")
                            sql1 = "SELECT DISTINCT MaSP FROM ChiTietDonHang WHERE MaDH = "& MaDH &""
                            connDB.Open
                            Set rs1 = connDB.Execute(sql1)
                            do while not rs1.EOF
                        %>
                            <%
                                sql2 = "SELECT TenSP, GiaBan, SoLuong, ThanhTien FROM DoAn INNER JOIN ChiTietDonHang ON DoAn.MaSP = ChiTietDonHang.MaSP WHERE ChiTietDonHang.MaSP = "& rs1("MaSP") &" AND MaDH = "& MaDH &""
                                Set rs2 = connDB.Execute(sql2)
                                do while not rs2.EOF
                            %>
                            <tr>    
                                <td><%=Server.HtmlEncode(rs2("TenSP"))%></td>
                                <td><%=rs2("GiaBan")%></td>
                                <td><%=rs2("SoLuong")%></td>
                                <td><%=rs2("ThanhTien")%></td>
                            </tr>
                            <%
                                rs2.MoveNext
                                loop
                            %>
                        <%
                            rs1.MoveNext
                            loop
                        %>
                        <tr>
                            <td></td>
                            <td></td>
                            <th>Tổng Tiền:</th>
                            <%
                                Dim sql3
                                sql3 = "SELECT * from DonHang where MaDH = " &MaDH& ""
                                Dim rs3
                                Set rs3 = connDB.Execute(sql3)
                            %>
                            <td><%=rs3("TongTien")%></td>
                        </tr>
                        
                    </tbody>
                </table>           
                    
            </div>
            <div class="row pt-2">
                <h6 class="mb-0 col-lg-10 pt-3">
                    <a href="./bill.asp" class="text-body">
                        <i class="fas fa-long-arrow-alt-left me-2"></i>
                    Quay lại </a>
                </h6>
            </div>
            <br>
            <br>
        </div>
    </body>
    <!--#include file="../Shopping/footer.asp"-->
</html>