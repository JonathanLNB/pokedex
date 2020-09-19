import 'dart:convert';

class Specie {
  Specie({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory Specie.fromRawJson(String str) => Specie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Specie.fromJson(Map<String, dynamic> json) => Specie(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}