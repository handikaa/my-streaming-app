import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_streaming/app/data/local/favorite.dart';

enum SnackbarType { SUCCESS, ERROR }

class SharedMethod {
  static void snackBar({
    required String message,
    required SnackbarType type,
    String? title,
  }) {
    Get.snackbar(
      title ?? "Notification",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: type == SnackbarType.ERROR ? Colors.red : Colors.green,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static Future<void> addFavorite(FavoriteMovieEntity movie) async {
    final box = Hive.box<List>('favorites');
    final key = 'favorite_movies';

    final rawList = box.get(key, defaultValue: []) ?? [];
    final currentList = List<FavoriteMovieEntity>.from(rawList);

    bool isExist = currentList.any((item) => item.id == movie.id);
    if (!isExist) {
      currentList.add(movie);
      await box.put(key, currentList);
    }
  }

  static List<FavoriteMovieEntity> getFavoriteMovies() {
    final box = Hive.box<List>('favorites');
    final key = 'favorite_movies';

    final list = box.get(key, defaultValue: []);
    return List<FavoriteMovieEntity>.from(list ?? []);
  }

  static Future<void> removeFavorite(int movieId) async {
    final box = Hive.box<List>('favorites');
    final key = 'favorite_movies';

    final rawList = box.get(key, defaultValue: []) ?? [];
    final currentList = List<FavoriteMovieEntity>.from(rawList);

    currentList.removeWhere((item) => item.id == movieId);
    await box.put(key, currentList);
  }
}
