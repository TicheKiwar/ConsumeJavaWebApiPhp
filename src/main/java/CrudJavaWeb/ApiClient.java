
package CrudJavaWeb;

import org.json.JSONArray;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import org.json.JSONObject;

public class ApiClient {
    // Se envía la solicitud a través de un cliente HTTP
    private final HttpClient httpClient;
    private static String url = "http://localhost/SOAcopia/controller/apiRest.php";

    public ApiClient() {
        this.httpClient = HttpClient.newHttpClient();
    }

    public JSONArray getDataFromApi() throws Exception {
        // Solicitud (url), method, 
        HttpRequest request = HttpRequest.newBuilder()
                //Se convierte el String a objeto URI
                .uri(URI.create(url))
                .GET()
                //Se construye la solicitud
                .build();

        // Respuesta
        //BodyHandlers.ofString() -> especifica que el cuerpo de la respuesta se manejará como una cadena
        HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());

        // Devuelve los datos como JSONArray
        return new JSONArray(response.body());
    }
    
    public HttpResponse<String> registerUser(String cedula, String nombre, String apellido, String direccion, String telefono) throws Exception {
        
//        String postData = "ced_est=" + cedula + "&nom_est=" + nombre + "&ape_est=" + apellido + "&dir_est=" + direccion +
//                    "&tel_est=" + telefono;
//            //cliente
//            //solicitud
//            HttpRequest solicitud = HttpRequest.newBuilder()
//                    .uri(URI.create(url))
                       //Esta cabecera indica que los datos enviados estarán en el formato de formulario codificado URL
//                    .header("Content-Type", "application/x-www-form-urlencoded")
                        //utilizado para configurar el cuerpo de la solicitud con los datos que se desean enviar.
//                    .POST(HttpRequest.BodyPublishers.ofString(postData))
//                    .build();
        
        JSONObject data = new JSONObject();
        data.put("cedula", cedula);
        data.put("nombre", nombre);
        data.put("apellido", apellido);
        data.put("direccion", direccion);
        data.put("telefono", telefono);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                
                .header("Content-Type", "application/json")
                
                .POST(HttpRequest.BodyPublishers.ofString(data.toString()))
                
                .build();

        HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());

        return response;
    }
    
    
    public HttpResponse<String> deleteUser(String id) throws Exception {
        // Construye la URI de la API con el identificador
        URI uri = URI.create(url + "?cedula=" + id);

        // Crea una solicitud DELETE
        HttpRequest request = HttpRequest.newBuilder()
                .uri(uri)
                .DELETE()
                .build();

        // Envía la solicitud y devuelve la respuesta
        return httpClient.send(request, BodyHandlers.ofString());
    }
        
    public JSONObject getUserById(String cedula) throws Exception {
        // Realiza una solicitud GET para obtener todos los usuarios
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        // Obtiene la respuesta del servidor
        HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());

        // Convierte la respuesta en un JSONArray
        JSONArray jsonArray = new JSONArray(response.body());

        // Itera a través del JSONArray y encuentra el usuario con la cedula especificada
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            if (jsonObject.getString("cedula").equals(cedula)) {
                // Retorna el objeto JSON del usuario encontrado
                return jsonObject;
            }
        }

        // Si no se encuentra el usuario, retorna null
        return null;
    }
    
     public HttpResponse<String> updateUser(String cedula, String nombre, String apellido, String direccion, String telefono) throws Exception {
        // Crea el objeto JSON con los datos a actualizar
        JSONObject data = new JSONObject();
        data.put("cedula", cedula);
        data.put("combre", nombre);
        data.put("apellido", apellido);
        data.put("direccion", direccion);
        data.put("telefono", telefono);

        // Construye la URI
        URI uri = URI.create(url);

        // Crea una solicitud PUT para actualizar el usuario
        HttpRequest request = HttpRequest.newBuilder()
                .uri(uri)
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(data.toString()))
                .build();

        // Envía la solicitud y devuelve la respuesta
        return httpClient.send(request, BodyHandlers.ofString());
    }
    
     public int getResponseStatusCode(HttpResponse<String> response) {
        return response.statusCode();
    }
}
