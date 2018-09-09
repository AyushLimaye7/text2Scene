<%-- 
    Document   : index
    Created on : 14 Mar, 2016, 12:07:51 PM
    Author     : mansi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>project</title>
    </head>
    <body>
        <h2>Enter the Sentence here:</h2>
        <form name="myInput" action="MyServlet" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>
                            <input type="text" name="text" value="" style="width:500px;height:50px"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Submit" name="submit" />
        </form>
    </body>
    
</html>
