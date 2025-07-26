import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/task_screen/model/all_task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceContainer extends StatelessWidget {
  final ServiceRequest service;

  const ServiceContainer({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(service.preferredDate ?? '');
    } catch (e) {
      parsedDate = DateTime.now();
    }

    return Column(
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffFFFFFF),
            border: Border.all(width: 1, color: const Color(0xffEBEBEB)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 230,
                      child: Text(
                        service.name ?? 'Unknown Service',
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.buttonPrimary,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            service.city ?? 'Unknown City',
                            style: getTextStyle(
                              color: const Color(0xff666666),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  service.problemDescription ?? 'No Description',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff666666),
                    lineHeight: 11,
                  ),
                ),
                const SizedBox(height: 21),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 29,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: const Color(0xffE9F4FF),
                            borderRadius: BorderRadius.circular(85),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                service.status.isEmpty ? 'Unknown Status' : service.status,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.buttonPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          service.preferredDate != null
                              ? DateFormat('dd MMMM, yyyy').format(parsedDate)
                              : 'No Date',
                          style: getTextStyle(
                            color: const Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 98,
                      decoration: BoxDecoration(
                        color: AppColors.buttonPrimary,
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
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}