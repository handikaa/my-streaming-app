import 'dart:convert';

class TrendingEntity {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final String? originalLanguage;
  final List<int>? genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final DateTime? firstAirDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  TrendingEntity({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.firstAirDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory TrendingEntity.fromRawJson(String str) =>
      TrendingEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrendingEntity.fromJson(Map<String, dynamic> json) {
    return TrendingEntity(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      name: json['name'],
      originalName: json['original_name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      originalLanguage: json['original_language'],
      genreIds: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'])
          : [],
      popularity: (json['popularity'] as num?)?.toDouble(),
      releaseDate: json['release_date'] != null && json['release_date'] != ''
          ? DateTime.tryParse(json['release_date'])
          : null,
      firstAirDate:
          json['first_air_date'] != null && json['first_air_date'] != ''
          ? DateTime.tryParse(json['first_air_date'])
          : null,
      video: json['video'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "name": name,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaType,
    "original_language": originalLanguage,
    "genre_ids": genreIds == null
        ? []
        : List<dynamic>.from(genreIds!.map((x) => x)),
    "popularity": popularity,
    "release_date":
        "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "first_air_date":
        "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
