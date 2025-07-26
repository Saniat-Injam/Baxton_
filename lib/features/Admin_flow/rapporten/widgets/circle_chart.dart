import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/task_status_widget.dart';
import 'package:baxton/features/Admin_flow/rapporten/controller/rapporten_controller.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/taskchart_painter.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class circle_chart extends StatelessWidget {
  const circle_chart({super.key, required this.rapportenController});

  final RapportenController rapportenController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            SizedBox(
              height: 212,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular chart
                    CustomPaint(
                      size: Size(170, 150),
                      painter: TaskChartPainter(
                        inBehandeling: rapportenController.inBehandeling.value,
                        nietToegewezen:
                            rapportenController.nietToegewezen.value,
                        voltooid: rapportenController.voltooid.value,
                      ),
                    ),
                    // Center text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          rapportenController.totalTasks.value.toString(),
                          style: getTextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        Text(
                          'TOTAAL AANTAL \nTAKEN',
                          style: getTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8C97A7),
                            lineHeight: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskStatusRow(
              color: Color(0xffFFB44F),
              label: "In Behandeling",
              data: "15",
            ),
            SizedBox(height: 13),
            TaskStatusRow(
              color: Color(0xff62B2FD),
              label: "Niet Toegewezen",
              data: "5",
            ),
            SizedBox(height: 13),
            TaskStatusRow(
              color: Color(0xff9BDFC4),
              label: "Voltooid",
              data: "20",
            ),
          ],
        ),
      ],
    );
  }
}
