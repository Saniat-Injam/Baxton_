// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
// import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/controllers/task_creation_controller.dart';
// import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
// import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/task_type_model.dart';
// import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart'
//     hide Employee;
// import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/employee_selection_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateNewTaskScreen extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final TaskCreationController taskCreationController = Get.put(
//     TaskCreationController(),
//   );
//   final EmployeeController empController = Get.find<EmployeeController>();

//   // Helper function to format task type names
//   String _formatTaskTypeName(String name) {
//     if (name.isEmpty) return name;
//     String formatted = name.toLowerCase().replaceAll('_', ' ');
//     return formatted[0].toUpperCase() + formatted.substring(1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.containerColor,
//       key: _scaffoldKey,
//       drawer: Navbar(),
//       appBar: AppBar(
//         title: Text("Taakcreatie"),
//         titleSpacing: 0,
//         leading: IconButton(
//           icon: Image.asset(IconPath.notes),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Taaktype"),
//               SizedBox(height: 8),
//               Obx(
//                 () => DropdownButtonFormField<String>(
//                   value: taskCreationController.selectedTaskType.value,
//                   items:
//                       taskCreationController.taskTypes.isNotEmpty
//                           ? taskCreationController.taskTypes.map<
//                             DropdownMenuItem<String>
//                           >((TaskType taskType) {
//                             return DropdownMenuItem<String>(
//                               value: taskType.name,
//                               child: Text(_formatTaskTypeName(taskType.name)),
//                             );
//                           }).toList()
//                           : [
//                             DropdownMenuItem<String>(
//                               value: null,
//                               child: Text('Geen taaktypen beschikbaar'),
//                             ),
//                           ],
//                   onChanged: (String? val) {
//                     taskCreationController.selectedTaskType.value = val;
//                   },
//                   style: TextStyle(
//                     color: AppColors.primaryGold,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: AppColors.secondaryWhite),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   icon: Image.asset(IconPath.dropDown2),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // 2nd Element: First Text Field
//               Text("Taakomschrijving"),
//               SizedBox(height: 8),
//               TextField(
//                 controller: taskCreationController.descriptionController,
//                 decoration: InputDecoration(
//                   hintText: "Beschirijf de taak",
//                   hintStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.secondaryBlack,
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: AppColors.secondaryWhite),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 maxLines: 4,
//               ),
//               const SizedBox(height: 12),

