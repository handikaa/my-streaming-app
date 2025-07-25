import 'dart:convert';

class PeopleEntity {
  final bool? adult;
  final int? id;
  final String? name;
  final String? originalName;
  final String? mediaType;
  final double? popularity;
  final int? gender;
  final dynamic knownForDepartment;
  final String? profilePath;

  PeopleEntity({
    this.adult,
    this.id,
    this.name,
    this.originalName,
    this.mediaType,
    this.popularity,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
  });

  factory PeopleEntity.fromRawJson(String str) =>
      PeopleEntity.fromJson(json.decode(str));

  factory PeopleEntity.fromJson(Map<String, dynamic> json) => PeopleEntity(
    adult: json["adult"],
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    mediaType: json["media_type"],
    popularity: json["popularity"]?.toDouble(),
    gender: json["gender"],
    knownForDepartment: json["known_for_department"],
    profilePath: json["profile_path"],
  );
}
