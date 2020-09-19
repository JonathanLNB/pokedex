import 'dart:convert';
import 'Specie.dart';

class Ability {
  Ability({
    this.ability,
    this.isHidden,
    this.slot,
  });

  Specie ability;
  bool isHidden;
  int slot;

  factory Ability.fromRawJson(String str) => Ability.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
    ability: Specie.fromJson(json["ability"]),
    isHidden: json["is_hidden"],
    slot: json["slot"],
  );

  Map<String, dynamic> toJson() => {
    "ability": ability.toJson(),
    "is_hidden": isHidden,
    "slot": slot,
  };
}