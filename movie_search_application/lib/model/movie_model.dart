// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

List<MovieModel> movieModelFromJson(String str) =>
    List<MovieModel>.from(json.decode(str).map((x) => MovieModel.fromJson(x)));

String movieModelToJson(List<MovieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieModel {
  String? title;
  String? posterUrl;
  String? description;
  double? rating;
  String? duration;
  String? genre;
  DateTime? releaseDate;

  MovieModel({
    this.title,
    this.posterUrl,
    this.description,
    this.rating,
    this.duration,
    this.genre,
    this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    title: json["title"],
    posterUrl: json["posterUrl"],
    description: json["description"],
    rating: json["rating"]?.toDouble(),
    duration: json["duration"],
    genre: json["genre"],
    releaseDate:
        json["releaseDate"] == null
            ? null
            : DateTime.parse(json["releaseDate"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "posterUrl": posterUrl,
    "description": description,
    "rating": rating,
    "duration": duration,
    "genre": genre,
    "releaseDate":
        "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
  };
}
