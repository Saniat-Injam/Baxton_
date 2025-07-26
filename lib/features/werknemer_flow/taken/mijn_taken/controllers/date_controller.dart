import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedYear = 2025.obs;
  var selectedMonth = 4.obs;
  var selectedDay = 1.obs;
  var todayTasksCount = 3.obs;

  void changeYear(int year) {
    selectedYear.value = year;
  }

  void changeMonth(int month) {
    selectedMonth.value = month;
  }

  void changeDay(int day) {
    selectedDay.value = day;
  }
}
