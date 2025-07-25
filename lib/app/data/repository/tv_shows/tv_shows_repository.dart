import 'package:dio/dio.dart';
import 'package:my_streaming/app/data/entity/detail_tv_entity.dart';
import 'package:my_streaming/app/data/entity/trending_entity.dart';
import 'package:my_streaming/app/data/entity/tv_series_entity.dart';
import 'package:my_streaming/app/data/result.dart';

import '../../api/api_const.dart';
import '../../client/safe_api_call.dart';

abstract class TvShowsRepository {
  Future<Result<List<TvSeriesEntity>>> getListOnAir();
  Future<Result<List<TvSeriesEntity>>> getListAiringToday();
  Future<Result<List<TvSeriesEntity>>> getListPopularTV();
  Future<Result<List<TvSeriesEntity>>> getListTopRatedTV();
  Future<Result<List<TrendingEntity>>> searchTvSeries(String query);
  Future<Result<DetailTvEntity>> getDetailTV(int id);
}

class TvShowsRepositoryImpl implements TvShowsRepository {
  final Dio dio;

  TvShowsRepositoryImpl({required this.dio});

  @override
  Future<Result<List<TvSeriesEntity>>> getListOnAir() async {
    return safeApiCall<List<TvSeriesEntity>>(
      request: () => dio.get(
        ApiConst.listTvOnAir,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => TvSeriesEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<List<TvSeriesEntity>>> getListAiringToday() async {
    return safeApiCall<List<TvSeriesEntity>>(
      request: () => dio.get(
        ApiConst.listTvAiring,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => TvSeriesEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<List<TvSeriesEntity>>> getListPopularTV() async {
    return safeApiCall<List<TvSeriesEntity>>(
      request: () => dio.get(
        ApiConst.listTvPopular,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => TvSeriesEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<List<TvSeriesEntity>>> getListTopRatedTV() async {
    return safeApiCall<List<TvSeriesEntity>>(
      request: () => dio.get(
        ApiConst.listTvTopRated,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => TvSeriesEntity.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<DetailTvEntity>> getDetailTV(int id) async {
    return safeApiCall<DetailTvEntity>(
      request: () => dio.get(
        "${ApiConst.detailTV}/$id",

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        return DetailTvEntity.fromJson(data);
      },
    );
  }

  @override
  Future<Result<List<TrendingEntity>>> searchTvSeries(String query) async {
    return safeApiCall<List<TrendingEntity>>(
      request: () => dio.get(
        "${ApiConst.searchTv}?query=$query&include_adult=false&language=en-US&page=1",

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
