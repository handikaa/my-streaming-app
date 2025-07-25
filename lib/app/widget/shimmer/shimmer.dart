import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:my_streaming/app/component/spacing.dart';
import 'package:shimmer/shimmer.dart';

class SquareShimmerLoading extends StatelessWidget {
  const SquareShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SafeArea(
        child: Column(
          children: [
            _buildSquareBoxHorizontal(),

            verticalSpace(20),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: Get.width / (2 * 250),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(4, (_) => _buildSquareBoxVertical()),
            ),
            verticalSpace(20),
            _buildSquareBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareBoxHorizontal() {
    return Container(
      width: Get.width,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildSquareBoxVertical() {
    return Container(
      width: Get.width,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildSquareBox() {
    return Container(
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
