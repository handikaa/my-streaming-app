import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../component/colors.dart';
import '../../../component/shared_method.dart';
import '../../../component/spacing.dart';
import '../../../component/text.dart';
import '../../../data/api/api_const.dart';
import '../../../data/entity/detail_movie_entity.dart';
import '../../../data/local/favorite.dart';
import '../../../data/repository/movie/movie_repository.dart';
import '../../../data/repository/tv_shows/tv_shows_repository.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final inject = GetIt.instance;
    return GetBuilder(
      init: DetailController(
        tvShowsRepositoryImpl: TvShowsRepositoryImpl(dio: inject()),
        movieRepositoryImpl: MovieRepositoryImpl(dio: inject()),
      ),
      builder: (context) {
        return Scaffold(
          backgroundColor: Color(0xff1D1B20),

          body: Obx(() {
            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final type = controller.argument['type'];

            if (type == 'tv') {
              final data = controller.detailTV.value;

              // Cek null
              if (data == null) {
                return Center(child: Text('Gagal memuat data TV'));
              }

              final year = data.firstAirDate?.year.toString() ?? '';

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 200,
                    toolbarHeight: 60,
                    centerTitle: true,
                    actions: [
                      Obx(() {
                        final movie = FavoriteMovieEntity(
                          id: data.id!,
                          name: data.name ?? "",
                          posterPath: data.posterPath ?? "",
                          backDropPath: data.backdropPath ?? "",
                          mediaType: "tv", // atau "movie" tergantung argumen
                        );

                        return IconButton(
                          onPressed: () => controller.toggleFavorite(movie),
                          icon: Icon(
                            Icons.favorite,
                            color: controller.isFavorite.value
                                ? Colors.red
                                : Colors.white,
                          ),
                        );
                      }),
                    ],
                    leading: SafeArea(
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    flexibleSpace: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "${ApiConst.baseImage}${data.backdropPath}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () => SharedMethod.snackBar(
                                message: "Video not Found",
                                type: SnackbarType.ERROR,
                              ),
                              icon: Icon(
                                Icons.play_arrow,
                                color: CustomColors.greenSysDarkOnPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(child: verticalSpace(16)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200.h,
                                width: 170,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${ApiConst.baseImage}${data.posterPath}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              horizontalSpace(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    CustomText(
                                      text: data.name ?? "",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    verticalSpace(12),
                                    CustomText(
                                      text: "IMDB ${data.voteAverage}",
                                      fontSize: 13,
                                    ),
                                    verticalSpace(12),
                                    Wrap(
                                      spacing: 6.0,
                                      runSpacing: 4.0,
                                      children:
                                          data.genres != null &&
                                              data.genres!.isNotEmpty
                                          ? data.genres!
                                                .map(
                                                  (genre) => CustomText(
                                                    text: genre.name ?? "",
                                                    fontSize: 13,
                                                  ),
                                                )
                                                .toList()
                                          : [
                                              CustomText(
                                                text: "",
                                                fontSize: 13,
                                              ),
                                            ],
                                    ),

                                    verticalSpace(12),
                                    CustomText(text: year, fontSize: 13),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          CustomText(text: data.overview ?? "", fontSize: 13),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            final data = controller.detailMovie.value;

            if (data == null) {
              return const Center(
                child: CustomText(text: "Error", color: Colors.white),
              );
            }

            final year = data.releaseDate?.year.toString() ?? '';
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 200,
                  toolbarHeight: 60,
                  actions: [
                    Obx(() {
                      final movie = FavoriteMovieEntity(
                        id: data.id!,
                        name: data.title ?? "",
                        posterPath: data.posterPath ?? "",
                        backDropPath: data.backdropPath ?? "",
                        mediaType: "movie",
                      );

                      return IconButton(
                        onPressed: () => controller.toggleFavorite(movie),
                        icon: Icon(
                          Icons.favorite,
                          color: controller.isFavorite.value
                              ? Colors.red
                              : Colors.white,
                        ),
                      );
                    }),
                  ],
                  centerTitle: true,
                  leading: SafeArea(
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "${ApiConst.baseImage}${data.backdropPath}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () => SharedMethod.snackBar(
                              message: "Video not Found",
                              type: SnackbarType.ERROR,
                            ),
                            icon: Icon(
                              Icons.play_arrow,
                              color: CustomColors.greenSysDarkOnPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: verticalSpace(16)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200.h,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "${ApiConst.baseImage}${data.posterPath}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            horizontalSpace(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  CustomText(
                                    text: data.title ?? "",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  verticalSpace(12),
                                  CustomText(
                                    text: "IMDB ${data.voteAverage}",
                                    fontSize: 13,
                                  ),
                                  verticalSpace(12),
                                  Wrap(
                                    spacing: 6.0,
                                    runSpacing: 4.0,
                                    children:
                                        data.genres != null &&
                                            data.genres!.isNotEmpty
                                        ? data.genres!
                                              .map(
                                                (genre) => CustomText(
                                                  text: genre.name ?? "",
                                                  fontSize: 13,
                                                ),
                                              )
                                              .toList()
                                        : [CustomText(text: "", fontSize: 13)],
                                  ),

                                  verticalSpace(12),
                                  CustomText(text: year, fontSize: 13),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        CustomText(text: data.overview ?? "", fontSize: 13),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
