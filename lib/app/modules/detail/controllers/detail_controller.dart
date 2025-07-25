import 'package:get/get.dart';
import 'package:my_streaming/app/component/shared_method.dart';
import 'package:my_streaming/app/data/entity/detail_movie_entity.dart';
import 'package:my_streaming/app/data/entity/detail_tv_entity.dart';
import 'package:my_streaming/app/data/local/favorite.dart';
import 'package:my_streaming/app/data/repository/movie/movie_repository.dart';
import 'package:my_streaming/app/data/repository/tv_shows/tv_shows_repository.dart';
import 'package:my_streaming/app/modules/watch_list/controllers/watch_list_controller.dart';

class DetailController extends GetxController {
  final MovieRepositoryImpl movieRepositoryImpl;
  final TvShowsRepositoryImpl tvShowsRepositoryImpl;

  final WatchListController watchListController;

  Map argument = {};

  final Rx<DetailMovieEntity?> detailMovie = Rx<DetailMovieEntity?>(null);
  final Rx<DetailTvEntity?> detailTV = Rx<DetailTvEntity?>(null);

  var isFavorite = false.obs;
  late int movieId;

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  DetailController({
    required this.tvShowsRepositoryImpl,
    required this.movieRepositoryImpl,
  }) : watchListController = Get.find<WatchListController>();

  @override
  void onInit() {
    super.onInit();
    argument = Get.arguments;

    movieId = argument['id'];
    checkIfFavorite(movieId);

    if (argument['type'] == 'tv') {
      getTVDetail();
    } else {
      getMovieDetail();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkIfFavorite(int id) {
    final favorites = SharedMethod.getFavoriteMovies();
    isFavorite.value = favorites.any((movie) => movie.id == id);
  }

  Future<void> toggleFavorite(FavoriteMovieEntity movie) async {
    final currentFavorites = SharedMethod.getFavoriteMovies();
    final isCurrentlyFavorite = currentFavorites.any(
      (item) => item.id == movie.id,
    );

    if (isCurrentlyFavorite) {
      await SharedMethod.removeFavorite(movie.id);
    } else {
      await SharedMethod.addFavorite(movie);
    }

    watchListController.loadFavoriteMovies();

    checkIfFavorite(movie.id);
  }

  Future<void> getMovieDetail() async {
    try {
      _isLoading.value = true;

      final result = await movieRepositoryImpl.getDetailtMovie(argument['id']);

      if (result.isSuccess) {
        detailMovie.value = result.resultValue;
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getTVDetail() async {
    try {
      _isLoading.value = true;

      final result = await tvShowsRepositoryImpl.getDetailTV(argument['id']);

      if (result.isSuccess) {
        detailTV.value = result.resultValue;
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading.value = false;
    }
  }
}
