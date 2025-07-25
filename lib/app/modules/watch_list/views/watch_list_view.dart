import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_streaming/app/component/spacing.dart';
import 'package:my_streaming/app/component/text.dart';
import 'package:my_streaming/app/data/api/api_const.dart';
import 'package:my_streaming/app/routes/app_pages.dart';

import '../controllers/watch_list_controller.dart';

class WatchListView extends GetView<WatchListController> {
  const WatchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1D1B20),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const CustomText(
          text: 'Watch List',
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: const Color(0xff1D1B20),
      ),
      body: Obx(() {
        if (controller.favoriteMovies.isEmpty) {
          return const Center(
            child: Text(
              "Watch list kosong.",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.favoriteMovies.length,

          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final movie = controller.favoriteMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.DETAIL,
                    arguments: {'id': movie.id, 'type': movie.mediaType},
                  );
                },
                child: Row(
                  children: [
                    Container(
                      height: 140,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            "${ApiConst.baseImage}${movie.posterPath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    horizontalSpace(12),
                    Expanded(child: CustomText(text: movie.name, fontSize: 13)),
                  ],
                ),
              ),
            );

            // ListTile(
            //   leading: movie.posterPath.isNotEmpty
            //       ? Image.network("${ApiConst.baseImage}${movie.posterPath}")
            //       : const Icon(Icons.movie, color: Colors.white),
            //   title: Text(
            //     movie.name,
            //     style: const TextStyle(color: Colors.white),
            //   ),
            //   trailing: IconButton(
            //     icon: const Icon(Icons.delete, color: Colors.red),
            //     onPressed: () {
            //       controller.removeFromFavorite(movie.id);
            //     },
            //   ),
            // );
          },
        );
      }),
    );
  }
}
