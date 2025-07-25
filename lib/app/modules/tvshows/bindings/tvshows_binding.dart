import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_streaming/app/data/repository/tv_shows/tv_shows_repository.dart';

import '../controllers/tvshows_controller.dart';

class TvshowsBinding extends Bindings {
  @override
  void dependencies() {
    final inject = GetIt.instance;
    Get.lazyPut<TvshowsController>(
      () => TvshowsController(
        tvShowsRepositoryImpl: TvShowsRepositoryImpl(dio: inject()),
      ),
    );
  }
}
