import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_streaming/app/data/repository/movie/movie_repository.dart';
import 'package:my_streaming/app/data/repository/tv_shows/tv_shows_repository.dart';

import '../controllers/searchfilm_controller.dart';

class SearchfilmBinding extends Bindings {
  @override
  void dependencies() {
    final inject = GetIt.instance;
    Get.lazyPut<SearchfilmController>(
      () => SearchfilmController(
        tvShowsRepositoryImpl: TvShowsRepositoryImpl(dio: inject()),
        movieRepositoryImpl: MovieRepositoryImpl(dio: inject()),
      ),
    );
  }
}
