import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_streaming/app/component/shared_method.dart';
import 'package:my_streaming/app/data/repository/movie/movie_repository.dart';
import 'package:my_streaming/app/data/repository/tv_shows/tv_shows_repository.dart';

import '../../../data/entity/trending_entity.dart';

class SearchfilmController extends GetxController {
  final MovieRepositoryImpl movieRepositoryImpl;
  final TvShowsRepositoryImpl tvShowsRepositoryImpl;

  final searchController = TextEditingController();
  final focusNode = FocusNode();

  RxList<TrendingEntity> searchResult = <TrendingEntity>[].obs;

  String argument = '';

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  late final bool isTvSearch;

  SearchfilmController({
    required this.tvShowsRepositoryImpl,
    required this.movieRepositoryImpl,
  });

  @override
  void onInit() {
    super.onInit();
    argument = Get.arguments;
    final args = Get.arguments;
    isTvSearch = args == 'tv';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> search() async {
    try {
      _isLoading.value = true;

      String query = searchController.text.trim();
      query = query.replaceAll(RegExp(r"\s+"), "%20");

      final result = isTvSearch
          ? await tvShowsRepositoryImpl.searchTvSeries(query)
          : await movieRepositoryImpl.searchMovie(query);

      if (result.isSuccess) {
        searchResult.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoading.value = false;
    }
  }
}
