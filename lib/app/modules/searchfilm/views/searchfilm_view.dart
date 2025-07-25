import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:my_streaming/app/component/spacing.dart';
import 'package:my_streaming/app/component/text.dart';
import 'package:my_streaming/app/data/api/api_const.dart';
import 'package:my_streaming/app/routes/app_pages.dart';

import '../controllers/searchfilm_controller.dart';

class SearchfilmView extends GetView<SearchfilmController> {
  const SearchfilmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1B20),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: CustomText(
          text: 'Search',
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1D1B20),
      ),
      body: ListView(
        children: [
          verticalSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
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
            child: TextField(
              focusNode: controller.focusNode,
              controller: controller.searchController,
              onSubmitted: (value) => controller.search(),
              decoration: InputDecoration(
                hintText: "Search TV Series...",
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          verticalSpace(12),

          Obx(() {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.searchResult.isEmpty) {
              return Center(
                child: Text(
                  controller.isTvSearch
                      ? "TV Series Not Found"
                      : "Movie Not Found",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(controller.searchResult.length, (
                  index,
                ) {
                  final data = controller.searchResult[index];

                  final displayTitle = controller.isTvSearch
                      ? data.name ?? ''
                      : data.title ?? '';

                  final year = controller.isTvSearch
                      ? (data.firstAirDate != null
                            ? data.firstAirDate!.year.toString()
                            : "Unknown")
                      : (data.releaseDate != null
                            ? data.releaseDate!.year.toString()
                            : "Unknown");

                  final poster = data.posterPath ?? "";

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.DETAIL,
                          arguments: {
                            'id': data.id,
                            'type': controller.argument,
                          },
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 170,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "${ApiConst.baseImage}$poster",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          horizontalSpace(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${displayTitle} ($year)",
                                  style: const TextStyle(color: Colors.white),
                                ),

                                Text(
                                  "IMDB ${data.voteAverage != null ? data.voteAverage!.toStringAsFixed(2) : 'N/A'}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
