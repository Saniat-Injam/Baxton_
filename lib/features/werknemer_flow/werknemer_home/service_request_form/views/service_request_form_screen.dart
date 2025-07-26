// import 'dart:io';
// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/view/review_request_screen.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/controller/service_request_controller.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/views/widget/custom_dropdown_field.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/views/widget/custom_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class ServiceRequestForm extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   final ServiceRequestController serviceRequestController = Get.put(
//     ServiceRequestController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () => Get.back(),
//           child: Row(
//             children: [
//               const SizedBox(width: 16),
//               Image.asset(IconPath.arrowBack),
//             ],
//           ),
//         ),
//         title: Text(
//           'Vraag Dienst aan', // Request Service
//           style: getTextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: AppColors.primaryBlack,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Name
//               CustomTextField(
//                 label: 'Naam',
//                 height: 41,
//                 onChanged: (val) {
//                   serviceRequestController.request.update((r) {
//                     if (r != null) r.name = val;
//                   });
//                 },
//               ),
//               SizedBox(height: 16),

//               // Telephone
//               CustomTextField(
//                 label: 'Telefoonnummer',
//                 height: 41,
//                 onChanged:
//                     (val) => serviceRequestController.request.update(
//                       (r) => r?.phone = val,
//                     ),
//               ),
//               SizedBox(height: 16),

