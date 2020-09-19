import 'dart:convert';

class OfficialArtwork {
  OfficialArtwork({
    this.frontDefault,
  });

  String frontDefault;

  factory OfficialArtwork.fromRawJson(String str) => OfficialArtwork.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) => OfficialArtwork(
    frontDefault: json["front_default"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
  };
}