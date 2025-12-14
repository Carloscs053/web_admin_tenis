// To parse this JSON data, do
//
//     final jugador = jugadorFromJson(jsonString);

import 'dart:convert';

List<Jugador> jugadorFromJson(String str) =>
    List<Jugador>.from(json.decode(str).map((x) => Jugador.fromJson(x)));

String jugadorToJson(List<Jugador> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jugador {
  String jugadorId;
  String? nombre;
  String? foto;
  List<int> juegos;
  int? sets;
  int puntos = 0;

  Jugador({
    required this.jugadorId,
    this.nombre,
    this.foto,
    this.juegos = const [],
    this.sets,
  });

  String getImage() {
    return 'https://cdn.thesimpsonsapi.com/500$foto';
  }

  factory Jugador.fromJson(Map<String, dynamic> json) => Jugador(
    jugadorId: json["jugadorId"],
    nombre: json["nombre"],
    foto: json["foto"],
    juegos: json["juegos"] == null
        ? []
        : List<int>.from(json["juegos"].map((x) => x)),
    sets: json["sets"],
  );

  Map<String, dynamic> toJson() => {
    "jugadorId": jugadorId,
    "nombre": nombre,
    "foto": foto,
    "juegos": List<dynamic>.from(juegos.map((x) => x)),
    "sets": sets,
  };

  @override
  String toString() {
    return 'Jugador {'
        'id: $jugadorId, '
        'nombre: $nombre, '
        'Imagen: $foto, '
        'juegos: $juegos, '
        'sets: $sets'
        '}';
  }
}
