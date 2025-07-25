import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_streaming/app/data/repository/trending/trending_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final inject = GetIt.instance;
    Get.lazyPut<HomeController>(
      () => HomeController(
        trendingRepositoryImpl: TrendingRepositoryImpl(dio: inject()),
      ),
    );
  }
}
