// To parse this JSON data, do
//
//     final movieDataResponse = movieDataResponseFromJson(jsonString);

import 'dart:convert';

MovieDataResponse movieDataResponseFromJson(String str) => MovieDataResponse.fromJson(json.decode(str));

String movieDataResponseToJson(MovieDataResponse data) => json.encode(data.toJson());

class MovieDataResponse {
  List<String>? genres;
  List<Movie>? movies;

  MovieDataResponse({
    this.genres,
    this.movies,
  });

  factory MovieDataResponse.fromJson(Map<String, dynamic> json) => MovieDataResponse(
    genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
    movies: json["movies"] == null ? [] : List<Movie>.from(json["movies"]!.map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
    "movies": movies == null ? [] : List<dynamic>.from(movies!.map((x) => x.toJson())),
  };
}

class Movie {
  int? id;
  String? title;
  String? year;
  String? runtime;
  List<String>? genres;
  String? director;
  String? actors;
  String? plot;
  String? posterUrl;

  Movie({
    this.id,
    this.title,
    this.year,
    this.runtime,
    this.genres,
    this.director,
    this.actors,
    this.plot,
    this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    title: json["title"],
    year: json["year"],
    runtime: json["runtime"],
    genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
    director: json["director"],
    actors: json["actors"],
    plot: json["plot"],
    posterUrl: json["posterUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "year": year,
    "runtime": runtime,
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
    "director": director,
    "actors": actors,
    "plot": plot,
    "posterUrl": posterUrl,
  };
}
