import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_streaming/app/component/spacing.dart';
import 'package:my_streaming/app/component/text.dart';
import 'package:my_streaming/app/data/api/api_const.dart';

class LayoutOne<T> extends StatelessWidget {
  const LayoutOne({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.itemToName,
    required this.itemToId,
    this.title = "Now Playing",
    required this.itemToImageUrl,
  });

  final List<T> items;
  final void Function(dynamic id) onItemTap;
  final String Function(T item) itemToName;
  final String Function(T item) itemToImageUrl;
  final dynamic Function(T item) itemToId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomText(text: title),
        ),

        verticalSpace(8),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final item = items[index];
              final imageUrl = "${ApiConst.baseImage}${itemToImageUrl(item)}";
              return GestureDetector(
                onTap: () => onItemTap(itemToId(item)),
                child: Container(
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
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
