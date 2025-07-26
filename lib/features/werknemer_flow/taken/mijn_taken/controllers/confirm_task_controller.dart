import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/task_status_model.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/task_status_repository.dart';
import 'package:get/get.dart';

class ConfirmedTaskController extends GetxController {
  final TaskStatusRepository _repo = TaskStatusRepository();
  RxList<TaskStatusModel> confirmedTasks = <TaskStatusModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadConfirmedTasks();
  }

  Future<void> loadConfirmedTasks() async {
    try {
      isLoading.value = true;
      final tasks = await _repo.fetchTasks('CONFIRMED');
      confirmedTasks.assignAll(tasks);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
