import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class FavoriteMovieEntity extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String posterPath;

  @HiveField(2)
  String backDropPath;

  @HiveField(3)
  int id;

  @HiveField(4)
  String mediaType;

  FavoriteMovieEntity({
    required this.name,
    required this.posterPath,
    required this.backDropPath,
    required this.id,
    required this.mediaType,
  });
}
