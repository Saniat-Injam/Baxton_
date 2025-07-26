import 'package:baxton/features/klant_flow/onboarding_screen.dart/screen/klant_screen.dart';
import 'package:baxton/features/werknemer_flow/onboarding/view/werknemer_onboarding_screen.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  var selectedIndex = (-1).obs;
  void selectedRole(int index) {
    selectedIndex.value = index;
  }

  void navigateToRolePage() {
    switch (selectedIndex.value) {
      case 0:
        Get.to(() => WOnbScreen());
        break;
      case 1:
        Get.to(() => KonboardingScreen());
        break;
      default:
        Get.snackbar(
          'Error',
          'Please select a role to continue.',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
    }
  }
}
