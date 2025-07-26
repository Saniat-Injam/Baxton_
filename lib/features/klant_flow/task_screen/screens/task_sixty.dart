import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_button.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/beoordelingsverzoek_invoice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class TaskSixty extends StatelessWidget {
  TaskSixty({super.key});

  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Beoordelingsverzoek",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Prijs Vastgesteld door Werknemer",
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => Text(
                  "${(taskController.progress.value * 100).toInt()}% Voltooid",
                  style: getTextStyle(
                    color: Color(0xff0072C3),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 32,
                      lineHeight: 14.0,
                      percent: taskController.progress.value,
                      backgroundColor: Colors.grey[300],
                      progressColor: Color(0xff0043CE),

                      barRadius: Radius.circular(10),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: 52,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFBF6E6),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFFEBEBEB)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      '\$5000',
                      style: TextStyle(
                        color: const Color(0xFFD9A300),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(IconPath.image),
              ),
              SizedBox(height: 16),
              Container(
                height: 208,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 28,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'Naam',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Samantha Green',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            color: const Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'Telefoonnummer',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '+001 234 567',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            color: const Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'E-mail',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'example123@gmail.com',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            color: const Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'Stad',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'London',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            color: const Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'Postcode',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '1243',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            color: const Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFFEBEBEB)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(
                      'Locatie beschrijven',
                      style: getTextStyle(
                        color: const Color(0xFF666666),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    SizedBox(
                      width: 337,
                      child: Text(
                        'Lorem ipsum dolor sit amet consectetur. Orci viverra nam vitae donec accumsan lectus dictumst sed.',
                        style: getTextStyle(
                          color: const Color(0xFFD9A300),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.32,
                          lineHeight: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              Container(
                height: 142,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 29,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'Taaktype',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 168,
                          child: Text(
                            'Schimmelinspecties - Behandelingen',
                            textAlign: TextAlign.right,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'Voorkeurs tijd',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '11:00 Am',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            color: const Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 4,
                      children: [
                        Text(
                          'Voorkeursdatum',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '24/04/2025',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            color: const Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFFEBEBEB)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      'Probleem beschrijven',
                      style: getTextStyle(
                        color: const Color(0xFF666666),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    SizedBox(
                      width: 337,
                      child: Text(
                        'Lorem ipsum dolor sit amet consectetur. Orci viverra nam vitae donec accumsan lectus dictumst sed.',
                        style: getTextStyle(
                          color: const Color(0xFFD9A300),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          lineHeight: 13,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CustomContinueButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BetalingsbeheerInvoiceScreen(),
                    ),
                  );
                },
                title: "Genarate Invoice",
                backgroundColor: Color(0xff1E90FF),
                textColor: AppColors.textWhite,
              ),
              SizedBox(height: 16),
              CustomButton(
                onPress: () {
                  
                },
                title: "Decline",
                backgroundColor: Colors.transparent,
                textcolor: Color(0xFF1E90FF),
                borderColor: Color(0xFF1E90FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
