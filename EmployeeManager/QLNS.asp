<!-- #include file="../connect.asp" -->
<%
    ' Kiểm tra xem người dùng đã đăng nhập chưa
    If Not Session("LoggedIn") Then
        ' Nếu người dùng chưa đăng nhập, điều hướng họ đến trang đăng nhập
        Response.Redirect("./loginManager.asp")
    End If
%>
<%
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

    strSQL = "SELECT COUNT(IDadmin) AS count FROM Admin"
    connDB.Open()
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
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <title>Quản lý nhân sự</title>
    </head>
    <body>
      <!--#include file="../headerQL.asp"-->

</div>
    <section class="main">
        <div class="container py-3">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Danh sách nhân viên</h2></div>
                <div class="p-2 bd-highlight">
                    <a href="./addeditnv.asp" class="btn btn-primary">Thêm nhân viên</a>       
                </div>
            </div>
            <div class="table-responsive ">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr class="table-secondary">
                            <th scope="col">IDadmin</th>
                            <th scope="col">Username</th>
                            <th scope="col">Password</th>
                            <th scope="col">Họ tên</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Email</th>
                            <th scope="col">SĐT</th>
                            <th scope="col">Ngày tạo</th>
                            <th scope="col">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.Prepared = True
                            cmdPrep.CommandText = "SELECT * FROM Admin ORDER BY IDadmin OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                            cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                            cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)

                            Set Result = cmdPrep.execute
                            do while not Result.EOF
                        %>
                                <tr>
                                    <td><%=Result("IDadmin")%></td>
                                    <td><%=Result("Username")%></td>
                                    <td><%=Result("Password")%></td>
                                    <td><%=Result("Name")%></td>
                                    <td><%=Result("Address")%></td>
                                    <td><%=Result("Email")%></td>
                                    <td><%=Result("Phone")%></td>
                                    <td><%=Result("CreateDate")%></td>
                                    <td>
                                        <a href="./addeditnv.asp?IDadmin=<%=Result("IDadmin")%>" class="btn btn-secondary">Sửa</a>
                                        <a data-href="./delelenv.asp?IDadmin=<%=Result("IDadmin")%>" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete">Xóa</a>
                                    </td>
                                </tr>
                        <%
                                Result.MoveNext
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
                <ul class="pagination justify-content-end justify-content-center my-5">
                    <% if (pages>1) then
                    'kiem tra trang hien tai co >=2
                        if(Clng(page)>=2) then
                    %>
                        <li class="page-item"><a class="page-link" href="QLNS.asp?page=<%=Clng(page)-1%>">Trước</a></li>
                    <%    
                        end if 
                        for i= 1 to range
                    %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="QLNS.asp?page=<%=i%>"><%=i%></a></li>
                    <%
                        next
                        if (Clng(page)<pages) then

                    %>
                        <li class="page-item"><a class="page-link" href="QLNS.asp?page=<%=Clng(page)+1%>">Tiếp</a></li>
                    <%
                        end if    
                    end if
                    %>
                </ul>
            </nav>

            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
            <script>
                $(function()
                {
                    $('#confirm-delete').on('show.bs.modal', function(e){
                        $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));              
                    });
                });
            </script>
        </div>
    </section>
</body>
        <!--#include file="../Shopping/footer.asp"-->
</html>