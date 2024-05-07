<%@page import="CrudJavaWeb.ApiClient"%>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.IOException" %>

<!DOCTYPE html>
<html lang="es">
    <jsp:include page="head.jsp" />

    <body style="width: 80%; margin: auto;">
        <div>
            <jsp:include page="navbar.jsp" />
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">CEDULA</th>
                    <th scope="col">NOMBRE</th>
                    <th scope="col">APELLIDO</th>
                    <th scope="col">DIRECCION</th>
                    <th scope="col">TELEFONO</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
            </thead>

            <tbody>
                <%
                    ApiClient apiClient = new ApiClient();
                    
                    try {
                        JSONArray jsonArray = apiClient.getDataFromApi();

                        // Itera a través del JSONArray e imprime en la tabla
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject jsonObject = jsonArray.getJSONObject(i);
                            String cedula = jsonObject.getString("ced_est");
                            String nombre = jsonObject.getString("nom_est");
                            String apellido = jsonObject.getString("ape_est");
                            String direccion = jsonObject.getString("dir_est");
                            String telefono = jsonObject.getString("tel_est");
                %>
                <tr>
                    <td><%= cedula%></td>
                    <td><%= nombre%></td>
                    <td><%= apellido%></td>
                    <td><%= direccion%></td>
                    <td><%= telefono%></td>
                    <td><a href="actualizar.jsp?ced_est=<%= cedula%>" class="btn btn-primary">EDITAR</a></td>
                    <td><a href="delete_person.jsp?ced_est=<%= cedula%>" class="btn btn-danger">ELIMINAR</a></td>
                </tr>
                <%
                        }
                    } catch (IOException | InterruptedException e) {
                        // Manejo de errores
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </body>
</html>