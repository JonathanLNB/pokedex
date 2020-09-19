import 'dart:convert';

import 'DreamWorld.dart';
import 'OfficalArtwork.dart';

class Other {
  Other({
    this.dreamWorld,
    this.officialArtwork,
  });

  DreamWorld dreamWorld;
  OfficialArtwork officialArtwork;

  factory Other.fromRawJson(String str) => Other.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Other.fromJson(Map<String, dynamic> json) => Other(
    dreamWorld: DreamWorld.fromJson(json["dream_world"]),
    officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
  );

  Map<String, dynamic> toJson() => {
    "dream_world": dreamWorld.toJson(),
    "official-artwork": officialArtwork.toJson(),
  };
}
