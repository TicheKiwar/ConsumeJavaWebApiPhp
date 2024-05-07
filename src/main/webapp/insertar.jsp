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
                <label for="cedula" class="form-label">Cedula</label>
                <input type="text" class="form-control" id="cedula" name="cedula">
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre">
            </div>
            <div class="mb-3">
                <label for="apellido" class="form-label">Apellido</label>
                <input type="text" class="form-control" id="apellido" name="apellido">
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Direccion</label>
                <input type="text" class="form-control" id="direccion" name="direccion">
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Telefono</label>
                <input type="text" class="form-control" id="telefono" name="telefono">
            </div>
            <button type="submit" class="btn btn-primary">AGREGAR</button>
        </form>

        <%
            if (request.getMethod().equals("POST")) {
                // Obtiene los parámetros del formulario
                String cedula = request.getParameter("cedula");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");

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