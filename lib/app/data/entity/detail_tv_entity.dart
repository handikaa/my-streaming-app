import 'dart:convert';

class DetailTvEntity {
  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? createdBy;

  final DateTime? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;

  final String? name;

  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;

  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  DetailTvEntity({
    this.adult,
    this.backdropPath,
    this.createdBy,

    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,

    this.name,

    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  factory DetailTvEntity.fromRawJson(String str) =>
      DetailTvEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailTvEntity.fromJson(Map<String, dynamic> json) => DetailTvEntity(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    createdBy: json["created_by"] == null
        ? []
        : List<dynamic>.from(json["created_by"]!.map((x) => x)),

    firstAirDate: json['first_air_date'] != null && json['first_air_date'] != ''
        ? DateTime.tryParse(json['first_air_date'])
        : null,

    genres: json["genres"] == null
        ? []
        : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    languages: json["languages"] == null
        ? []
        : List<String>.from(json["languages"]!.map((x) => x)),

    lastAirDate: json['last_air_date'] != null && json['last_air_date'] != ''
        ? DateTime.tryParse(json['last_air_date'])
        : null,
    name: json["name"],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originCountry: json["origin_country"] == null
        ? []
        : List<String>.from(json["origin_country"]!.map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "created_by": createdBy == null
        ? []
        : List<dynamic>.from(createdBy!.map((x) => x)),

    "first_air_date":
        "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "genres": genres == null
        ? []
        : List<dynamic>.from(genres!.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": languages == null
        ? []
        : List<dynamic>.from(languages!.map((x) => x)),
    "last_air_date":
        "${lastAirDate!.year.toString().padLeft(4, '0')}-${lastAirDate!.month.toString().padLeft(2, '0')}-${lastAirDate!.day.toString().padLeft(2, '0')}",

    "name": name,

    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": originCountry == null
        ? []
        : List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,

    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class Season {
  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final int? voteAverage;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  factory Season.fromRawJson(String str) => Season.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    voteAverage: json["vote_average"],
  );

  Map<String, dynamic> toJson() => {
    "air_date":
        "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
    "vote_average": voteAverage,
  };
}

class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromRawJson(String str) =>
      SpokenLanguage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"],
    iso6391: json["iso_639_1"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}
