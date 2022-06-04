import 'package:get/get.dart';

import '../controller/drawer_controller.dart';

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CusDrawerController>(CusDrawerController());
  }
}
