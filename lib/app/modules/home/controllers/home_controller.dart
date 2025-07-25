import 'package:get/get.dart';
import 'package:my_streaming/app/component/assets.dart';
import 'package:my_streaming/app/component/shared_method.dart';
import 'package:my_streaming/app/data/entity/people_entity.dart';
import 'package:my_streaming/app/data/entity/trending_entity.dart';
import 'package:my_streaming/app/data/repository/trending/trending_repository.dart';

class HomeController extends GetxController {
  final TrendingRepositoryImpl trendingRepositoryImpl;

  RxList<TrendingEntity> listAllTrending = <TrendingEntity>[].obs;
  RxList<TrendingEntity> listMovieTrending = <TrendingEntity>[].obs;
  RxList<TrendingEntity> listTvTrending = <TrendingEntity>[].obs;
  RxList<PeopleEntity> listPopularPeople = <PeopleEntity>[].obs;

  final RxInt selectedCategory = 0.obs;
  RxInt currentIndex = 0.obs;

  final _isLoadingAll = false.obs;
  final _isLoadingMovie = false.obs;
  final _isLoadingTV = false.obs;
  final _isLoadingPeople = false.obs;

  bool get isLoading =>
      _isLoadingAll.value ||
      _isLoadingMovie.value ||
      _isLoadingTV.value ||
      _isLoadingPeople.value;

  final List<String> bannerImages = [
    Assets.sample,
    Assets.sample,
    Assets.sample,
  ];

  List<Map> dataMovie = [
    {'title': 'Avatar AvatarAvatarAvatar', 'img': Assets.sample},
    {'title': 'Marvel', 'img': Assets.sample},
    {'title': 'Transfomers', 'img': Assets.sample},
  ];

  final List<String> movieTitles = List.generate(10, (index) => 'Movie $index');

  HomeController({required this.trendingRepositoryImpl});

  @override
  void onInit() {
    super.onInit();
    getAllTrending();
    getMovieTrending();
    getTVTrending();
    getPopularPeople();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllTrending() async {
    try {
      _isLoadingAll.value = true;

      final result = await trendingRepositoryImpl.getAllTrending();

      if (result.isSuccess) {
        listAllTrending.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoadingAll.value = false;
    }
  }

  Future<void> getMovieTrending() async {
    try {
      _isLoadingMovie.value = true;

      final result = await trendingRepositoryImpl.getMovieTrending();

      if (result.isSuccess) {
        listMovieTrending.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoadingMovie.value = false;
    }
  }

  Future<void> getTVTrending() async {
    try {
      _isLoadingTV.value = true;

      final result = await trendingRepositoryImpl.getTVTrending();

      if (result.isSuccess) {
        listTvTrending.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoadingTV.value = false;
    }
  }

  Future<void> getPopularPeople() async {
    try {
      _isLoadingPeople.value = true;

      final result = await trendingRepositoryImpl.getPopularPeople();

      if (result.isSuccess) {
        listPopularPeople.assignAll(result.resultValue ?? []);
      } else {
        SharedMethod.snackBar(
          message: result.errorMessage!,
          type: SnackbarType.ERROR,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoadingPeople.value = false;
    }
  }
}
