import 'dart:convert';

import 'Specie.dart';

class Move {
  Move({
    this.move,
  });

  Specie move;

  factory Move.fromRawJson(String str) => Move.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Move.fromJson(Map<String, dynamic> json) => Move(
    move: Specie.fromJson(json["move"]),
  );

  Map<String, dynamic> toJson() => {
    "move": move.toJson(),
  };
}
