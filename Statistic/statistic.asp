
<!-- #include file="../connect.asp" -->

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="css/bootstrap.min.css" rel="stylesheet" >
        <title>Thống kê</title>
    </head>
    <body>
        <!-- #include file="../headerQL.asp" -->
        <section class="main">
        <div class="container py-2">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Thống kê doanh thu</h2></div>
            </div>

            <div class="container ">
                 <div class="row">
                      <div class="col-md-3">
                        <form action="statistic.asp" method="post">
                            <label for="dateBD"><strong>Ngày bắt đầu:</strong></label>
                            <input type="date" name="dateBD" class="form-control" id="dateBD">
                            
                      </div>

                      <div class="col-md-3">                          
                            <label for="dateBD"><strong>Ngày kết thúc:</strong></label>
                            <input type="date" name="dateKT" class="form-control" id="dateKT" >                           
                      </div>
                            
                      <div class="col-md-3 py-4">
                         <input class="btn btn-success" type="submit" name="submit" value="Thống kê"> 
                      </div>
                      </form>
                 </div>
             </div>
             
             <div class="table-responsive ">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr class="table-secondary">
                            <th scope="col">Số lượng đơn hàng</th>
                            <th scope="col">Số lượng sản phẩm</th>
                            <th scope="col">Doanh thu</th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <% 
                        Dim dateBD, dateKT
                        Dim isValidDateRange

                        If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
                            dateBD = Request.Form("dateBD")
                            dateKT = Request.Form("dateKT")   
                            ' Kiểm tra xem dateBD và dateKT có định dạng ngày hợp lệ không
                            If (IsDate(dateBD) And IsDate(dateKT)) Then
                                If CDate(dateBD) > CDate(dateKT) Then
                                    Session("Error")="Nhập ngày không hợp lệ"
                                End If 
                            End If 
                        End If 

                            Dim strSQL1, SLDH
                            strSQL1 = "SELECT COUNT(MaDH) AS SLDH FROM DonHang WHERE ThoiGianDat BETWEEN '" & dateBD & "' AND '" & dateKT & "'"
                            connDB.Open()
                            Set CountResult = connDB.Execute(strSQL1)
                            SLDH = CLng(CountResult("SLDH"))

                        %>
                        
                        <%
                            Dim strSQL2,SLSP
                            strSQL2="SELECT SUM(SoLuong) AS SLSP FROM ChiTietDonHang inner join DonHang on ChiTietDonHang.MaDH=DonHang.MaDH WHERE DonHang.ThoiGianDat BETWEEN '" & dateBD & "' AND '" & dateKT & "'"                            
                            Set RS = connDB.execute(strSQL2)
                            If Not RS.EOF Then
                            If Not IsNull(RS("SLSP")) Then
                                SLSP = CLng(RS("SLSP"))
                            Else
                                SLSP = 0 ' Hoặc giá trị mặc định khác nếu phù hợp
                            End If
                            Else
                            SLSP = 0 ' Hoặc giá trị mặc định khác nếu phù hợp
                            End If
                        %>
                        <%
                            Dim strSQL3, DoanhThu
                            strSQL3 = "SELECT SUM([TongTien]) AS DoanhThu FROM DonHang WHERE ThoiGianDat BETWEEN '" & dateBD & "' AND '" & dateKT & "'"
                            Set RS = connDB.execute(strSQL3)
                        If Not RS.EOF Then
                            If Not IsNull(RS("DoanhThu")) Then
                                DoanhThu = CLng(RS("DoanhThu"))
                            Else
                                DoanhThu = 0 ' Hoặc giá trị mặc định khác nếu phù hợp
                        End If
                        Else
                            DoanhThu = 0 ' Hoặc giá trị mặc định khác nếu phù hợp
                        End If
                        %>
                                <tr>
                                    <td><%=SLDH%></td>
                                    <td><%=SLSP%></td>
                                    <td><%=DoanhThu%></td>
                                </tr>
                        <%

                        %>
                    </tbody>
                </table>
        </div>


            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Thống kê doanh số bán hàng</h2></div>
            </div>

            <div class="table-responsive ">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr class="table-secondary">
                            <th scope="col">Mã sản phẩm</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Số lượng bán</th>
                        </tr>
                    </thead>                   
                    <tbody>
                    <%
                    StrSQL4 ="SELECT TOP 5 DoAn.MaSP,DoAn.TenSP,SUM(SoLuong) AS TongSoLuongBan from ChiTietDonHang inner join DoAn on ChiTietDonHang.MaSP=DoAn.MaSP inner join DonHang on ChiTietDonHang.MaDH=DonHang.MaDH WHERE DonHang.ThoiGianDat >= '" & dateBD & "' AND DonHang.ThoiGianDat <= '" & dateKT & "' GROUP BY DoAn.MaSP, DoAn.TenSP ORDER BY TongSoLuongBan DESC;"
                    Set RS = connDB.execute(StrSQL4)
                    do while not RS.EOF
                    %>
                        <tr>
                            <td><%=RS("MaSP")%></td>
                            <td><%=RS("TenSP")%></td>
                            <td><%=RS("TongSoLuongBan")%></td>   
                        </tr>
                    <%
                    RS.MoveNext
                    loop
                    %>
                    </tbody>
                </table>
        </div>
        
        </section>
        <!--#include file="../Shopping/footer.asp"-->
    </body>
</html>