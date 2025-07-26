import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/task_status_widget.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/taakvoltooing_chart.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class piechart extends StatelessWidget {
  const piechart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 448,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Color(0xffE1E7EC)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Omzet per Taaktype",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textThird,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 42),
                Align(
                  alignment: Alignment.center,
                  child: SalesAnalysisChart(),
                ),
                SizedBox(height: 28),
                Row(
                  children: [
                    TaskStatusRow(
                      color: Color(0xff62B2FD),
                      label: "Dakinspectie",
                      data: "\$50000",
                    ),
                    SizedBox(width: 15),
                    TaskStatusRow(
                      color: Color(0xff9BDFC4),
                      label: "Dakinspectie",
                      data: "\$50000",
                    ),
                  ],
                ),
                SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TaskStatusRow(
                      color: Color(0xffF99BAB),
                      label: "Loodgieterswerk",
                      data: "\$50000",
                    ),
                    Spacer(),
                    TaskStatusRow(
                      color: Color(0xff9F97F7),
                      label: "HVAC Onderhoud",
                      data: "\$50000",
                    ),
                  ],
                ),
                SizedBox(height: 13),
                TaskStatusRow(
                  color: Color(0xffFFB44F),
                  label: "Herstel van Elektrisch Systeem",
                  data: "\$50000",
                ),
                SizedBox(height: 13),
                TaskStatusRow(
                  color: Color(0xff62B2FD),
                  label: "Vastgoedonderhoud",
                  data: "\$50000",
                ),
                SizedBox(height: 13),
                TaskStatusRow(
                  color: Color(0xff9BDFC4),
                  label: "Herstel van Elektrisch Systeem",
                  data: "\$25000",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}