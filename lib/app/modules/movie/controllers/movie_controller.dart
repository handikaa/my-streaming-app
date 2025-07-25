import 'package:get/get.dart';
import 'package:my_streaming/app/data/entity/movie_entity.dart';
import 'package:my_streaming/app/data/repository/movie/movie_repository.dart';

import '../../../component/assets.dart';
import '../../../component/shared_method.dart';

class MovieController extends GetxController {
  final MovieRepositoryImpl movieRepositoryImpl;

  final RxInt selectedCategory = 0.obs;
  RxInt currentIndex = 0.obs;

  RxList<MovieEntity> listMovieUpcoming = <MovieEntity>[].obs;
  RxList<MovieEntity> listMoviePopular = <MovieEntity>[].obs;
  RxList<MovieEntity> listMovieNowPlaying = <MovieEntity>[].obs;
  RxList<MovieEntity> listMovieTopRated = <MovieEntity>[].obs;

  final List<String> bannerImages = [
    Assets.sample,
    Assets.sample,
    Assets.sample,
  ];

  final _isLoadingUpcoming = false.obs;
  final _isLoadingPopular = false.obs;
  final _isLoadingNowPlaying = false.obs;
  final _isLoadingTopRated = false.obs;

  bool get isLoading =>
      _isLoadingUpcoming.value ||
      _isLoadingPopular.value ||
      _isLoadingNowPlaying.value ||
      _isLoadingTopRated.value;

  final List<String> movieTitles = List.generate(10, (index) => 'Movie $index');
  final count = 0.obs;

  MovieController({required this.movieRepositoryImpl});
  @override
  void onInit() {
    super.onInit();
    getListMovieUpcoming();
    getListMovieNowPlaying();
    getListMoviePopular();
    getListMovieTopRated();
  }

  Future<void> getListMovieUpcoming() async {
    try {
      _isLoadingUpcoming.value = true;

      final result = await movieRepositoryImpl.getListMovieUpcoming();

      if (result.isSuccess) {
        listMovieUpcoming.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingUpcoming.value = false;
    }
  }

  Future<void> getListMoviePopular() async {
    try {
      _isLoadingPopular.value = true;

      final result = await movieRepositoryImpl.getListMoviePopular();

      if (result.isSuccess) {
        listMoviePopular.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingPopular.value = false;
    }
  }

  Future<void> getListMovieNowPlaying() async {
    try {
      _isLoadingNowPlaying.value = true;

      final result = await movieRepositoryImpl.getListMovieNowPlaying();

      if (result.isSuccess) {
        listMovieNowPlaying.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingNowPlaying.value = false;
    }
  }

  Future<void> getListMovieTopRated() async {
    try {
      _isLoadingTopRated.value = true;

      final result = await movieRepositoryImpl.getListMovieTopRated();

      if (result.isSuccess) {
        listMovieTopRated.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingTopRated.value = false;
    }
  }
}
