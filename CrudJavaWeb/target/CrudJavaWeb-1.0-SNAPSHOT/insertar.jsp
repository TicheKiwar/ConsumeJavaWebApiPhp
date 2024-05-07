<%@page import="java.net.http.HttpResponse"%>
<%@page import="CrudJavaWeb.ApiClient"%>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONObject" %>

<!DOCTYPE html>
<html lang="es">
    <jsp:include page="head.jsp" />

    <body style="width: 80%; margin: auto;">
        <div>
            <jsp:include page="navbar.jsp" />
        </div>
        <form method="POST">
            <!-- Formulario para agregar datos -->
            <div class="mb-3">
                <label for="ced_est" class="form-label">Cedula</label>
                <input type="text" class="form-control" id="ced_est" name="ced_est">
            </div>
            <div class="mb-3">
                <label for="nom_est" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nom_est" name="nom_est">
            </div>
            <div class="mb-3">
                <label for="ape_est" class="form-label">Apellido</label>
                <input type="text" class="form-control" id="ape_est" name="ape_est">
            </div>
            <div class="mb-3">
                <label for="dir_est" class="form-label">Direccion</label>
                <input type="text" class="form-control" id="dir_est" name="dir_est">
            </div>
            <div class="mb-3">
                <label for="tel_est" class="form-label">Telefono</label>
                <input type="text" class="form-control" id="tel_est" name="tel_est">
            </div>
            <button type="submit" class="btn btn-primary">AGREGAR</button>
        </form>

        <%
            if (request.getMethod().equals("POST")) {
                // Obtiene los parámetros del formulario
                String cedula = request.getParameter("ced_est");
                String nombre = request.getParameter("nom_est");
                String apellido = request.getParameter("ape_est");
                String direccion = request.getParameter("dir_est");
                String telefono = request.getParameter("tel_est");

                // Crea una instancia de UserService
                ApiClient userService = new ApiClient();

                try {
                    // Llama a registerUser en UserService
                    HttpResponse<String> respuesta = userService.registerUser(cedula, nombre, apellido, direccion, telefono);

                    // Maneja la respuesta
                    if (userService.getResponseStatusCode(respuesta) == 200) {
                        out.print("<br>");
                        out.print("<div class='alert alert-success' role='alert'>Registrado con exito</div>");
                    } else {
                        out.print("<br>");
                        out.print("<div class='alert alert-danger' role='alert'>Error al registrar</div>");
                    }
                } catch (IOException | InterruptedException e) {
                    // Manejo de errores
                    e.printStackTrace();
                    out.print("<br>");
                    out.print("<div class='alert alert-danger' role='alert'>Error al registrar</div>");
                }
            }
        %>
    </body>
</html>