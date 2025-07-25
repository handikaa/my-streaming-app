import 'package:dio/dio.dart';
import 'package:my_streaming/app/data/api/api_const.dart';
import 'package:my_streaming/app/data/entity/people_entity.dart';
import 'package:my_streaming/app/data/entity/trending_entity.dart';

import '../../client/safe_api_call.dart';
import '../../result.dart';

abstract class TrendingRepository {
  Future<Result<List<TrendingEntity>>> getAllTrending();
  Future<Result<List<TrendingEntity>>> getMovieTrending();
  Future<Result<List<TrendingEntity>>> getTVTrending();
  Future<Result<List<PeopleEntity>>> getPopularPeople();
}

class TrendingRepositoryImpl implements TrendingRepository {
  final Dio dio;

  TrendingRepositoryImpl({required this.dio});

  @override
  Future<Result<List<TrendingEntity>>> getAllTrending() async {
    return safeApiCall<List<TrendingEntity>>(
      request: () => dio.get(
        ApiConst.allTrending,

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

  @override
  Future<Result<List<TrendingEntity>>> getMovieTrending() async {
    return safeApiCall<List<TrendingEntity>>(
      request: () => dio.get(
        ApiConst.movieTrending,

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

  @override
  Future<Result<List<TrendingEntity>>> getTVTrending() async {
    return safeApiCall<List<TrendingEntity>>(
      request: () => dio.get(
        ApiConst.tVTrending,

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

  @override
  Future<Result<List<PeopleEntity>>> getPopularPeople() async {
    return safeApiCall<List<PeopleEntity>>(
      request: () => dio.get(
        ApiConst.peopleTrending,

        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiConst.tkn}',
            "Accept": "application/json",
          },
        ),
      ),
      parse: (data) {
        final list = List<Map<String, dynamic>>.from(data['results']);
        return list.map((e) => PeopleEntity.fromJson(e)).toList();
      },
    );
  }
}
