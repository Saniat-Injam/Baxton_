import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/date_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowDates extends StatelessWidget {
  final DateController controller = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // YEAR and MONTH Dropdowns
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Year Dropdown
            Obx(
              () => Container(
                width: 99,
                height: 40,
                padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.secondaryWhite),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: controller.selectedYear.value,
                    onChanged: (value) {
                      if (value != null) controller.changeYear(value);
                    },
                    icon: Image.asset(IconPath.arrowDown),
                    items:
                        [2024, 2025, 2026]
                            .map(
                              (year) => DropdownMenuItem(
                                value: year,
                                child: Text(year.toString()),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),

            // Month Dropdown
            Obx(
              () => Container(
                width: 150,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.secondaryWhite),
                ),
                child: Row(
                  children: [
                    Image.asset(IconPath.calendarMonth),
                    SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: controller.selectedMonth.value,
                          onChanged: (value) {
                            if (value != null) controller.changeMonth(value);
                          },
                          icon: Image.asset(IconPath.arrowDown),
                          isExpanded: true,
                          items:
                              List.generate(12, (index) => index + 1)
                                  .map(
                                    (month) => DropdownMenuItem(
                                      value: month,
                                      child: Text(
                                        monthName(month),
                                        style: TextStyle(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Calender
        Obx(
          () => Container(
            height: 148,
            width: 308,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondaryWhite),
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .2),

                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  '${monthName(controller.selectedMonth.value)} ${controller.selectedYear.value}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Divider(color: Color(0xFFE4E5E7)),
                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    final days = [
                      'Maa',
                      'Din',
                      'Woe',
                      'Don',
                      'Vri',
                      'Zat',
                      'Zon',
                    ];
                    final dayNumber = index + 1;
                    return GestureDetector(
                      onTap: () => controller.changeDay(dayNumber),
                      child: Column(
                        children: [
                          Text(days[index]),
                          const SizedBox(height: 14),
                          Obx(
                            () => Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color:
                                    controller.selectedDay.value == dayNumber
                                        ? Colors.blue
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$dayNumber',
                                style: TextStyle(
                                  color:
                                      controller.selectedDay.value == dayNumber
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String monthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maart',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Augustus',
      'September',
      'Oktober',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
