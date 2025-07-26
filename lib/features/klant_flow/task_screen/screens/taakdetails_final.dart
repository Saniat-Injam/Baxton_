import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

// ignore: must_be_immutable
class TaakdetailsFinalScreen extends StatelessWidget {
  TaakdetailsFinalScreen({super.key});
  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Taakdetails",
          style: getTextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 246,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFFEBEBEB)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      SizedBox(
                        width: 336,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              'Mold Treatment',
                              textAlign: TextAlign.center,
                              style: getTextStyle(
                                color: const Color(0xFF333333),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!',
                              textAlign: TextAlign.center,
                              style: getTextStyle(
                                color: const Color(0xFF666666),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.28,
                                lineHeight: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            spacing: 4,
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Color(0xff1E90FF),
                              ),
                              Text(
                                '11:00 Am',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: const Color(0xFF666666),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            spacing: 4,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: Color(0xff1E90FF),
                              ),
                              Text(
                                'New York',
                                style: getTextStyle(
                                  color: const Color(0xFF666666),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Column(
                spacing: 20,
                children: [
                  SizedBox(
                    width: 361,
                    child: Text(
                      'Taakchecklist',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        height: 1.20,
                      ),
                    ),
                  ),
                  Column(
                    spacing: 12,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFBF6E6),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFD9A300),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 12,
                            children: [
                              Icon(
                                Icons.check_box,
                                size: 26,
                                color: AppColors.buttonPrimary,
                              ),
                              Text(
                                'Inspecteer het dak op zichtbare schade',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFBF6E6),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFD9A300),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            spacing: 12,
                            children: [
                              Icon(
                                Icons.check_box,
                                size: 26,
                                color: AppColors.buttonPrimary,
                              ),
                              Text(
                                'Zoek naar schimmel of watervlekken',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFBF6E6),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFD9A300),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            spacing: 12,
                            children: [
                              Icon(
                                Icons.check_box,
                                size: 26,
                                color: AppColors.buttonPrimary,
                              ),
                              Text(
                                'Maak fotos van eventuele schade',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFBF6E6),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFD9A300),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            spacing: 12,
                            children: [
                              Icon(
                                Icons.check_box,
                                size: 26,
                                color: AppColors.buttonPrimary,
                              ),
                              Text(
                                'Rapporteer aan de administratie',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFBF6E6),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFD9A300),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            spacing: 24,
                            children: [
                              Icon(
                                Icons.check_box,
                                size: 26,
                                color: AppColors.buttonPrimary,
                              ),
                              Text(
                                'Vraag om handtekening van de klant',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(ImagePath.before, height: 150, width: 173),
                      SizedBox(height: 8),
                      Text(
                        "Foto van tevoren",
                        style: getTextStyle(
                          fontSize: 16,
                          color: AppColors.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(ImagePath.after, height: 150, width: 173),
                      SizedBox(height: 8),
                      Text(
                        "Na Foto",
                        style: getTextStyle(
                          fontSize: 16,
                          color: AppColors.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Uw Handtekening",
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff000000).withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(ImagePath.signature, fit: BoxFit.cover),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Opmerking van werknemer",
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Urna odio sit neque urna. Nisi nisi volutpat pellentesque in tincidunt diam.",

                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                    lineHeight: 12,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Klantbeoordeling",
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Image.asset(IconPath.star, height: 15, width: 15),
                      Image.asset(IconPath.star, height: 15, width: 15),
                      Image.asset(IconPath.star, height: 15, width: 15),
                      Image.asset(IconPath.star, height: 15, width: 15),
                      Image.asset(IconPath.star, height: 15, width: 15),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Urna odio sit neque urna. Nisi nisi volutpat pellentesque in tincidunt diam.",

                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                    lineHeight: 12,
                  ),
                ),
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 44,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),

                  decoration: ShapeDecoration(
                    color: AppColors.buttonPrimary,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF1E90FF),
                      ),
                      borderRadius: BorderRadius.circular(62),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Image.asset(IconPath.downloaddocument1),
                      ),
                      Text(
                        'Rapport downloaden',
                        style: getTextStyle(
                          color: AppColors.textWhite,
                          fontSize: 16,

                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 44,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),

                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF1E90FF),
                      ),
                      borderRadius: BorderRadius.circular(62),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Image.asset(IconPath.share),
                      ),
                      Text(
                        'Delen',
                        style: getTextStyle(
                          color: AppColors.buttonPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
