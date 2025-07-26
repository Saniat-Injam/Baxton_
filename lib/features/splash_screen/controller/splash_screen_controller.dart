import 'package:baxton/features/role_screen/screen/role_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigateAfterDelay();
    super.onInit();
  }

  void navigateAfterDelay() {
    Future.delayed(Duration(seconds: 3), () {
      // Removes all previous routes/screens from the navigation stack and then pushes the new one.
      Get.offAll(() => RoleScreen());
    });
  }
}
