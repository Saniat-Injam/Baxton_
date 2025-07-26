import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  var employeeList = <Employee>[].obs;
  var selectedEmployeeIndex = (-1).obs;

  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  void fetchEmployees() {
    employeeList.assignAll([
      Employee(
        name: 'Theresa Webb',
        role: 'Dakspecialist',
        imageUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      Employee(
        name: 'James Parker',
        role: 'Schimmelverwijderingsspecialist',
        imageUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      Employee(
        name: 'Linda Brown',
        role: 'Elektricien',
        imageUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      Employee(
        name: 'Robert Smith',
        role: 'Loodgieter',
        imageUrl: 'https://i.pravatar.cc/150?img=4',
      ),
      Employee(
        name: 'Jessica Green',
        role: 'Timmerman',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
      ),
      Employee(
        name: 'Michael Johnson',
        role: 'Algemene aannemer',
        imageUrl: 'https://i.pravatar.cc/150?img=6',
      ),
      Employee(
        name: 'Emily Davis',
        role: 'Interieurontwerper',
        imageUrl: 'https://i.pravatar.cc/150?img=7',
      ),
    ]);
  }

  void selectEmployee(int index) {
    selectedEmployeeIndex.value = index;
  }
}
