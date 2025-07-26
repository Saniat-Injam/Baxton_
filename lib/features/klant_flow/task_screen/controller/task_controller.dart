
import 'package:get/get.dart';

class TaskController extends GetxController {
  var showRequestScreen = false.obs;
  var progress = 0.2.obs; 

  void toggleRequestScreen(bool value) {
    showRequestScreen.value = value;
  }
  

  void updateProgress(double newProgress) {
    if (newProgress >= 0 && newProgress <= 1) {
      progress.value = newProgress;
    }
  }
  final RxInt selectedValue = 5.obs;
}