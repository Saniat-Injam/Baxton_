import 'package:baxton/features/Admin_flow/medewerkerbeheer_new/model/employee_model.dart';
import 'package:get/get.dart';

class EmployeeManagementController extends GetxController {
  var activeCount = 15.obs;
  var inactiveCount = 5.obs;
  var employees = <Employee>[].obs;

  int get totalCount => activeCount.value + inactiveCount.value;

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  void loadEmployees() {
    employees.assignAll([
      Employee(
        name: 'Theresa Webb',
        role: 'Dak Specialist',
        imageUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      Employee(
        name: 'James Parker',
        role: 'Schimmelverwijdering Specialist',
        imageUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      Employee(
        name: 'Linda Brown',
        role: 'Elektricien',
        imageUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      Employee(
        name: 'Robert Smith',
        role: 'Loodgieter Expert',
        imageUrl: 'https://i.pravatar.cc/150?img=4',
      ),
      Employee(
        name: 'Jessica Green',
        role: 'Timmerman',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
      ),
      Employee(
        name: 'Michael Johnson',
        role: 'Algemene Aannemer',
        imageUrl: 'https://i.pravatar.cc/150?img=6',
      ),
      Employee(
        name: 'Emily Davis',
        role: 'Interieurontwerper',
        imageUrl: 'https://i.pravatar.cc/150?img=7',
      ),
    ]);
  }
}
