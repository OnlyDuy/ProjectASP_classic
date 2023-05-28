<!--#include file="../connect.asp"-->
<%
' ham lam tron so nguyen
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
    limit = 3

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(MaDH) AS count FROM DonHang"
    connDB.Open
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)
    'gioi han tong so trang la 5
    Dim range
    If (pages<=5) Then
        range = pages
    Else
        range = 5
    End if
%>
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
            .input-group{
                margin-top: 10px;
                display: flex;    
                justify-content: center;
            }
            .form-outline{
                display: flex;
            }
            #keyword{
                width: 600px;
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
    <!--#include file="../headerQL.asp"-->
        <div class="search_bar">
            <div class="input-group">
                <form class="form-outline" method="post">
                    <input type="search" id="keyword" class="form-control" placeholder="Vui lòng nhập mã đơn hàng" name="keyword">
                    <input type="submit" class="btn btn-primary" value="Tìm Kiếm">
                </form>
            </div>
        </div>
        <div class="container">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Danh Sách Hóa Đơn</h2></div>
            </div>
            <div class="table_responsive">
                <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">Mã Hóa Đơn</th>
                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Thời Gian</th>
                        <th scope="col">Tên Khách Hàng</th>
                        <th scope="col">Số Điện Thoại</th>
                        <th scope="col">Địa Chỉ</th>
                        <th scope="col">Tổng Tiền</th>
                        <th scope="col">Chi Tiết</th>
                      </tr>
                    </thead>
                    <tbody>
                        <%                                
                            Dim sqlSearch
                            Dim rsSearch
                        %>
                        <%
                            'Lay o tim kiem
                            Dim keyword      
                            If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
                                keyword = Request.Form("keyword")
                            End If
                            'Kiem tra o tim kiem co trong hay khong
                            If (NOT isnull(keyword) AND TRIM(keyword)<>"") Then
                                sqlSearch = "SELECT * from DonHang where MaDH = " &keyword& " "
                            Else
                                sqlSearch = "SELECT * FROM DonHang ORDER BY MaDH OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY"    
                            End If              
                        %>
                        <%
                            Set rsSearch = connDB.Execute(sqlSearch)                           
                            do while not rsSearch.EOF
                        %>
                            <tr>
                                <td><%=rsSearch("MaDH")%></td>
                                <td>
                                    <%  
                                        If rsSearch("DaThanhToan") = true Then
                                            Response.Write "Đã Thanh Toán"
                                        Else
                                            Response.Write "Chưa Thanh Toán"
                                        End If
                                    %>
                                </td>
                                <td><%=rsSearch("ThoiGianDat")%></td>
                                <td><%=rsSearch("NguoiNhan")%></td>
                                <td><%=rsSearch("SoDT")%></td>
                                <td><%=rsSearch("DiaChi")%></td>
                                <td><%=rsSearch("TongTien")%></td>
                                <td>
                                    <a href="bill_detail.asp?MaDH=<%=rsSearch("MaDH")%>" class="btn btn-secondary" id="bill_detail">Chi Tiết</a>
                                </td>
                            </tr>
                        <%
                            rsSearch.MoveNext
                            loop                   
                        %>     
                    </tbody>
                </table>               
            </div>
            <nav aria-label="Page Navigation">
                <ul class="pagination pagination-sm justify-content-center my-5">
                    <% if (pages>1) then
                    'kiem tra trang hien tai co >=2
                        if(Clng(page)>=2) then
                    %>
                        <li class="page-item"><a class="page-link" href="bill.asp?page=<%=Clng(page)-1%>"><-</a></li>
                    <%    
                        end if 
                        for i= 1 to range
                    %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="bill.asp?page=<%=i%>"><%=i%></a></li>
                    <%
                        next
                        if (Clng(page)<pages) then

                    %>
                        <li class="page-item"><a class="page-link" href="bill.asp?page=<%=Clng(page)+1%>">-></a></li>
                    <%
                        end if    
                    end if
                    %>
                </ul>
            </nav>
        </div>
    </body>
    <!--#include file="../Shopping/footer.asp"-->
</html>