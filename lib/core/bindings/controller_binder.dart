import 'package:baxton/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/signature_controller.dart';
import 'package:baxton/features/werknemer_flow/authentication/controllers/worker_forget_password_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/filter_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/controller/employee_home_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );
    Get.put(BetalingsbeheerController());
    Get.put(FilterController());
    Get.put(EmployeeController());
    Get.put(EmployeeHomeController());
    Get.put(ClientInfoController());
    Get.put(WorkerForgetPasswordController());
    Get.put(SharedSignatureController());
    // Get.put(KchatlistController());
  }
}
