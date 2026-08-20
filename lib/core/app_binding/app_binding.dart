import 'package:get/get.dart';
import 'package:healing/controller/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
