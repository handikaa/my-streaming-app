import 'package:get/get.dart';

import '../controllers/tester_controller.dart';

class TesterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TesterController>(
      () => TesterController(),
    );
  }
}
