import 'package:get/get.dart';

import '../../authentication/controller/auth_controller.dart';

class CusDrawerController extends GetxController {
  final AuthController authController = AuthController.to;

  @override
  void onClose() {}

  void logout() async {
    authController.signOut();
  }
}
