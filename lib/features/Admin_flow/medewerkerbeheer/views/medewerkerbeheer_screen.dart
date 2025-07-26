// ignore_for_file: use_build_context_synchronously
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_search_field.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/controller/medewerkerbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/views/medewerker_gegevens.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedewerkerbeheerScreen extends StatelessWidget {
  MedewerkerbeheerScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MedewerkerbeheerController medewerkerbeheerController = Get.put(
    MedewerkerbeheerController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
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
          "Werknemersbeheer",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 132,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Color(0xffEBEBEB)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconPath.human,
                                height: 40,
                                width: 40,
                              ),
                              Spacer(),
                              Text(
                                "Active Werknemer",
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffA1A1A1),
                                ),
                              ),
                              Spacer(),
                              Obx(() => Text(
                                    "${medewerkerbeheerController.employees.where((e) => e.user != null).length}",
                                    style: getTextStyle(
                                      color: Color(0xff62B2FD),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 132,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Color(0xffEBEBEB)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconPath.lowhuman,
                                height: 40,
                                width: 40,
                              ),
                              Spacer(),
                              Text(
                                "Inactive Werknemer",
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffA1A1A1),
                                ),
                              ),
                              Spacer(),
                              Obx(() => Text(
                                    "${medewerkerbeheerController.employees.where((e) => e.user == null).length}",
                                    style: getTextStyle(
                                      color: AppColors.primaryGold,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 132,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset(
                          IconPath.totalaantal,
                          height: 40,
                          width: 40,
                        ),
                        Spacer(),
                        Text(
                          "Totaal Aantal Werknemers",
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffA1A1A1),
                          ),
                        ),
                        Spacer(),
                        Obx(() => Text(
                              "${medewerkerbeheerController.employees.length}",
                              style: getTextStyle(
                                color: Color(0xff33DB2A),
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: CustomSearchTextField(
                          hintText: "",
                          controller: medewerkerbeheerController.searchController,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 18,
                            color: AppColors.primaryGold,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: Color(0xffF3E2B0)),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                insetPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Filter",
                                        style: getTextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text("Locatie", style: getTextStyle()),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        items: ['New York', 'Canada', 'USA', 'Dhaka', 'Test']
                                            .map(
                                              (location) => DropdownMenuItem(
                                                value: location,
                                                child: Text(
                                                  location,
                                                  style: getTextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.primaryGold,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            medewerkerbeheerController.setSelectedLocation(value);
                                          }
                                          if (medewerkerbeheerController.selectedLocation != null &&
                                              medewerkerbeheerController.selectedExpertise != null) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        hint: Text(
                                          'Stad',
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryGold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Expertise", style: getTextStyle()),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        items: [
                                          'Specialist Schimmelremediëring',
                                          'Specialist Woninginspecties',
                                          'Vochtbeheersing Technicus',
                                          'Specialist Pleisterwerken',
                                          'Schilder',
                                          'Nicotinevlekken Verwijdering Technicus',
                                          'Nooddienst Technicus',
                                          'Schimmel Inspecties Behandelingen',
                                        ].map(
                                          (skill) => DropdownMenuItem(
                                            value: skill,
                                            child: Text(
                                              skill,
                                              style: getTextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primaryGold,
                                              ),
                                            ),
                                          ),
                                        ).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            medewerkerbeheerController.setSelectedExpertise(value);
                                          }
                                          if (medewerkerbeheerController.selectedLocation != null &&
                                              medewerkerbeheerController.selectedExpertise != null) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        hint: Text(
                                          'Inspecteer het dak',
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryGold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Image.asset(
                          IconPath.filter,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: medewerkerbeheerController.filteredEmployees.length, // Use filteredEmployees
                      itemBuilder: (context, index) {
                        final employee = medewerkerbeheerController.filteredEmployees[index];
                        return ProfileCard(
                          imagePath: employee.profilePic?.url ?? IconPath.profilepic,
                          name: employee.user?.name ?? employee.userName ?? "Unknown",
                          designation: employee.workerSpecialist?.name ?? 'Geen specialisatie',
                          onTap: () async {
                            final workerDetails = await medewerkerbeheerController.fetchWorkerDetails(employee.id);
                            if (workerDetails != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MedewerkerGegevens(workerDetails: workerDetails),
                                ),
                              );
                            }
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}