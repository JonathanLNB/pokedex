import 'dart:convert';

import 'package:pokedex/TDA/Specie.dart';

class PokeList {
  PokeList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Specie> results;

  factory PokeList.fromRawJson(String str) => PokeList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PokeList.fromJson(Map<String, dynamic> json) => PokeList(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Specie>.from(json["results"].map((x) => Specie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}
