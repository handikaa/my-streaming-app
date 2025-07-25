import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:my_streaming/app/component/colors.dart';
import 'package:my_streaming/app/component/spacing.dart';
import 'package:my_streaming/app/component/text.dart';
import 'package:my_streaming/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1B20),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          verticalSpace(50),
          Container(
            height: 150.h,
            width: 150.h,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.greenSysDarkOnPrimary,
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Icon(Icons.person, size: 100, color: Colors.white),
          ),
          verticalSpace(26),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.WATCH_LIST);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CustomColors.greenSysDark, width: 4),
              ),

              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.tv),
                      horizontalSpace(15),
                      CustomText(
                        text: 'Watch List',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_sharp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
