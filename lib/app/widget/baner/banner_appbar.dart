import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_streaming/app/modules/home/controllers/home_controller.dart';

Widget bannerMovieRecommended<T>({
  required List<T> data,
  required Widget Function(T item) itemBuilder,
  required HomeController controller,
  double height = 400,
}) {
  return Stack(
    children: [
      CarouselSlider(
        options: CarouselOptions(
          height: height.h,
          viewportFraction: 1.0,
          autoPlay: true,
          onPageChanged: (index, reason) {
            controller.currentIndex.value = index;
          },
        ),
        items: data.map((item) {
          return Stack(
            children: [
              itemBuilder(item),
              Container(
                width: 1.sw,
                height: height.h,
                color: Colors.black.withOpacity(0.4),
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
              data.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.currentIndex.value == index
                      ? Colors.green
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
