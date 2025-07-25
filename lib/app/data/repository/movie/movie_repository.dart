import 'package:dio/dio.dart';
import 'package:my_streaming/app/data/entity/detail_movie_entity.dart';
import 'package:my_streaming/app/data/entity/movie_entity.dart';
import 'package:my_streaming/app/data/entity/trending_entity.dart';

import '../../api/api_const.dart';
import '../../client/safe_api_call.dart';
import '../../result.dart';

abstract class MovieRepository {
  Future<Result<List<MovieEntity>>> getListMovieUpcoming();
  Future<Result<List<MovieEntity>>> getListMoviePopular();
  Future<Result<List<MovieEntity>>> getListMovieNowPlaying();
  Future<Result<List<MovieEntity>>> getListMovieTopRated();
  Future<Result<List<TrendingEntity>>> searchMovie(String queryParams);
  Future<Result<DetailMovieEntity>> getDetailtMovie(int id);
}

class MovieRepositoryImpl implements MovieRepository {
  final Dio dio;

  MovieRepositoryImpl({required this.dio});

  @override
  Future<Result<List<MovieEntity>>> getListMovieUpcoming() async {
    return safeApiCall<List<MovieEntity>>(
      request: () => dio.get(
        ApiConst.listMovieUpcoming,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => MovieEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<List<MovieEntity>>> getListMovieNowPlaying() async {
    return safeApiCall<List<MovieEntity>>(
      request: () => dio.get(
        ApiConst.listMovieNowPlaying,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => MovieEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<List<MovieEntity>>> getListMoviePopular() async {
    return safeApiCall<List<MovieEntity>>(
      request: () => dio.get(
        ApiConst.listMoviePopular,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => MovieEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<List<MovieEntity>>> getListMovieTopRated() async {
    return safeApiCall<List<MovieEntity>>(
      request: () => dio.get(
        ApiConst.listMovieTopRated,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => MovieEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<DetailMovieEntity>> getDetailtMovie(int id) async {
    return safeApiCall<DetailMovieEntity>(
      request: () => dio.get(
        "${ApiConst.detailMovie}/$id?language=en-US",

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        return DetailMovieEntity.fromJson(data);
      },
    );
  }

  @override
  Future<Result<List<TrendingEntity>>> searchMovie(String queryParams) async {
    return safeApiCall<List<TrendingEntity>>(
      request: () => dio.get(
        "${ApiConst.searchMovie}?query=$queryParams&include_adult=false&language=en-US&page=1",

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => TrendingEntity.fromJson(e)).toList();
      },
    );
  }
}
