<!--#include file="../connect.asp"-->
<%
        'code for delete a product from my cart
        'lay ve product id
        ' If (isnull(Session("email")) OR TRIM(Session("email")) = "") Then
        ' Response.redirect("login.asp")
        ' End If
        Dim mycart
        If (NOT IsEmpty(Session("mycart"))) Then
            Set mycart = Session("mycart")
            If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
                Dim pid
                ' Lấy về id 
                pid = Request.QueryString("id")
                'Kiểm tra id có thực sự tồn tại trong giỏ hàng hay không
                If mycart.Exists(pid) = true then
                    mycart.Remove(pid)
                    'Xóa đi nhưng trong giỏ hàng vẫn còn sản phẩm
                    If (mycart.Count>0) Then
                        'True
                        Set Session("mycart") = mycart
                    ' Xóa và giỏ hàng đã hết sản phẩm
                    Else
                        'remove session mycart
                        Session.Contents.Remove("mycart")
                    End If
                    'saving new session value
                
                    Session("Success") = "Sản phẩm đã được xóa khỏi giỏ hàng"      
                Else
                    Session("Error") = "Sản phẩm không tồn tại trong giỏ hàng"     
                end if    
            ElseIf (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
            'Do something... 
              'Button update de cap nhat lai so luong va gia
            'check when button update submit
            'tinh toan so tien
            'lay ve quantity: sô lượng
                    Dim quantityArray
                    'Lấy về giá trị để cho vào 1 mảng
                    quantityArray = Request.Form("quantity")
                    'Tách giá trị
                    quantityArrays = Split(quantityArray,",")
                    Dim count
                    count = 0 
                    'Vòng lập for để cập nhật số lượng 
                    For Each tmp In mycart.Keys
                    mycart.Item(tmp) = Clng(quantityArrays(count))
                    count = count + 1
                    Next
            'saving new session value
                    Set Session("mycart") = mycart            
                End If
        End If
        Response.Redirect("./shoppingcart.asp")              
%>