// To parse this JSON data, do
//
//     final partido = partidoFromJson(jsonString);

import 'dart:convert';

import 'package:web_admin_tenis/models/jugador_model.dart';

List<Partido> partidoFromJson(String str) =>
    List<Partido>.from(json.decode(str).map((x) => Partido.fromJson(x)));

String partidoToJson(List<Partido> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Partido {
  String idPartido;
  String torneo;
  String ronda;
  bool saque;
  bool tiebreak = false;
  Jugador j1;
  Jugador j2;

  Partido({
    required this.idPartido,
    required this.torneo,
    required this.ronda,
    required this.saque,
    required this.j1,
    required this.j2,
  });

  factory Partido.fromJson(Map<String, dynamic> json) => Partido(
    idPartido: json["idPartido"],
    torneo: json["torneo"],
    ronda: json["ronda"],
    saque: json["saque"],
    j1: Jugador.fromJson(json["j1"]),
    j2: Jugador.fromJson(json["j2"]),
  );

  Map<String, dynamic> toJson() => {
    "idPartido": idPartido,
    "torneo": torneo,
    "ronda": ronda,
    "saque": saque,
    "j1": j1.toJson(),
    "j2": j2.toJson(),
  };

  @override
  String toString() {
    return 'Partido {'
        'idPartido: $idPartido, '
        'saque: $saque, '
        'torneo: $torneo, '
        'ronda: $ronda, '
        'jugador1: ${j1.toString()}, '
        'jugador2: ${j2.toString()}'
        '}';
  }
}