//               // Email
//               CustomTextField(
//                 label: 'E-mail',
//                 height: 41,
//                 onChanged:
//                     (val) => serviceRequestController.request.update(
//                       (r) => r?.email = val,
//                     ),
//                 initial: 'example123@gmail.com',
//               ),
//               SizedBox(height: 16),
//               // City and Postcode
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Obx(
//                       () => MyDropdown(
//                         height: 41,
//                         label: 'Stad',
//                         value: serviceRequestController.selectedCity.value,
//                         items: serviceRequestController.cities,
//                         onChanged:
//                             (val) =>
//                                 serviceRequestController.selectedCity.value =
//                                     val!,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: CustomTextField(
//                       label: 'Postcode',
//                       height: 41,
//                       onChanged:
//                           (val) => serviceRequestController.request.update(
//                             (r) => r?.postalCode = val,
//                           ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),

//               // Describe Location
//               CustomTextField(
//                 label: 'Beschrijf Locatie',
//                 onChanged:
//                     (val) => serviceRequestController.request.update(
//                       (r) => r?.locationDesc = val,
//                     ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 16),

//               // Task Types
//               Text("Taaktype"),
//               SizedBox(height: 8),
//               Obx(
//                 () => SizedBox(
//                   height: 41,
//                   child: DropdownButtonFormField<String>(
//                     //decoration: InputDecoration(labelText: 'Taaktype'),
//                     value:
//                         serviceRequestController.selectedTaskType.value.isEmpty
//                             ? null
//                             : serviceRequestController.selectedTaskType.value,
//                     items:
//                         serviceRequestController.taskTypes
//                             .map(
//                               (task) => DropdownMenuItem(
//                                 value: task,
//                                 child: Text(task),
//                               ),
//                             )
//                             .toList(),
//                     onChanged:
//                         (val) =>
//                             serviceRequestController.selectedTaskType.value =
//                                 val!,
//                     style: TextStyle(
//                       color: AppColors.primaryBlack,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 10,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: AppColors.formFieldBorderColor,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: AppColors.formFieldBorderColor,
//                         ),
//                       ),
//                     ),
//                     icon: Image.asset(IconPath.arrowDown3),
//                     dropdownColor: AppColors.primaryWhite,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Describe Problem
//               CustomTextField(
//                 label: 'Beschrijf Probleem',
//                 height: 41,
//                 onChanged:
//                     (val) => serviceRequestController.request.update(
//                       (r) => r?.problemDesc = val,
//                     ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 16),

//               // Upload Picture from gallery
//               GestureDetector(
//                 onTap: serviceRequestController.pickImage,
//                 child: Obx(
//                   () => Container(
//                     height: 150,
//                     width: double.infinity,

//                     decoration: BoxDecoration(
//                       color: AppColors.primaryGrey,
//                       borderRadius: BorderRadius.circular(12),
//                     ),

//                     child:
//                         serviceRequestController
//                                 .selectedImagePath
//                                 .value
//                                 .isNotEmpty
//                             ? Image.file(
//                               File(
//                                 serviceRequestController
//                                     .selectedImagePath
//                                     .value,
//                               ),
//                               fit: BoxFit.cover,
//                             )
//                             : Image.asset(IconPath.photoUpload),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // Capture Photo by Camera
//               GestureDetector(
//                 onTap: serviceRequestController.captureImage,
//                 child: Obx(
//                   () => Container(
//                     height: 70,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: AppColors.secondaryBlue,
//                       border: Border.all(color: AppColors.primaryBlue),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child:
//                         serviceRequestController
//                                 .capturedImagePath
//                                 .value
//                                 .isNotEmpty
//                             ? Image.file(
//                               File(
//                                 serviceRequestController
//                                     .capturedImagePath
//                                     .value,
//                               ),
//                               fit: BoxFit.cover,
//                             )
//                             : Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(IconPath.camera),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   'Afbeelding',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: AppColors.primaryBlue,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),

//               // Preferred Time and Date
//               Row(
//                 children: [
//                   // time
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Voorkeurs Tijd'),
//                         const SizedBox(height: 8),
//                         Obx(
//                           () => SizedBox(
//                             height: 41,
//                             child: DropdownButtonFormField<String>(
//                               decoration: InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: AppColors.formFieldBorderColor,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: AppColors.formFieldBorderColor,
//                                   ),
//                                 ),
//                                 isDense: true,
//                               ),
//                               value:
//                                   serviceRequestController
//                                           .selectedTime
//                                           .value
//                                           .isEmpty
//                                       ? null
//                                       : serviceRequestController
//                                           .selectedTime
//                                           .value,
//                               items:
//                                   ['Ochtend', 'Middag', 'Avond']
//                                       .map(
//                                         (time) => DropdownMenuItem(
//                                           value: time,
//                                           child: Text(time),
//                                         ),
//                                       )
//                                       .toList(),
//                               onChanged:
//                                   (val) =>
//                                       serviceRequestController.setTime(val!),
//                               icon: Image.asset(IconPath.arrowDown3),
//                               dropdownColor: AppColors.primaryWhite,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),

//                   // date
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Voorkeurs Datum'),
//                         const SizedBox(height: 8),
//                         Obx(() {
//                           final selectedDate =
//                               serviceRequestController.selectedDate.value;
//                           final controller = TextEditingController(
//                             text:
//                                 selectedDate != null
//                                     ? DateFormat(
//                                       'dd/MM/yyyy',
//                                     ).format(selectedDate)
//                                     : '',
//                           );

//                           return SizedBox(
//                             height: 41,
//                             child: TextFormField(
//                               readOnly: true,
//                               controller: controller,
//                               decoration: InputDecoration(
//                                 hintText: 'DD/MM/YYYY',
//                                 hintStyle: TextStyle(
//                                   color: AppColors.primaryBlack,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: AppColors.formFieldBorderColor,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: AppColors.formFieldBorderColor,
//                                   ),
//                                 ),
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: 8,
//                                 ),
//                                 prefixIcon: Image.asset(
//                                   IconPath.calendarMonth,
//                                   color: AppColors.primaryGold,
//                                 ),
//                               ),

//                               onTap: () async {
//                                 final date = await showDatePicker(
//                                   context: Get.context!,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime.now(),
//                                   lastDate: DateTime(2100),
//                                   builder: (context, child) {
//                                     return Theme(
//                                       data: Theme.of(context).copyWith(
//                                         colorScheme: ColorScheme.light(
//                                           surface:
//                                               AppColors
//                                                   .primaryWhite, // Background of the dialog
//                                           primary:
//                                               AppColors
//                                                   .primaryGold, // Header and selected date
//                                           onPrimary:
//                                               AppColors
//                                                   .primaryWhite, // Text color on selected date
//                                           onSurface:
//                                               AppColors
//                                                   .primaryBlack, // Default text color
//                                         ),
//                                         // dialogTheme: DialogTheme(
//                                         //   backgroundColor: Color(
//                                         //     0xFFF9F9F9,
//                                         //   ), // Not required but can ensure fallback
//                                         // ),
//                                       ),
//                                       child: child!,
//                                     );
//                                   },
//                                 );
//                                 if (date != null) {
//                                   serviceRequestController.setDate(date);
//                                 }
//                               },
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),

