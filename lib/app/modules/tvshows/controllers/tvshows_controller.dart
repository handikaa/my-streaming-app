import 'package:get/get.dart';

import '../../../component/shared_method.dart';
import '../../../data/entity/tv_series_entity.dart';
import '../../../data/repository/tv_shows/tv_shows_repository.dart';

class TvshowsController extends GetxController {
  final TvShowsRepositoryImpl tvShowsRepositoryImpl;

  RxList<TvSeriesEntity> listTvOnAir = <TvSeriesEntity>[].obs;
  RxList<TvSeriesEntity> listTvAiring = <TvSeriesEntity>[].obs;
  RxList<TvSeriesEntity> listTvPopular = <TvSeriesEntity>[].obs;
  RxList<TvSeriesEntity> listTvToprated = <TvSeriesEntity>[].obs;

  TvshowsController({required this.tvShowsRepositoryImpl});

  final count = 0.obs;
  RxInt currentIndex = 0.obs;

  final _isLoadingTopRated = false.obs;
  final _isLoadingOnAir = false.obs;
  final _isLoadingPopular = false.obs;
  final _isLoadingAiring = false.obs;

  bool get isLoading =>
      _isLoadingOnAir.value ||
      _isLoadingPopular.value ||
      _isLoadingAiring.value ||
      _isLoadingTopRated.value;

  @override
  void onInit() {
    super.onInit();
    getListTvOnAir();
    getListTvAiring();
    getListTvPopular();
    getListTvTopRated();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListTvOnAir() async {
    try {
      _isLoadingOnAir.value = true;

      final result = await tvShowsRepositoryImpl.getListOnAir();

      if (result.isSuccess) {
        listTvOnAir.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingOnAir.value = false;
    }
  }

  Future<void> getListTvAiring() async {
    try {
      _isLoadingAiring.value = true;

      final result = await tvShowsRepositoryImpl.getListAiringToday();

      if (result.isSuccess) {
        listTvAiring.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingAiring.value = false;
    }
  }

  Future<void> getListTvPopular() async {
    try {
      _isLoadingPopular.value = true;

      final result = await tvShowsRepositoryImpl.getListPopularTV();

      if (result.isSuccess) {
        listTvPopular.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingPopular.value = false;
    }
  }

  Future<void> getListTvTopRated() async {
    try {
      _isLoadingTopRated.value = true;

      final result = await tvShowsRepositoryImpl.getListTopRatedTV();

      if (result.isSuccess) {
        listTvToprated.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      SharedMethod.snackBar(message: e.toString(), type: SnackbarType.ERROR);
    } finally {
      _isLoadingTopRated.value = false;
    }
  }
}
