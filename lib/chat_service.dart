import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService {
  static const String baseUrl = "https://apiparachatgpt20250427204752-f9dpf0djgab2hqhj.brazilsouth-01.azurewebsites.net/api/chat";

  Future<String> enviarMensaje(String textoUsuario) async {
    final response = await http.post(
      Uri.parse("$baseUrl/consulta"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"mensaje_usuario": textoUsuario}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["respuesta"] ?? "Sin respuesta.";
    } else {
      return "Error al contactar la IA.";
    }
  }

  Future<List<Map<String, dynamic>>> obtenerPreviews() async {
    final response = await http.get(Uri.parse("$baseUrl/previews"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Error al cargar previews.");
    }
  }

  Future<List<Map<String, dynamic>>> obtenerHistorial(String idCliente) async {
    final response = await http.get(Uri.parse("$baseUrl/historial?idCliente=$idCliente"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Error al cargar historial.");
    }
  }
}
