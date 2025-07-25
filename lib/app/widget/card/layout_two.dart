import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_streaming/app/component/text.dart';
import '../../component/spacing.dart';
import '../../data/api/api_const.dart';

class LayoutTwo<T> extends StatelessWidget {
  const LayoutTwo({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.itemToName,
    required this.itemToId,
    required this.itemToImageUrl,
    required this.itemToFirstImageUrl,
    this.title = "Now Playing",
    this.itemToTitle,
    this.itemToReleaseDate,
    this.itemToVoteAverage,
  });

  final List<T> items;
  final void Function(dynamic id) onItemTap;
  final String Function(T item) itemToName;
  final String Function(T item) itemToImageUrl;
  final String Function(T item) itemToFirstImageUrl;
  final dynamic Function(T item) itemToId;
  final String Function(T item)? itemToTitle;
  final String Function(T item)? itemToReleaseDate;
  final String Function(T item)? itemToVoteAverage;

  final String title;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();

    final firstItem = items[0];
    final firstImageUrl =
        "${ApiConst.baseImage}${itemToFirstImageUrl(firstItem)}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [CustomText(text: title)]),
        ),
        verticalSpace(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () => onItemTap(itemToId(firstItem)),
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(firstImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: itemToName(firstItem),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        verticalSpace(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: itemToReleaseDate!(firstItem),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 55),
                              child: CustomText(
                                text: itemToVoteAverage!(firstItem),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(16),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length - 1,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final item = items[index + 1];
              final imageUrl = "${ApiConst.baseImage}${itemToImageUrl(item)}";

              return GestureDetector(
                onTap: () => onItemTap(itemToId(item)),
                child: Container(
                  width: 125.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.all(12.w),
                  alignment: Alignment.bottomLeft,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
