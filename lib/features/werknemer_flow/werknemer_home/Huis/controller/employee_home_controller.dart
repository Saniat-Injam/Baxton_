
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/all_task_model.dart';
import 'package:get/get.dart';

class EmployeeHomeController extends GetxController {
  var userName = 'Russell'.obs;
  var completedTasks = 60.obs;

  var allTasks =
      <AllTaskModel>[
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        // Duplicate for demo
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",

          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: true,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",
          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
        AllTaskModel(
          title: 'Inspecteer het dak',
          location: 'New York',
          shortDescription:
              'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
          description:
              "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",
          price: '\$5000',
          dateTime: DateTime(2025, 4, 23, 11, 0),
          isPaymentCompleted: false,
        ),
      ].obs;

  List<AllTaskModel> get confirmedTasks =>
      allTasks.where((task) => task.isPaymentCompleted).toList();

  List<AllTaskModel> get paymentPendingTasks =>
      allTasks.where((task) => !task.isPaymentCompleted).toList();

  void completePayment(AllTaskModel task) {
    final index = allTasks.indexOf(task);
    if (index != -1) {
      allTasks[index].isPaymentCompleted = true;
      allTasks.refresh(); // Trigger UI update
    }
  }

  //-------------------new------------//

  // final TaskRepository _taskRepository = TaskRepository();

  // /// Confirmed tasks list
  // RxList<MyTask> allConfirmedTasks = <MyTask>[].obs;

  // /// Optional error message
  // RxString errorMessage = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchConfirmedTasks();
  // }

  // Future<void> fetchConfirmedTasks() async {
  //   try {
  //     EasyLoading.show(status: 'Loading...');

  //     final String? token = await AuthService.getToken();
  //     if (token == null || token.isEmpty) {
  //       debugPrint('No token found');
  //       errorMessage.value = 'No token found';
  //       EasyLoading.showError('Token not found');
  //       return;
  //     }

  //     final tasks = await _taskRepository.fetchMyTasks(token);

  //     for (var task in tasks) {
  //       debugPrint('Task ID: ${task.id}');
  //       debugPrint('Title: ${task.title}');
  //       debugPrint('Location: ${task.location}');
  //       debugPrint('Status: ${task.isPaymentCompleted}');
  //       debugPrint('price: ${task.price}');
  //       debugPrint('---');
  //     }

  //     allConfirmedTasks.assignAll(tasks);
  //     EasyLoading.dismiss();
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //     EasyLoading.showError('Error: ${e.toString()}');
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
}
