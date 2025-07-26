import 'package:get/get.dart';
import '../model/employee_model.dart';
import '../model/task_model.dart';

class EmployeeInfoController extends GetxController {
  late Employee employee;
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    employee = Get.arguments as Employee;

    tasks.value = [
      TaskModel(
        title: 'Landschapsarchitectuur op 258 Cederstraat',
        assignee: 'David Wilson',
        date: '18 April, 2025',
        status: 'In Afwachting',
      ),
      TaskModel(
        title: 'Dakreparatie op 12 Esdoornlaan',
        assignee: 'Jessica Adams',
        date: '19 April, 2025',
        status: 'In Afwachting',
      ),
      TaskModel(
        title: 'Keukenverbouwing op 45 Eikendreef',
        assignee: 'Michael Lee',
        date: '20 April, 2025',
        status: 'Voltooid',
      ),
    ];

    super.onInit();
  }
}
