import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/task_execution_screen.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/all_task_model.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class AllTaskCard extends StatelessWidget {
//   final AllTaskModel employeesConfirmedTask;
//   final bool? isStartEnabled;

//   const AllTaskCard({
//     super.key,
//     required this.employeesConfirmedTask,
//     this.isStartEnabled,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.primaryWhite,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: AppColors.secondaryWhite),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title & Location Row
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     employeesConfirmedTask.title,
//                     style: getTextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.primaryBlack,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Image.asset(IconPath.location),
//                 const SizedBox(width: 4),
//                 Text(
//                   employeesConfirmedTask.location,
//                   style: getTextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.secondaryBlack,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),

//             // Description
//             Text(
//               employeesConfirmedTask.shortDescription,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.secondaryBlack,
//               ),
//             ),
//             const SizedBox(height: 8),

//             // Confirmed Price
//             Row(
//               children: [
//                 Container(
//                   height: 29,
//                   width: 63,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.secondaryBlue,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       employeesConfirmedTask.price,
//                       style: getTextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.primaryBlue,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),

//             // Date, Time, and Start Task Button
//             Row(
//               children: [
//                 Text(
//                   "${employeesConfirmedTask.dateTime.day.toString().padLeft(2, '0')}/"
//                   "${employeesConfirmedTask.dateTime.month.toString().padLeft(2, '0')}/"
//                   "${employeesConfirmedTask.dateTime.year} "
//                   "${employeesConfirmedTask.dateTime.hour.toString().padLeft(2, '0')}:"
//                   "${employeesConfirmedTask.dateTime.minute.toString().padLeft(2, '0')} "
//                   "uur",
//                   style: getTextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.secondaryBlack,
//                   ),
//                 ),
//                 const Spacer(),

//                 SizedBox(
//                   width: 160,
//                   height: 44,
//                   child: ElevatedButton(
//                     onPressed:
//                         isStartEnabled == true
//                             ? () {
//                               Get.to(
//                                 () => TaskExecutionScreen(
//                                   setPriceTask: SetPriceTaskModel(
//                                     // Map the fields from employyesConfirmedTask to SetPriceTaskModel accordingly
//                                     title: employeesConfirmedTask.title,
//                                     description:
//                                         employeesConfirmedTask.description,

//                                     location: employeesConfirmedTask.location,
//                                     dateTime: employeesConfirmedTask.dateTime,
//                                     // Add any other required fields here
//                                   ),
//                                 ),
//                               );
//                             }
//                             : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isStartEnabled == true
//                               ? AppColors.primaryBlue
//                               : AppColors.primaryGold,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(62),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                     ),
//                     child: Text(
//                       'Taak Starten',
//                       style: getTextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color:
//                             isStartEnabled == true
//                                 ? AppColors.primaryWhite
//                                 : AppColors.primaryBlue,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AllTaskCard extends StatelessWidget {
  final AllTaskModel allTask;

  const AllTaskCard({super.key, required this.allTask});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,

      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.secondaryWhite),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Location Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    allTask.title,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(IconPath.location),
                const SizedBox(width: 4),
                Text(
                  allTask.location,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              allTask.shortDescription,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            const SizedBox(height: 8),

            // Confirmed Price
            Row(
              children: [
                // Price Container
                Container(
                  height: 34,
                  width: 69,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      allTask.price,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Date, Time, and Taak Start Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "${allTask.dateTime.day.toString().padLeft(2, '0')}/"
                      "${allTask.dateTime.month.toString().padLeft(2, '0')}/"
                      "${allTask.dateTime.year}    "
                      "${allTask.dateTime.hour.toString().padLeft(2, '0')}:"
                      "${allTask.dateTime.minute.toString().padLeft(2, '0')} "
                      "uur",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),

                const Spacer(),
                SizedBox(
                  width: 140,
                  height: 44,

                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.primaryBlueWithShadow;
                        }
                        return AppColors.primaryBlue;
                      }),
                      side: WidgetStateProperty.resolveWith<BorderSide>((
                        Set<WidgetState> states,
                      ) {
                        return BorderSide(
                          color:
                              states.contains(WidgetState.disabled)
                                  ? AppColors.primaryBlueWithShadow
                                  : AppColors.primaryBlue,
                        );
                      }),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(62),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    onPressed:
                        allTask.isPaymentCompleted
                            ? () {
                              Get.to(
                                () => TaskExecutionScreen(
                                  setPriceTask: SetPriceTaskModel(
                                    title: allTask.title,
                                    description: allTask.description,
                                    location: allTask.location,
                                    dateTime: allTask.dateTime,
                                  ),
                                ),
                              );
                            }
                            : null,
                    child: Center(
                      child: Text(
                        "Taak Starten",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryWhite,
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
    );
  }
}
