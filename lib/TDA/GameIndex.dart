import 'dart:convert';

import 'Specie.dart';

class GameIndex {
  GameIndex({
    this.gameIndex,
    this.version,
  });

  int gameIndex;
  Specie version;

  factory GameIndex.fromRawJson(String str) => GameIndex.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
    gameIndex: json["game_index"],
    version: Specie.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "game_index": gameIndex,
    "version": version.toJson(),
  };
}