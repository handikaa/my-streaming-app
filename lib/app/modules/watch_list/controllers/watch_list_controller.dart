import 'package:get/get.dart';

import '../../../component/shared_method.dart';
import '../../../data/local/favorite.dart';

class WatchListController extends GetxController {
  var favoriteMovies = <FavoriteMovieEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteMovies();
  }

  void loadFavoriteMovies() {
    final movies = SharedMethod.getFavoriteMovies();
    favoriteMovies.value = movies;
  }

  void removeFromFavorite(int movieId) async {
    await SharedMethod.removeFavorite(movieId);
    loadFavoriteMovies();
  }
}
