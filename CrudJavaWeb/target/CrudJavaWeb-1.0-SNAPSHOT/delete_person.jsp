<%@page import="CrudJavaWeb.ApiClient"%>
<%@ page import="java.net.http.HttpResponse" %>

<%
    String id = request.getParameter("ced_est");
    if (id != null) {
        // Crea una instancia de UserService
        ApiClient userService = new ApiClient();
        
        try {
            // Llama a deleteUser en UserService y obt�n la respuesta
            HttpResponse<String> respuesta = userService.deleteUser(id);

            // Redirige a index.jsp si la eliminaci�n fue exitosa
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            out.print("Error: " + e);
        }
    }
%>