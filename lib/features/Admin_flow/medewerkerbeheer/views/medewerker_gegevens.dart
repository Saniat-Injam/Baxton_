import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/controller/medewerkerbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/models/worker_details_model.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/widgets/task_card.dart';
import 'package:baxton/features/klant_flow/message_screen/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MedewerkerGegevens extends StatelessWidget {
  final Workerdetails workerDetails;
  MedewerkerGegevens({super.key, required this.workerDetails});

  final MedewerkerbeheerController medewerkerbeheerController =
      Get.find<MedewerkerbeheerController>();

  @override
  Widget build(BuildContext context) {
    final data = workerDetails.data;

    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xffF4F4F4),
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffEBEBEB),
              ),
              child: Icon(Icons.arrow_back_outlined),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Medewerker Gegevens",
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100.0, 70.0, 0.0, 0.0),
                  color: AppColors.textWhite,
                  items: <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Status wijzigen',
                      child: Text(
                        'Status wijzigen',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Profiel opschorten',
                      child: Text(
                        'Profiel opschorten',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    medewerkerbeheerController.setPosition(value);
                  }
                });
              },
              child: Image.asset(IconPath.menu, height: 16, width: 4),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      data.profilePic != null && data.profilePic!.url.isNotEmpty
                          ? NetworkImage(data.profilePic!.url)
                          : AssetImage(IconPath.employe) as ImageProvider,
                ),
              ),
              SizedBox(height: 15),
              Text(
                data.userName,
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Id: ${data.workerId}",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGold,
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                title: "Taak Toewijzen",
                onPress: () {},
                borderColor: Colors.transparent,
                backgroundColor: AppColors.buttonPrimary,
                textcolor: Colors.white,
              ),
              SizedBox(height: 20),
              CustomButton(
                title: "Bericht",
                onPress: () {
                  Get.to(MessageScreen());
                },
                borderColor: AppColors.buttonPrimary,
                backgroundColor: Colors.transparent,
                textcolor: AppColors.buttonPrimary,
              ),
              SizedBox(height: 20),
              Container(
                height: 208,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Expertise",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            data.workerSpecialist != null
                                ? data.workerSpecialist!.name
                                : "Geen expertise",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Telefoonnummer",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            data.user.phone,
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "E-mail",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                data.user.email,
                                style: getTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Locatie",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            "${data.location}, ${data.assignedService.isNotEmpty ? data.assignedService.first.city : 'Geen stad'}",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Toegevoegd",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            data.assignedService.isNotEmpty
                                ? DateFormat(
                                  'dd MMMM yyyy',
                                ).format(data.assignedService.first.createdAt)
                                : "Onbekend",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data.totalAssigned}",
                            style: getTextStyle(
                              color: Color(0xff33DB2A),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Totaal Taak",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data.totalCompleted}",
                            style: getTextStyle(
                              color: Color(0xffD9A300),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Voltooid",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data.totalPending}",
                            style: getTextStyle(
                              color: AppColors.textThird,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "In Afwachting",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Container(
                height: 132,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Beoordeling",
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.buttonPrimary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          IconPath.star,
                          height: 36,
                          width: 36,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${data.averageRating}/5",
                          style: getTextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Alle Taken",
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Container(
              //     height: 48,
              //     width: 48,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(width: 1, color: Color(0xffF3E2B0)),
              //     ),
              //     child: IconButton(
              //       onPressed: () {},
              //       icon: Image.asset(IconPath.filter, height: 24, width: 24),
              //     ),
              //   ),
              // ),
              SizedBox(height: 15),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medewerkerbeheerController.tasks.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final task = medewerkerbeheerController.tasks[index];
                    return TaskCard(
                      title: task.problemDescription,
                      userName: task.name,
                      date: DateFormat(
                        'dd MMMM, yyyy',
                      ).format(task.preferredDate),
                      status: task.status,
                      statusColor:
                          task.status.toLowerCase() == 'in afwachting'
                              ? Color(0xffE9F4FF)
                              : Color(0xffEBEBEB),
                      statusTextColor:
                          task.status.toLowerCase() == 'in afwachting'
                              ? Color(0xff1E90FF)
                              : AppColors.textPrimary,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
