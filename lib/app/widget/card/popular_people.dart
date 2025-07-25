import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_streaming/app/data/api/api_const.dart';
import 'package:my_streaming/app/data/entity/people_entity.dart';

import '../../component/spacing.dart';
import '../../component/text.dart';

class PopularPeople extends StatelessWidget {
  const PopularPeople({super.key, required this.listData});

  final List<PeopleEntity>? listData;

  @override
  Widget build(BuildContext context) {
    if (listData == null || listData!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [CustomText(text: "Popular Artis")]),
        ),
        verticalSpace(8),
        SizedBox(
          height: 80.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: listData!.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              var data = listData![index];

              final imageUrl = data.profilePath != null
                  ? "${ApiConst.baseImage}${data.profilePath}"
                  : null;

              return Container(
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                  image: imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                padding: EdgeInsets.all(12.w),
                alignment: Alignment.bottomLeft,
                child: imageUrl == null
                    ? const Icon(Icons.person, size: 24)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
