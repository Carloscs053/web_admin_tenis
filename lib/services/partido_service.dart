import 'dart:convert';

import 'package:http/http.dart';

class PartidoService {
  final String _baseUrl = "https://backend-tenis.onrender.com/api/v1/tenis";

  Future<bool> crearPartido({
    required String torneo,
    required String ronda,
    required String idJ1,
    required String idJ2,
    required bool saqueJ1,
  }) async {
    Uri uri = Uri.parse('$_baseUrl/nuevoPartido');

    final Map<String, dynamic> body = {
      "torneo": torneo,
      "ronda": ronda,
      "saque": saqueJ1,
      "idJ1": idJ1,
      "idJ2": idJ2,
    };

    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print("Error creando el partido: ${response.body}");
      return false;
    }
  }
}
