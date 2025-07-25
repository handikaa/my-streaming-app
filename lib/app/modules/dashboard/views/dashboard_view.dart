import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_streaming/app/modules/profile/views/profile_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../../component/colors.dart';
import '../../home/views/home_view.dart';
import '../../movie/views/movie_view.dart';
import '../../tvshows/views/tvshows_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),
      builder: (context) {
        return Scaffold(
          body: PersistentTabView(
            onTabChanged: (index) {
              controller.changeTab(index);
            },
            tabs: [
              PersistentTabConfig(
                screen: HomeView(),
                item: ItemConfig(
                  icon: Obx(
                    () => Icon(
                      Icons.recommend,
                      color: controller.selectedIndex.value == 0
                          ? CustomColors.greenSysDarkOnPrimary
                          : Colors.grey,
                    ),
                  ),
                  title: "Trending",
                  activeForegroundColor: CustomColors.greenSysDarkOnPrimary,
                  inactiveForegroundColor: Colors.grey,
                ),
              ),

              PersistentTabConfig(
                screen: MovieView(),
                item: ItemConfig(
                  icon: Obx(
                    () => Icon(
                      Icons.movie,
                      color: controller.selectedIndex.value == 1
                          ? CustomColors.greenSysDarkOnPrimary
                          : Colors.grey,
                    ),
                  ),
                  title: "Movie",

                  activeForegroundColor: CustomColors.greenSysDarkOnPrimary,
                  inactiveForegroundColor: Colors.grey,
                ),
              ),
              PersistentTabConfig(
                screen: TvshowsView(),
                item: ItemConfig(
                  icon: Obx(
                    () => Icon(
                      Icons.tv_rounded,
                      color: controller.selectedIndex.value == 2
                          ? CustomColors.greenSysDarkOnPrimary
                          : Colors.grey,
                    ),
                  ),
                  title: "TV Series",

                  activeForegroundColor: CustomColors.greenSysDarkOnPrimary,
                  inactiveForegroundColor: Colors.grey,
                ),
              ),
              PersistentTabConfig(
                screen: ProfileView(),
                item: ItemConfig(
                  icon: Obx(
                    () => Icon(
                      Icons.person,
                      color: controller.selectedIndex.value == 3
                          ? CustomColors.greenSysDarkOnPrimary
                          : Colors.grey,
                    ),
                  ),
                  title: "Pofile",

                  activeForegroundColor: CustomColors.greenSysDarkOnPrimary,
                  inactiveForegroundColor: Colors.grey,
                ),
              ),
            ],
            navBarBuilder: (navBarConfig) =>
                Style1BottomNavBar(navBarConfig: navBarConfig),
          ),
        );
      },
    );
  }
}
