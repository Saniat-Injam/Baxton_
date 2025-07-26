import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayToConfirm extends StatelessWidget {
  final JobController jobscontroller;

  const PayToConfirm({super.key, required this.jobscontroller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final confirmedJobs = jobscontroller.jobList
          .where((job) => job.status.toLowerCase() == 'confirmed')
          .toList();
      if (confirmedJobs.isEmpty) {
        return Text(
          "Geen diensten om te bevestigen",
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textThird,
          ),
        );
      }
      return Column(
        children: confirmedJobs
            .map((job) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    height: 177,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFFFFFF),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffEBEBEB),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                job.title,
                                style: getTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff333333),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: Color(0xff007AFF),
                                  ),
                                  Text(
                                    job.location,
                                    style: getTextStyle(
                                      color: Color(0xff666666),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            job.description,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff666666),
                              lineHeight: 12.5,
                            ),
                          ),
                          SizedBox(height: 21),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 29,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      color: Color(0xffE9F4FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          job.status,
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff1E90FF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    job.date,
                                    style: getTextStyle(
                                      color: Color(0xff666666),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Implement details navigation logic here
                                },
                                child: Container(
                                  height: 40,
                                  width: 98,
                                  decoration: BoxDecoration(
                                    color: Color(0xff007AFF),
                                    borderRadius: BorderRadius.circular(62),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Details",
                                      style: getTextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
    });
  }
}