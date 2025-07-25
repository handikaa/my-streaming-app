import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_streaming/app/data/entity/tv_series_entity.dart';

import '../../../component/spacing.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/card/layout_one.dart';
import '../../../widget/card/layout_two.dart';
import '../../../widget/card/tv_series_card.dart';
import '../../../widget/shimmer/shimmer.dart';
import '../controllers/tvshows_controller.dart';

class TvshowsView extends GetView<TvshowsController> {
  const TvshowsView({super.key});
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
            verticalSpace(16),
            InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Get.toNamed(Routes.SEARCHFILM, arguments: 'tv');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15),
                margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
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
                      "Search TV Series...",
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(16),
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                viewportFraction: 0.9,
                enableInfiniteScroll: true,

                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  controller.currentIndex.value = index;
                },
              ),
              items: controller.listTvOnAir.map((movie) {
                String title = "Masuk";
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.DETAIL,
                        arguments: {'id': movie.id, 'type': 'tv'},
                      );
                    },
                    child: TvSeriesCard(
                      title: title,
                      imageUrl: movie.backdropPath,
                    ),
                  ),
                );
              }).toList(),
            ),
            verticalSpace(16),
            LayoutTwo<TvSeriesEntity>(
              items: controller.listTvAiring.toList(),
              itemToName: (item) => item.name ?? 'Unknown',
              itemToVoteAverage: (item) {
                final vote = item.voteAverage;
                return vote != null ? vote.toStringAsFixed(2) : "0.00";
              },

              itemToId: (item) => item.id,
              onItemTap: (id) {
                print("Item tapped: $id");
                Get.toNamed(Routes.DETAIL, arguments: {'id': id, 'type': 'tv'});
              },
              title: "Airing Today",
              itemToReleaseDate: (item) {
                final date = item.firstAirDate;
                return date != null ? date.year.toString() : "";
              },

              itemToImageUrl: (TvSeriesEntity item) => item.posterPath ?? "",
              itemToFirstImageUrl: (TvSeriesEntity item) =>
                  item.backdropPath ?? "",
            ),
            verticalSpace(16),
            LayoutTwo<TvSeriesEntity>(
              items: controller.listTvPopular.toList(),
              itemToName: (item) => item.name ?? 'Unknown',
              itemToVoteAverage: (item) {
                final vote = item.voteAverage;
                return vote != null ? vote.toStringAsFixed(2) : "0.00";
              },

              itemToId: (item) => item.id,
              onItemTap: (id) {
                print("Item tapped: $id");
                Get.toNamed(Routes.DETAIL, arguments: {'id': id, 'type': 'tv'});
              },
              title: "Popular",
              itemToReleaseDate: (item) {
                final date = item.firstAirDate;
                return date != null ? date.year.toString() : "";
              },

              itemToImageUrl: (TvSeriesEntity item) => item.posterPath ?? "",
              itemToFirstImageUrl: (TvSeriesEntity item) =>
                  item.backdropPath ?? "",
            ),

            verticalSpace(16),
            LayoutOne<TvSeriesEntity>(
              items: controller.listTvToprated.toList(),
              itemToName: (item) => item.name ?? 'Unknown',
              itemToId: (item) => item.id,
              onItemTap: (id) {
                print("Item tapped: $id");
                Get.toNamed(Routes.DETAIL, arguments: {'id': id, 'type': 'tv'});
              },
              title: "Upcoming",
              itemToImageUrl: (TvSeriesEntity item) => item.posterPath ?? "",
            ),

            verticalSpace(32),
          ],
        );
      }),
    );
  }
}
