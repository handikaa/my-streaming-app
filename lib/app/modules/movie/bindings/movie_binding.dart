import 'package:get/get.dart';

import 'package:get_it/get_it.dart';
import 'package:my_streaming/app/data/repository/movie/movie_repository.dart';

import '../controllers/movie_controller.dart';

class MovieBinding extends Bindings {
  @override
  void dependencies() {
    final inject = GetIt.instance;
    Get.lazyPut<MovieController>(
      () => MovieController(
        movieRepositoryImpl: MovieRepositoryImpl(dio: inject()),
      ),
    );
  }
}