//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       hintText: "Dient",
//                       height: 41,
//                       onChanged:
//                           (val) => serviceRequestController.request.update(
//                             (r) => r?.amount = val,
//                           ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: CustomTextField(
//                       hintText: "\$5000",
//                       height: 41,
//                       onChanged:
//                           (val) => serviceRequestController.request.update(
//                             (r) => r?.amount = val,
//                           ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),

//               // Add Button
//               Image.asset(IconPath.largeCircularAdd),

//               const SizedBox(height: 30),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     // if (_formKey.currentState!.validate()) {
//               //     //   serviceRequestController.submitRequest();
//               //     // }
//               //     Get.to(() => ReviewRequestScreen());
//               //   },
//               //   style: ElevatedButton.styleFrom(
//               //     minimumSize: Size.fromHeight(48),
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(63),
//               //     ),
//               //   ),
//               //   child: const Text('Create Task'),
//               // ),

//               ElevatedButton(
//   onPressed: () async {
//     if (_formKey.currentState!.validate()) {
//       await serviceRequestController.submitRequest();
//     }
//   },
//   child: Text('Create Task'),
// )
// ,

//               const SizedBox(height: 26),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// full_service_request_screen.dart
import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/controller/service_request_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/views/widget/custom_dropdown_field.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/views/widget/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ServiceRequestForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ServiceRequestController serviceRequestController = Get.put(
    ServiceRequestController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(IconPath.arrowBack),
            ],
          ),
        ),
        title: Text(
          'Vraag Dienst aan',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Naam',
                height: 41,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.name = val,
                    ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Telefoonnummer',
                height: 41,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.phone = val,
                    ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'E-mail',
                height: 41,
                initial: 'example123@gmail.com',
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.email = val,
                    ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => MyDropdown(
                        height: 41,
                        label: 'Stad',
                        value: serviceRequestController.selectedCity.value,
                        items: serviceRequestController.cities,
                        onChanged:
                            (val) =>
                                serviceRequestController.selectedCity.value =
                                    val!,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CustomTextField(
                      label: 'Postcode',
                      height: 41,
                      onChanged:
                          (val) => serviceRequestController.request.update(
                            (r) => r?.postalCode = val,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Beschrijf Locatie',
                maxLines: 3,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.locationDesc = val,
                    ),
              ),
              SizedBox(height: 16),
              Text("Taaktype"),
              SizedBox(height: 8),
              Obx(
                () => MyDropdown(
                  height: 41,
                  label: '',
                  value: serviceRequestController.selectedTaskType.value,
                  items: serviceRequestController.taskTypes,
                  onChanged:
                      (val) =>
                          serviceRequestController.selectedTaskType.value =
                              val!,
                ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Beschrijf Probleem',
                maxLines: 3,
                onChanged:
                    (val) => serviceRequestController.request.update(
                      (r) => r?.problemDesc = val,
                    ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: serviceRequestController.pickImage,
                child: Obx(
                  () => Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        serviceRequestController
                                .selectedImagePath
                                .value
                                .isNotEmpty
                            ? Image.file(
                              File(
                                serviceRequestController
                                    .selectedImagePath
                                    .value,
                              ),
                              fit: BoxFit.cover,
                            )
                            : Image.asset(IconPath.photoUpload),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Voorkeurs Tijd'),
                        SizedBox(height: 8),
                        Obx(
                          () => MyDropdown(
                            height: 41,
                            label: '',
                            value: serviceRequestController.selectedTime.value,
                            items: ['Ochtend', 'Middag', 'Avond'],
                            onChanged:
                                (val) => serviceRequestController.setTime(val!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Voorkeurs Datum'),
                        SizedBox(height: 8),
                        Obx(() {
                          final selectedDate =
                              serviceRequestController.selectedDate.value;
                          final controller = TextEditingController(
                            text:
                                selectedDate != null
                                    ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(selectedDate)
                                    : '',
                          );
                          return SizedBox(
                            height: 41,
                            child: TextFormField(
                              readOnly: true,
                              controller: controller,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  serviceRequestController.setDate(date);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'DD/MM/YYYY',
                                prefixIcon: Image.asset(
                                  IconPath.calendarMonth,
                                  color: AppColors.primaryGold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.formFieldBorderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.formFieldBorderColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await serviceRequestController.submitRequest();
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(63),
                  ),
                ),
                child: const Text('Create Task'),
              ),
              SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
