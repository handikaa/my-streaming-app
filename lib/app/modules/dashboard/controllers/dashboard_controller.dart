import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_streaming/app/modules/home/bindings/home_binding.dart';
import 'package:my_streaming/app/modules/movie/bindings/movie_binding.dart';
import 'package:my_streaming/app/modules/profile/bindings/profile_binding.dart';
import 'package:my_streaming/app/modules/tvshows/bindings/tvshows_binding.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);

    HomeBinding().dependencies();
    MovieBinding().dependencies();
    TvshowsBinding().dependencies();
    ProfileBinding().dependencies();
  }

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
