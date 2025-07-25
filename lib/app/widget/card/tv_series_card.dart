import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_streaming/app/data/api/api_const.dart';

import '../../component/assets.dart';

class TvSeriesCard extends StatelessWidget {
  final double width;
  final double height;
  final String? imageUrl;
  final String title;
  final BoxFit? fit;
  final double borderRadius;
  final VoidCallback? onTap;

  const TvSeriesCard({
    super.key,
    this.width = 400,
    this.height = 170,
    this.imageUrl,
    this.fit,
    this.borderRadius = 10,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(
                  image: NetworkImage("${ApiConst.baseImage}$imageUrl"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [LottieBuilder.asset(Assets.liveLt, width: 80)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
