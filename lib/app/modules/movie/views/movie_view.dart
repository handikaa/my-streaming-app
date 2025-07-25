import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_streaming/app/data/api/api_const.dart';
import 'package:my_streaming/app/data/entity/movie_entity.dart';
import 'package:my_streaming/app/routes/app_pages.dart';

import '../../../component/spacing.dart';
import '../../../component/text.dart';
import '../../../widget/card/layout_one.dart';
import '../../../widget/card/layout_two.dart';
import '../../../widget/shimmer/shimmer.dart';
import '../controllers/movie_controller.dart';

class MovieView extends GetView<MovieController> {
  const MovieView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1B20),
      body: Obx(() {
        if (controller.isLoading) {
          return SquareShimmerLoading();
        }

        return CustomScrollView(
          slivers: [
            movieAppbar(
              useSearch: true,
              banner: bannerMovie(controller),
              expandedHeight: 450,
              ctx: context,
            ),

            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                color: Color(0xff1D1B20),
                child: Column(
                  children: [
                    LayoutOne<MovieEntity>(
                      items: controller.listMovieNowPlaying.toList(),
                      itemToName: (item) =>
                          item.title ?? item.title ?? 'Unknown',
                      itemToId: (item) => item.id,
                      onItemTap: (id) {
                        print("Item tapped: $id");
                        Get.toNamed(
                          Routes.DETAIL,
                          arguments: {'id': id, 'type': 'movie'},
                        );
                      },
                      title: "Now Playing",
                      itemToImageUrl: (MovieEntity item) =>
                          item.posterPath ?? "",
                    ),
                    verticalSpace(16),
                    LayoutTwo<MovieEntity>(
                      items: controller.listMoviePopular.toList(),
                      itemToName: (item) =>
                          item.title ?? item.title ?? 'Unknown',
                      itemToVoteAverage: (item) {
                        final vote = item.voteAverage;
                        return vote != null ? vote.toStringAsFixed(2) : "0.00";
                      },

                      itemToId: (item) => item.id,
                      onItemTap: (id) {
                        print("Item tapped: $id");
                        Get.toNamed(
                          Routes.DETAIL,
                          arguments: {'id': id, 'type': 'movie'},
                        );
                      },
                      title: "Popular",
                      itemToReleaseDate: (item) {
                        final date = item.releaseDate;
                        return date != null ? date.year.toString() : "";
                      },

                      itemToImageUrl: (MovieEntity item) =>
                          item.posterPath ?? "",
                      itemToFirstImageUrl: (MovieEntity item) =>
                          item.backdropPath ?? "",
                    ),
                    verticalSpace(16),
                    LayoutOne<MovieEntity>(
                      items: controller.listMovieUpcoming.toList(),
                      itemToName: (item) =>
                          item.title ?? item.title ?? 'Unknown',
                      itemToId: (item) => item.id,
                      onItemTap: (id) {
                        print("Item tapped: $id");
                        Get.toNamed(
                          Routes.DETAIL,
                          arguments: {'id': id, 'type': 'movie'},
                        );
                      },
                      title: "Upcoming",
                      itemToImageUrl: (MovieEntity item) =>
                          item.posterPath ?? "",
                    ),
                    verticalSpace(16),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  SliverAppBar movieAppbar({
    required bool useSearch,
    required Widget banner,
    required BuildContext ctx,
    String? titleText,
    double? expandedHeight,
  }) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: true,
      expandedHeight: expandedHeight,
      toolbarHeight: 60,
      centerTitle: true,
      title: useSearch
          ? Column(
              children: [
                verticalSpace(12),
                InkWell(
                  onTap: () {
                    FocusScope.of(ctx).requestFocus(FocusNode());
                    Get.toNamed(Routes.SEARCHFILM, arguments: 'movie');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15,
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          "Search movie...",
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : CustomText(
              text: titleText ?? "",
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
      flexibleSpace: banner,

      //  bannerMovieRecomended(),
    );
  }

  Stack bannerMovie(MovieController controller) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400.h,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              controller.currentIndex.value = index;
            },
          ),

          items: controller.listMovieTopRated.map((movie) {
            return InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.DETAIL,
                  arguments: {'id': movie.id, 'type': 'movie'},
                );
              },
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        "${ApiConst.baseImage}${movie.posterPath}",
                        width: 1.sw,
                        height: 400.h,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 1.sw,
                        height: 400.h,
                        color: Colors.black.withOpacity(
                          0.4,
                        ), // Overlay hitam 30%
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Color.fromARGB(201, 29, 27, 32),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        Obx(() {
          return Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.listMovieTopRated.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.currentIndex.value == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class LayoutThree extends StatelessWidget {
  const LayoutThree({super.key, required this.controller});

  final MovieController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [CustomText(text: "Upcoming")]),
        verticalSpace(8),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.movieTitles.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              return Container(
                width: 140.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.all(12.w),
                child: Center(
                  child: Text(
                    controller.movieTitles[index],
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
