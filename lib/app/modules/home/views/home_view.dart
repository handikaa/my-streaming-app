import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_streaming/app/data/entity/trending_entity.dart';
import 'package:my_streaming/app/routes/app_pages.dart';
import 'package:my_streaming/app/widget/card/layout_two.dart';

import '../../../component/spacing.dart';
import '../../../component/text.dart';
import '../../../widget/card/layout_one.dart';
import '../../../widget/card/movie_card.dart';
import '../../../widget/card/popular_people.dart';
import '../../../widget/shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1B20),
      body: Obx(() {
        if (controller.isLoading) {
          return SquareShimmerLoading();
        }

        return ListView(
          children: [
            verticalSpace(7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'On Trending', fontWeight: FontWeight.bold),
              ],
            ),
            verticalSpace(10),
            CarouselSlider(
              options: CarouselOptions(
                height: 280,
                autoPlay: true,
                viewportFraction: 0.48,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  controller.currentIndex.value = index;
                },
              ),
              items: controller.listAllTrending.map((movie) {
                String title = "Masuk";
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.DETAIL,
                      arguments: {'id': movie.id, 'type': movie.mediaType},
                    );
                  },
                  child: MovieCard(title: title, imageUrl: movie.posterPath),
                );
              }).toList(),
            ),

            Obx(() {
              final currentMovie =
                  controller.listAllTrending[controller.currentIndex.value];
              return Text(
                currentMovie.name ?? currentMovie.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,

                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              );
            }),

            verticalSpace(40),
            LayoutOne<TrendingEntity>(
              items: controller.listMovieTrending.toList(),
              itemToName: (item) => item.title ?? item.name ?? 'Unknown',
              itemToId: (item) => item.id,

              onItemTap: (id) {
                print("Item tapped: $id");

                Get.toNamed(
                  Routes.DETAIL,
                  arguments: {'id': id, 'type': 'movie'},
                );
              },
              title: "Movie Trending",
              itemToImageUrl: (TrendingEntity item) => item.posterPath ?? "",
            ),
            verticalSpace(16),
            LayoutTwo<TrendingEntity>(
              items: controller.listTvTrending.toList(),
              itemToName: (item) => item.title ?? item.name ?? 'Unknown',
              itemToVoteAverage: (item) {
                final vote = item.voteAverage;
                return vote != null ? vote.toStringAsFixed(2) : "0.00";
              },

              itemToId: (item) => item.id,
              onItemTap: (id) {
                print("Item tapped: $id");

                Get.toNamed(Routes.DETAIL, arguments: {'id': id, 'type': 'tv'});
              },
              title: "TV Series Trending",
              itemToReleaseDate: (item) {
                final date = item.releaseDate ?? item.firstAirDate;
                return date != null ? date.year.toString() : "";
              },

              itemToImageUrl: (TrendingEntity item) => item.posterPath ?? "",
              itemToFirstImageUrl: (TrendingEntity item) =>
                  item.backdropPath ?? "",
            ),
            verticalSpace(16),

            PopularPeople(listData: controller.listPopularPeople),
            verticalSpace(32),
          ],
        );
      }),
    );
  }

  SliverAppBar homeAppbar({
    required bool useSearch,
    required Widget banner,
    String? titleText,
    double? expandedHeight,
  }) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: true,
      expandedHeight: expandedHeight,
      toolbarHeight: 25,
      centerTitle: true,
      title: useSearch
          ? Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search movie...",
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
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

  Stack bannerMovieRecomended() {
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

          items: controller.bannerImages.map((imgPath) {
            return Stack(
              children: [
                Image.asset(
                  imgPath,
                  width: 1.sw,
                  height: 400.h,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 1.sw,
                  height: 400.h,
                  color: Colors.black.withOpacity(0.4), // Overlay hitam 30%
                ),
              ],
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
                controller.bannerImages.length,
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
