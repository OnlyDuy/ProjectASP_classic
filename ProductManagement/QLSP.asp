<!-- #include file="../connect.asp" -->
<%
    ' Kiểm tra xem người dùng đã đăng nhập chưa
    If Not Session("LoggedIn") Then
        ' Nếu người dùng chưa đăng nhập, điều hướng họ đến trang đăng nhập
        Response.Redirect("./loginManager.asp")
    End If
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
    limit = 4   

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

'    Vị trí để lấy bản ghi ( từ vị trí nào đến vị trí nào)
    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(MaSP) AS count FROM DoAN"
    connDB.Open()
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <title>Quản lý sản phẩm</title>
</head>

<body>

<!-- #include file="../headerQL.asp" -->

    <section class="main">
        <div class="container py-3">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight">
                    <h2>Danh sách sản phẩm</h2>
                </div>
            </div>
            <div class="container ">
                 <div class="row">
                      <div class=col-md-5>
                      <form action="QLSP.asp" method="post" accept-charset="UTF-8">
                           <div class="input-group mb-3">
                           <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm"  aria-describedby="basic-addon1" name="TenSP" value="<%=TenSP%>">
                           <span class="input-group-text" id="basic-addon1"><i class="fa-solid fa-magnifying-glass"></i></span>
                           </div>
                      </div>
                      <div class=col-md-2>
                           <input class="btn btn-success" type="submit" value="Tìm kiếm sản phẩm">
                      </div>
                      </form>
                      <div class=col-md-3>
                         <a class="btn btn-primary" href="./addeditsp.asp" role="button" id="">Thêm sản phẩm</a> 
                      </div>
                 </div>
             </div>
            
            <div class="table-responsive ">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr class="table-secondary">
                            <th scope="col">Mã sản phẩm</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Giá</th>
                            <th scope="col">Giới thiệu</th>
                            <th scope="col">Mô tả chi tiết</th>
                            <th scope="col">Ảnh bìa</th>
                            <th scope="col">Ngày cập nhật</th>
                            <th scope="col">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        Dim TenSP, StrSQL
                        ', cmdPrep, rs
                        If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
                            ' Lấy giá trị từ ô nhập liệu có name là "TenSP"
                            TenSP = Request.Form("TenSP")
                        End If

                        If Not IsNull(TenSP) And Trim(TenSP) <> "" Then
                            StrSQL = "SELECT * FROM DoAn WHERE TenSP LIKE N'%"&TenSP&"%' ORDER BY MaSP"
                        Else
                            StrSQL = "SELECT * FROM DoAn ORDER BY MaSP OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.Prepared = True
                            cmdPrep.CommandText = StrSQL
                            cmdPrep.Parameters.Append cmdPrep.CreateParameter("offset", 3, 1, , offset)
                            cmdPrep.Parameters.Append cmdPrep.CreateParameter("limit", 3, 1, , limit)
                            Set rs = cmdPrep.Execute
                        End If

                        If Not IsObject(rs) Then
                            Set rs = connDB.Execute(StrSQL)
                        End If
                        
                        Do While Not rs.EOF

                        %>
                            <tr>
                                <td>
                                    <%=rs("MaSP")%>
                                </td>
                                <td>
                                    <% 
                                     =rs("TenSP")
                                     %>
                                </td>
                                <td>
                                    <%=rs("GiaBan")%>
                                </td>
                                <td>
                                    <%=rs("GioiThieu")%>
                                </td>
                                <td>
                                    <%=rs("MoTaChiTiet")%>
                                </td>
                                <td>
                                    <%=rs("AnhBia")%>
                                </td>
                                <td>
                                    <%=rs("NgayCapNhat")%>
                                </td>
                                <td>
                                    <a href="./addeditsp.asp?MaSP=<%=rs("MaSP")%>" class="btn btn-secondary mb-2">Sửa</a>
                                    <a data-href="./deletesp.asp?MaSP=<%=rs("MaSP")%>" class="btn btn-danger"
                                        data-bs-toggle="modal"
                                        data-bs-target="#confirm-delete" title="Delete">Xóa</a>
                                </td>
                            </tr>
                            <% 
                                rs.MoveNext 
                                loop 
                            %>
                    </tbody>
                </table>
            </div>
            <div class="modal" tabindex="-1" id="confirm-delete">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Confirmation</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn có muốn xóa?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <a class="btn btn-danger btn-delete">Xóa</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <nav aria-label="Page Navigation">
                <ul class="pagination pagination-sm justify-content-center my-5">
                    <% 
                        if (pages>1) then
                        'kiem tra trang hien tai co >=2
                            if(Clng(page)>=2) then
                        %>
                            <li class="page-item"><a class="page-link" href="QLSP.asp?page=<%=Clng(page)-1%>">Trước</a></li>
                        <%    
                            end if 
                            for i= 1 to pages
                        %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="QLSP.asp?page=<%=i%>"><%=i%></a></li>
                        <%
                            next
                            if (Clng(page)<pages) then

                        %>
                            <li class="page-item"><a class="page-link" href="QLSP.asp?page=<%=Clng(page)+1%>">Sau</a></li>
                        <%
                            end if    
                        end if
                        %>                           
                </ul>
            </nav>
        
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
                crossorigin="anonymous"></script>
            <script>
                $(function () {
                    $('#confirm-delete').on('show.bs.modal', function (e) {
                        $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
                    });
                });
            </script>
        </div>
    </section>

</body>
<!-- #include file="../Shopping/footer.asp" -->

</html>