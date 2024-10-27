// To parse this JSON data, do
//
//     final genereModel = genereModelFromJson(jsonString);

import 'dart:convert';

GenereModel genereModelFromJson(String str) => GenereModel.fromJson(json.decode(str));

String genereModelToJson(GenereModel data) => json.encode(data.toJson());

class GenereModel {
    List<Genre>? genres;

    GenereModel({
         this.genres,
    });

    factory GenereModel.fromJson(Map<dynamic, dynamic> json) => GenereModel(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
    };
}

class Genre {
    int id;
    String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
