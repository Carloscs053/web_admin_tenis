import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_admin_tenis/models/jugador_model.dart';

class JugadorService {
  final String _baseUrl = "https://backend-tenis.onrender.com/api/v1/tenis";

  Future<List<Jugador>> getJugadores() async {
    List<Jugador> jugadores = [];

    Uri uri = Uri.parse('$_baseUrl/jugadores');

    Response response = await get(uri);

    if (response.statusCode != 200) return jugadores;

    dynamic jsonResponse = jsonDecode(response.body);

    List<dynamic> listaData = jsonResponse['data'];

    jugadores = listaData.map((json) => Jugador.fromJson(json)).toList();

    return jugadores;
  }

  Future<bool> crearJugador(Jugador jugador) async {
    Uri uri = Uri.parse('$_baseUrl/nuevoJugador');

    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(jugador.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print("Error creando el jugador: ${response.body}");
      return false;
    }
  }
}
