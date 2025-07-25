import 'package:get_it/get_it.dart';

import 'package:my_streaming/app/data/repository/movie/movie_repository.dart';
import 'package:my_streaming/app/data/repository/tv_shows/tv_shows_repository.dart';

import '../client/client.dart';

final inject = GetIt.instance;

Future<void> init(String baseUrl) async {
  //Remote
  inject.registerLazySingleton(() => DioClient(baseUrl));
  inject.registerLazySingleton(() => inject<DioClient>().dio);
  inject.registerLazySingleton(() => MovieRepositoryImpl(dio: inject()));
  inject.registerLazySingleton(() => TvShowsRepositoryImpl(dio: inject()));
}
