import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widget/shimmer/shimmer.dart';
import '../controllers/tester_controller.dart';

class TesterView extends GetView<TesterController> {
  const TesterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1B20),

      body: Column(children: [SquareShimmerLoading()]),
    );
  }
}
