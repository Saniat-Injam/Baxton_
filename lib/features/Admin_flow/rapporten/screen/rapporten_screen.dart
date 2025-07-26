// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
// import 'package:baxton/features/Admin_flow/rapporten/controller/rapporten_controller.dart';
// import 'package:baxton/features/Admin_flow/rapporten/widgets/circle_chart.dart';
// import 'package:baxton/features/Admin_flow/rapporten/widgets/custom_bar_chart.dart';
// import 'package:baxton/features/Admin_flow/rapporten/widgets/grid_view.dart';
// import 'package:baxton/features/Admin_flow/rapporten/widgets/line_chart.dart';
// import 'package:baxton/features/Admin_flow/rapporten/widgets/pie_chart.dart';
// import 'package:baxton/features/Admin_flow/rapporten/widgets/review_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class RapportenScreen extends StatelessWidget {
//   RapportenScreen({super.key});
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   RapportenController rapportenController = Get.put(RapportenController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: Navbar(),
//       appBar: AppBar(
//         titleSpacing: 0,
//         leading: IconButton(
//           icon: Image.asset(IconPath.notes),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//         centerTitle: true,
//         title: Text(
//           "Rapporten & Analyse",
//           style: getTextStyle(
//             color: AppColors.textPrimary,
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Obx(
//                     () => Container(
//                       width: 141,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFF8F2D3),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: AppColors.primaryGold,
//                           width: 1,
//                         ),
//                       ),
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         elevation: 0,
//                         underline: Container(),
//                         value: rapportenController.selectedValue.value,
//                         icon: Icon(
//                           Icons.arrow_drop_down,
//                           color: AppColors.primaryGold,
//                         ), // Orange arrow icon
//                         onChanged: (String? newValue) {
//                           if (newValue != null) {
//                             rapportenController.updateSelectedValue(newValue);
//                           }
//                         },
//                         items:
//                             <String>[
//                               'Deze Maand',
//                               'Vorige maand',

//                             ].map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10.0,
//                                   ),
//                                   child: Text(
//                                     value,
//                                     style: TextStyle(color: Colors.black),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 17),
//               gridview(rapportenController: rapportenController),
//               SizedBox(height: 40),
//               Text(
//                 "Taakvoltooiing",
//                 style: getTextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 18),

//               Container(
//                 height: 306,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(width: 1, color: Color(0xffEBEBEB)),
//                 ),
//                 child: const CustomBarChart(),
//               ),
//               SizedBox(height: 40),
//               Text(
//                 "Omzetanalyse",
//                 style: getTextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 18),
//               piechart(),
//               SizedBox(height: 20),
//               Container(
//                 height: 377,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(width: 1, color: Color(0xffE1E7EC)),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Omzet per Tijd",
//                         style: getTextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.textThird,
//                         ),
//                       ),
//                       SizedBox(height: 40),
//                       SizedBox(
//                         height: 280,
//                         width: double.infinity,
//                         child: CustomPaint(painter: LineChartPainter()),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Text(
//                 "Taakstatus",
//                 style: getTextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 16),
//               circle_chart(rapportenController: rapportenController),
//               SizedBox(height: 56),
//               Text(
//                 "Klantfeedback",
//                 style: getTextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Gemiddelde \nTevredenheid",
//                         style: getTextStyle(
//                           color: AppColors.textThird,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           lineHeight: 13,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Image.asset(IconPath.star, height: 15, width: 15),
//                           Image.asset(IconPath.star, height: 15, width: 15),
//                           Image.asset(IconPath.star, height: 15, width: 15),
//                           Image.asset(IconPath.star, height: 15, width: 15),
//                           Image.asset(IconPath.halfstar, height: 15, width: 15),
//                           SizedBox(width: 5),
//                           Text(
//                             "4.5/5",
//                             style: getTextStyle(
//                               color: AppColors.textPrimary,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         height: 29,
//                         width: 95,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Color(0xff98DFC4).withValues(alpha: 0.44),
//                         ),
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "92% Positief",
//                             style: getTextStyle(
//                               color: Color(0xff00A463),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: rapportenController.reviews.length,
//                 itemBuilder: (context, index) {
//                   var review = rapportenController.reviews[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6.0),
//                     child: ReviewCard(
//                       name: review['name'],
//                       profileImage: review['profileImage'],
//                       rating: review['rating'],
//                       reviewText: review['reviewText'],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/rapporten/controller/rapporten_controller.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/circle_chart.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/custom_bar_chart.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/grid_view.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/line_chart.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/pie_chart.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RapportenScreen extends StatelessWidget {
  RapportenScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RapportenController rapportenController = Get.put(RapportenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          "Rapporten & Analyse",
          style: getTextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () =>
            rapportenController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(
                              () => Container(
                                width: 141,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF8F2D3),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primaryGold,
                                    width: 1,
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  elevation: 0,
                                  underline: Container(),
                                  value:
                                      rapportenController.selectedValue.value,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.primaryGold,
                                  ),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      rapportenController.updateSelectedValue(
                                        newValue,
                                      );
                                    }
                                  },
                                  items:
                                      <String>[
                                        'Deze Maand',
                                        'Vorige maand',
                                      ].map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 17),
                        gridview(rapportenController: rapportenController),
                        SizedBox(height: 40),
                        Text(
                          "Taakvoltooiing",
                          style: getTextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 18),
                        CustomBarChart(),

                        SizedBox(height: 40),
                        Text(
                          "Omzetanalyse",
                          style: getTextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 18),
                        piechart(),
                        SizedBox(height: 20),
                        Container(
                          height: 377,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffE1E7EC),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Omzet per Tijd",
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textThird,
                                  ),
                                ),
                                SizedBox(height: 40),
                                SizedBox(
                                  height: 280,
                                  width: double.infinity,
                                  child: CustomPaint(
                                    painter: LineChartPainter(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Taakstatus",
                          style: getTextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16),
                        circle_chart(rapportenController: rapportenController),
                        SizedBox(height: 56),
                        Text(
                          "Klantfeedback",
                          style: getTextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gemiddelde \nTevredenheid",
                                  style: getTextStyle(
                                    color: AppColors.textThird,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    lineHeight: 13,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Obx(
                                  () => Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        double rating =
                                            rapportenController
                                                .averageRating
                                                .value;
                                        int fullStars = rating.floor();
                                        bool hasHalfStar =
                                            (rating - fullStars) >= 0.5;
                                        if (index < fullStars) {
                                          return Image.asset(
                                            IconPath.star,
                                            height: 15,
                                            width: 15,
                                          );
                                        } else if (index == fullStars &&
                                            hasHalfStar) {
                                          return Image.asset(
                                            IconPath.halfstar,
                                            height: 15,
                                            width: 15,
                                          );
                                        } else {
                                          return Image.asset(
                                            IconPath.halfstar,
                                            height: 15,
                                            width: 15,
                                          );
                                        }
                                      }),
                                      SizedBox(width: 5),
                                      Text(
                                        "${rapportenController.averageRating.value.toStringAsFixed(1)}/5",
                                        style: getTextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  Container(
                                    height: 29,
                                    width: 95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(
                                        0xff98DFC4,
                                      ).withValues(alpha: 0.44),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${rapportenController.positivePercentage.value}% Positief",
                                        style: getTextStyle(
                                          color: Color(0xff00A463),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: rapportenController.reviews.length,
                            itemBuilder: (context, index) {
                              var review = rapportenController.reviews[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                ),
                                child: ReviewCard(
                                  name: review['name'],
                                  profileImage: review['profileImage'],
                                  rating: review['rating'],
                                  reviewText: review['reviewText'],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
