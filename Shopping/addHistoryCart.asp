<!--#include file="../connect.asp"-->
<%
    'Lay ve IDProduct
    Dim idProduct
    idProduct = Request.QueryString("idproductHistory")
    ' Do Something...
    If (NOT IsNull(idProduct) and idProduct <> "") Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM DoAn WHERE MaSP=?"
            cmdPrep.Parameters(0)=idProduct
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                'ID exits
                'check session exists
                Dim currentCarts, arrays, cc, mycart, List
                If (NOT IsEmpty(Session("mycart"))) Then
                    ' true
                    Set currentCarts = Session("mycart")                                                    
                    if currentCarts.Exists(idProduct) = true then
                        'Response.Write("Key exists.")
                        Dim value
                        value = Clng(currentCarts.Item(idProduct))+1
                        currentCarts.Item(idProduct) = value                        
                    else
                       ' Response.Write("Key does not exist.")
                        currentCarts.Add idProduct, 1
                    end if 
                    'saving new session value
                    Set Session("mycart") = currentCarts
                    ' For Each List In currentCarts.Keys  
                    '     Response.write List& " = " & currentCarts.Item(List)  & "<br>"                        
                    ' Next              
                   'Response.Write("The Session is exists.")                                      
                Else
                    Dim quantity
                    quantity = 1                    
                    Set mycart = Server.CreateObject("Scripting.Dictionary")
                    mycart.Add idProduct, quantity
                    'creating a session for my cart
                    Set Session("mycart") = mycart
                    Set mycart = Nothing
                    Response.Write("Session created!")
                End if
                Session("Success") = "Sản phẩm đã được thêm vào giỏ hàng của bạn"
            Else
                Session("Error") = "Sản phẩm đã hết, vui lòng thêm sản phẩm khác"
            End If

            ' Set Result = Nothing
            Result.Close()
            connDB.Close()

           Response.redirect("./shoppingcart.asp")            
    End if
%>

