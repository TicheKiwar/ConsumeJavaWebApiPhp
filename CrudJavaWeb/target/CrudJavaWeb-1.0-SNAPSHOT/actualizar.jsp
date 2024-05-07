<%@page import="CrudJavaWeb.ApiClient"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.net.http.HttpResponse" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Actualizar Estudiante</title>
        <!-- Incluye el archivo head.jsp si es necesario -->
        <jsp:include page="head.jsp" />
    </head>

    <body style="width: 80%; margin: auto;">
        <!-- Incluye la barra de navegaci�n si es necesario -->
        <div>
            <jsp:include page="navbar.jsp" />
        </div>

        <h1>Actualizar Estudiante</h1>

        <%
            // Obtiene el par�metro 'ced_est' de la solicitud
            String id = request.getParameter("ced_est");

            // Crea una instancia de UserService
            ApiClient userService = new ApiClient();

            // Declara variables para almacenar los datos del usuario
            String nombre = "", apellido = "", direccion = "", telefono = "";

            // Si el ID no es nulo ni est� vac�o, busca el usuario
            if (id != null && !id.isEmpty()) {
                try {
                    // Llama a getUserById en UserService para obtener la respuesta del usuario
                    JSONObject respuesta = userService.getUserById(id);

                            nombre = respuesta.getString("nom_est");
                            apellido = respuesta.getString("ape_est");
                            direccion = respuesta.getString("dir_est");
                            telefono = respuesta.getString("tel_est");
                } catch (Exception e) {
                    // Muestra un mensaje de error si ocurre alguna excepci�n
                    out.print("Error: " + e.getMessage());
                }
            }
        %>

        <!-- Formulario para actualizar el usuario -->
        <form method="POST" autocomplete="off">
            <div class="mb-3">
                <label for="cedula" class="form-label">C�dula</label>
                <input type="text" class="form-control" id="cedula" name="cedula" value="<%= id %>" readonly>
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<%= nombre %>">
            </div>
            <div class="mb-3">
                <label for="apellido" class="form-label">Apellido</label>
                <input type="text" class="form-control" id="apellido" name="apellido" value="<%= apellido %>">
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Direcci�n</label>
                <input type="text" class="form-control" id="direccion" name="direccion" value="<%= direccion %>">
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Tel�fono</label>
                <input type="text" class="form-control" id="telefono" name="telefono" value="<%= telefono %>">
            </div>

            <button type="submit" class="btn btn-primary">Actualizar</button>
        </form>

        <!-- Procesamiento de la solicitud POST para actualizar el usuario -->
        <%
            if (request.getMethod().equals("POST")) {
                try {
                    // Obt�n los valores del formulario
                    String cedula = request.getParameter("cedula");
                    nombre = request.getParameter("nombre");
                    apellido = request.getParameter("apellido");
                    direccion = request.getParameter("direccion");
                    telefono = request.getParameter("telefono");

                    // Llama a updateUser en UserService para actualizar el usuario
                    HttpResponse<String> respuesta = userService.updateUser(cedula, nombre, apellido, direccion, telefono);

                    // Maneja la respuesta y muestra un mensaje seg�n el resultado
                    if (userService.getResponseStatusCode(respuesta) == 200) {
                        out.print("<br>");
                        out.print("<div class='alert alert-success' role='alert'>Registro actualizado con �xito</div>");
                        // Redirige a la p�gina principal si se requiere
                        response.sendRedirect("index.jsp");
                    } else {
                        out.print("<br>");
                        out.print("<div class='alert alert-danger' role='alert'>Error al actualizar el registro</div>");
                    }
                } catch (Exception e) {
                    // Muestra un mensaje de error si ocurre alguna excepci�n
                    out.print("Error: " + e.getMessage());
                }
            }
        %>
    </body>
</html>
