import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_streaming/app/data/repository/movie/movie_repository.dart';
import 'package:my_streaming/app/data/repository/tv_shows/tv_shows_repository.dart';

import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    final inject = GetIt.instance;
    Get.lazyPut<DetailController>(
      () => DetailController(
        tvShowsRepositoryImpl: TvShowsRepositoryImpl(dio: inject()),
        movieRepositoryImpl: MovieRepositoryImpl(dio: inject()),
      ),
    );
  }
}
