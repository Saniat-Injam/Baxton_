// ignore_for_file: unused_local_variable, must_be_immutable
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:baxton/features/klant_flow/home_screen/controller/home_controller.dart';
import 'package:baxton/features/klant_flow/home_screen/widgets/infocard.dart';
import 'package:baxton/features/klant_flow/home_screen/widgets/service_widget.dart';
import 'package:baxton/features/klant_flow/notification/screens/notification_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/job_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/request_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_icon_button.dart';
import 'package:get/get.dart';
import '../models/home_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Initialize controllers
  final TaskController taskController = Get.put(TaskController());
  final JobController jobsController = Get.put(JobController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    List<Service> services = homeController.getFirstTwoServices();

    return Obx(() {
      if (homeController.isLoading.value) {
        return Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryGold),
            ),
          ),
        );
      }

      // If there's an error, show the error message
      if (homeController.errorMessage.value.isNotEmpty) {
        return Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          body: SafeArea(
            child: Center(
              child: Text(
                homeController.errorMessage.value,
                style: getTextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      }

      // Once profile is loaded successfully, trigger fetchServiceRequests
      if (homeController.profile.value != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          jobsController.fetchServiceRequests();
        });
      }

      // Main UI when profile is loaded
      return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hallo",
                                style: getTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(width: 4),
                              Image.asset(IconPath.hi, height: 20, width: 20),
                              SizedBox(width: 4),
                              Text(
                                homeController.profile.value?.data.user.name ??
                                    "Russel",
                                style: getTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Welkom terug",
                            style: getTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: Color(0xffFBF6E6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/icons/notifications.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: AppColors.buttonPrimary,
                      ),
                      Text(
                        homeController
                                .profile
                                .value
                                ?.data
                                .user
                                .clientProfile
                                .location ??
                            "21 Baker Street, London",
                        style: getTextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 133,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(ImagePath.card),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Van Schimmel tot \nOnderhoud-wij Hebben \nHet Gedekt.",
                        style: getTextStyle(
                          color: AppColors.textFifth,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomIconButton(
                    text: "Vraag Service Aan",
                    icon: Icons.add,
                    onTap: () {
                      Get.to(RequestScreen());
                    },
                    buttonColor: AppColors.buttonPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    isPrefix: false,
                  ),
                   SizedBox(height: 40),
                  Text(
                    "Aangevraagde Service",
                    style: getTextStyle(
                      fontSize: 24,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   SizedBox(height: 20),
                  Obx(() {
                    final requestedServices =
                        jobsController.getRequestedServices();
                    if (requestedServices.isEmpty) {
                      return Text(
                        "Geen aangevraagde diensten",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textThird,
                        ),
                      );
                    }
                    return Column(
                      children:
                          requestedServices
                              .map(
                                (service) => ServiceContainer(service: service),
                              )
                              .toList(),
                    );
                  }),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(TaskScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bekijk Alles",
                          style: getTextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: AppColors.primaryGold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Onze Diensten",
                    style: getTextStyle(
                      fontSize: 24,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  InfoCard(
                    title: "Schimmelinspecties & \nBehandelingen",
                    description:
                        "Door inspecties en effectieve behandelingen om \nschimmelproblemen te voorkomen en op te lossen",
                    iconPath: IconPath.moldinspection,
                  ),
                  SizedBox(height: 12),
                  InfoCard(
                    title: "Voor- en na-inspecties van \nhuurwoningen & Nazorg",
                    description:
                        "Wij bieden inspecties voor en na de overdracht van \nonroerend goed en verzorgen alle nazorg met \nbetrekking tot leveringsproblemen.",
                    iconPath: IconPath.prepostinspection,
                    backgroundColor: Color(0xffF1CBBC),
                  ),
                  SizedBox(height: 12),
                  InfoCard(
                    title: "Vochtbeheersing",
                    description:
                        "Wij bieden oplossingen voor vochtproblemen om \nonroerend goed droog en veilig te houden",
                    iconPath: IconPath.moisturecontrol,
                    backgroundColor: Color(0xff4BBBEB),
                  ),
                  SizedBox(height: 12),
                  InfoCard(
                    title: "Stucwerk",
                    description:
                        "Alle soorten stucwerk, van renovatie tot afwerking, \nmet aandacht voor detail",
                    iconPath: IconPath.stucco,
                    backgroundColor: Color(0xffF1CBBC),
                  ),
                  SizedBox(height: 12),
                  InfoCard(
                    title: "Schilderen & Coaten",
                    description:
                        "Professionele binnen- en buitenschilder- en \ncoatingdiensten voor perfecte resultaten",
                    iconPath: IconPath.painting,
                    backgroundColor: Color(0xffFFD039),
                  ),
                  SizedBox(height: 12),
                  InfoCard(
                    title: "Nicotinevlekkenverwijdering",
                    description:
                        "Effectieve verwijdering van nicotinevlekken om een \nschone en frisse binnenomgeving te herstellen.",
                    iconPath: IconPath.nicotine,
                    backgroundColor: Color(0xff7A6D79),
                  ),
                  SizedBox(height: 12),
                  InfoCard(
                    title: "Reddersteam & Nooddienst (24/7)",
                    description:
                        "Ons reddersteam is 24/7 beschikbaar voor opruiming \nen ontruiming na brand-, water- of rookschade of in \ngeval van overlijden.",
                    iconPath: IconPath.recueteam,
                    backgroundColor: Color(0xffFD4755),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