//               // 3rd Element: Second Text Field
//               Text("Naam van de klant"),
//               SizedBox(height: 8),
//               SizedBox(
//                 height: 44,
//                 child: TextField(
//                   controller: taskCreationController.nameController,
//                   decoration: InputDecoration(
//                     hintText: "Virág Mercédesz",
//                     hintStyle: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.primaryBlack,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: AppColors.secondaryWhite),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text("klant email"),
//               SizedBox(height: 8),
//               SizedBox(
//                 height: 44,
//                 child: TextField(
//                   controller: taskCreationController.nameController,
//                   decoration: InputDecoration(
//                     hintText: "klant@gmail.com",
//                     hintStyle: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.primaryBlack,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: AppColors.secondaryWhite),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // 4th Element: 3rd Text Box (Telephone Number)
//               Text("Telefoonnummer van de klant"),
//               SizedBox(height: 8),
//               SizedBox(
//                 height: 44,
//                 child: TextField(
//                   controller: taskCreationController.phoneController,
//                   decoration: InputDecoration(
//                     hintText: "+123456789",
//                     hintStyle: getTextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.primaryBlack,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: AppColors.secondaryWhite),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   keyboardType: TextInputType.phone,
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // 5th Element: 4th Text Box (Location)
//               Row(
//                 children: [
//                   // First Column
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Locatie van de klant",
//                         ), // Change the label text for differentiation
//                         SizedBox(height: 8),
//                         SizedBox(
//                           height: 44,
//                           child: TextField(
//                             controller:
//                                 taskCreationController
//                                     .locationController, // Use a different controller for each TextField
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: AppColors.secondaryWhite,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   // Second Column
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Postal Code",
//                         ), // Change the label text for differentiation
//                         SizedBox(height: 8),
//                         SizedBox(
//                           height: 44,
//                           child: TextField(
//                             controller:
//                                 taskCreationController
//                                     .locationController, // Use a different controller for each TextField
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: AppColors.secondaryWhite,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 12),
//               Text("Describe Location"),
//               SizedBox(height: 8),
//               SizedBox(
//                 height: 44,
//                 child: TextField(
//                   controller: taskCreationController.phoneController,
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     hintText: "",
//                     hintStyle: getTextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.primaryBlack,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: AppColors.secondaryWhite),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   keyboardType: TextInputType.text,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               _buildImageSection(context),
//               const SizedBox(height: 12),
//               // Date and Time
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 44,
//                       child: TextField(
//                         controller: taskCreationController.dateController,
//                         decoration: InputDecoration(
//                           hintText: "DD/MM/YY",
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: AppColors.secondaryWhite,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onTap: () async {
//                           FocusScope.of(context).requestFocus(FocusNode());
//                           DateTime? picked = await showDatePicker(
//                             context: context,
//                             initialDate:
//                                 taskCreationController.preferredDate.value,
//                             firstDate: DateTime.now(),
//                             lastDate: DateTime(2100),
//                           );
//                           if (picked != null) {
//                             taskCreationController.preferredDate.value = picked;
//                             taskCreationController.dateController.text =
//                                 "${picked.day}/${picked.month}/${picked.year}";
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: SizedBox(
//                       height: 44,
//                       child: TextField(
//                         controller: taskCreationController.timeController,
//                         decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: AppColors.secondaryWhite,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         readOnly: true,
//                         onTap: () {
//                           // Optional: Add time picker
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Toegewezen aan"),
//                         const SizedBox(height: 8),
//                         InkWell(
//                           onTap: () async {
//                             final selected = await showDialog<Employee>(
//                               context: context,
//                               builder:
//                                   (_) => Dialog(
//                                     insetPadding: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                       vertical: 32,
//                                     ),
//                                     child: SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                           0.85,
//                                       child: EmployeeSelectionView(),
//                                     ),
//                                   ),
//                             );

//                             if (selected != null) {
//                               taskCreationController.selectedEmployee.value =
//                                   selected;
//                             }
//                           },
//                           child: Obx(() {
//                             final emp = empController.selectedEmployee.value;
//                             return Container(
//                               height: 44,
//                               width: double.infinity,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 12,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   emp?.name ?? 'Theresa Webb',
//                                   style: TextStyle(
//                                     color: AppColors.primaryGold,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Expertise"),
//                         const SizedBox(height: 8),
//                         Obx(() {
//                           final emp = empController.selectedEmployee.value;
//                           return Container(
//                             height: 44,
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFFFF3D6),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 emp?.expertise ?? 'Dak Specialist',
//                                 style: TextStyle(
//                                   color: AppColors.primaryGold,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: taskCreationController.createTask,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                     side: BorderSide(color: Colors.blue),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [Text("Taak aanmaken")],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: taskCreationController.cancel,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blue,
//                     side: BorderSide(color: Colors.blue),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [Text("Annuleren")],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/controllers/task_creation_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/task_type_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart'
    hide Employee;
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/employee_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewTaskScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TaskCreationController taskCreationController = Get.put(
    TaskCreationController(),
  );
  final EmployeeController empController = Get.find<EmployeeController>();

  // Helper function to format task type names
  String _formatTaskTypeName(String name) {
    if (name.isEmpty) return name;
    String formatted = name.toLowerCase().replaceAll('_', ' ');
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text("Taakcreatie"),
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Taaktype"),
              SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: taskCreationController.selectedTaskType.value,
                  items:
                      taskCreationController.taskTypes.isNotEmpty
                          ? taskCreationController.taskTypes.map<
                            DropdownMenuItem<String>
                          >((TaskType taskType) {
                            return DropdownMenuItem<String>(
                              value: taskType.name,
                              child: Text(_formatTaskTypeName(taskType.name)),
                            );
                          }).toList()
                          : [
                            DropdownMenuItem<String>(
                              value: null,
                              child: Text('Geen taaktypen beschikbaar'),
                            ),
                          ],
                  onChanged: (String? val) {
                    taskCreationController.selectedTaskType.value = val;
                  },
                  style: TextStyle(
                    color: AppColors.primaryGold,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Image.asset(IconPath.dropDown2),
                ),
              ),
              const SizedBox(height: 12),

              // 2nd Element: First Text Field
              Text("Taakomschrijving"),
              SizedBox(height: 8),
              TextField(
                controller: taskCreationController.descriptionController,
                decoration: InputDecoration(
                  hintText: "Beschrijf de taak",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryBlack,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryWhite),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 12),

              // 3rd Element: Second Text Field
              Text("Naam van de klant"),
              SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: taskCreationController.nameController,
                  decoration: InputDecoration(
                    hintText: "Virág Mercédesz",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text("Klant email"),
              SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: taskCreationController.nameController,
                  decoration: InputDecoration(
                    hintText: "klant@gmail.com",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 4th Element: 3rd Text Box (Telephone Number)
              Text("Telefoonnummer van de klant"),
              SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: taskCreationController.phoneController,
                  decoration: InputDecoration(
                    hintText: "+123456789",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 12),

              // 5th Element: 4th Text Box (Location)
              Row(
                children: [
                  // First Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Locatie van de klant"),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 44,
                          child: TextField(
                            controller:
                                taskCreationController.locationController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryWhite,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  // Second Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Postal Code"),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 44,
                          child: TextField(
                            controller:
                                taskCreationController.locationController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryWhite,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),
              Text("Describe Location"),
              SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: taskCreationController.phoneController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlack,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 12),
              _buildImageSection(context),
              const SizedBox(height: 12),
              // Date and Time
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: taskCreationController.dateController,
                        decoration: InputDecoration(
                          hintText: "DD/MM/YY",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondaryWhite,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate:
                                taskCreationController.preferredDate.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            taskCreationController.preferredDate.value = picked;
                            taskCreationController.dateController.text =
                                "${picked.day}/${picked.month}/${picked.year}";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: Obx(
                        () => GestureDetector(
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              taskCreationController
                                  .selectedTime
                                  .value = pickedTime.format(context);
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffC0C0C0),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    taskCreationController
                                            .selectedTime
                                            .value
                                            .isEmpty
                                        ? 'Selecteer Tijd' // This is your hint text
                                        : taskCreationController
                                            .selectedTime
                                            .value,
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          taskCreationController
                                                  .selectedTime
                                                  .value
                                                  .isEmpty
                                              ? AppColors
                                                  .textSecondary // Hint color
                                              : AppColors
                                                  .textPrimary, // Color for selected time
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  IconPath.dropdown,
                                  color: AppColors.buttonPrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Toegewezen aan"),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final selected = await showDialog<Employee>(
                              context: context,
                              builder:
                                  (_) => Dialog(
                                    insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 32,
                                    ),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.85,
                                      child: EmployeeSelectionView(),
                                    ),
                                  ),
                            );
                            if (selected != null) {
                              taskCreationController.selectedEmployee.value =
                                  selected;
                            }
                          },
                          child: Obx(() {
                            final emp = empController.selectedEmployee.value;
                            return Container(
                              height: 44,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  emp?.name ?? 'Theresa Webb',
                                  style: TextStyle(
                                    color: AppColors.primaryGold,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expertise"),
                        const SizedBox(height: 8),
                        Obx(() {
                          final emp = empController.selectedEmployee.value;
                          return Container(
                            height: 44,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3D6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                emp?.expertise ?? 'Dak Specialist',
                                style: TextStyle(
                                  color: AppColors.primaryGold,
                                  fontWeight: FontWeight.w500,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: taskCreationController.createTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Taak aanmaken")],
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: taskCreationController.cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Annuleren")],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffD9D9D9),
            ),
            child:
                taskCreationController.selectedImage.value != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        taskCreationController.selectedImage.value!,
                        fit: BoxFit.cover,
                      ),
                    )
                    : Icon(Icons.image_rounded, size: 50),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showImageSourceDialog(context),
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.buttonPrimary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: Color(0xff1E90FF)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt, color: Color(0xff1E90FF)),
                const SizedBox(height: 8),
                Text(
                  "Afbeelding",
                  style: getTextStyle(
                    color: const Color(0xff1E90FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Selecteer bron"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galerij'),
                  onTap: () {
                    Navigator.pop(context);
                    taskCreationController.pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    taskCreationController.pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
