import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie/bindings/movie_binding.dart';
import '../modules/movie/views/movie_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searchfilm/bindings/searchfilm_binding.dart';
import '../modules/searchfilm/views/searchfilm_view.dart';
import '../modules/tester/bindings/tester_binding.dart';
import '../modules/tester/views/tester_view.dart';
import '../modules/tvshows/bindings/tvshows_binding.dart';
import '../modules/tvshows/views/tvshows_view.dart';
import '../modules/watch_list/bindings/watch_list_binding.dart';
import '../modules/watch_list/views/watch_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE,
      page: () => const MovieView(),
      binding: MovieBinding(),
    ),
    GetPage(
      name: _Paths.TVSHOWS,
      page: () => const TvshowsView(),
      binding: TvshowsBinding(),
    ),
    GetPage(
      name: _Paths.TESTER,
      page: () => const TesterView(),
      binding: TesterBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.WATCH_LIST,
      page: () => const WatchListView(),
      binding: WatchListBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHFILM,
      page: () => const SearchfilmView(),
      binding: SearchfilmBinding(),
    ),
  ];
}
