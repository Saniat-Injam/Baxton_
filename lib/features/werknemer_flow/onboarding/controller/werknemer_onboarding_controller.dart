import 'package:baxton/features/werknemer_flow/authentication/views/worker_login_screen.dart';
import 'package:baxton/features/werknemer_flow/onboarding/model/werknemer_onboarding_model.dart';
import 'package:get/get.dart';

class WOnbController extends GetxController {
  var currentPage = 0.obs;

  List<WOnbModel> wOnbPages = [
    WOnbModel(
      imagePath: 'assets/images/worker1.png',
      title: "Welkom bij Baxton Field\n Services!",
      description:
          "Vereenvoudig uw taken, volg uw werk en blijf georganiseerd — allemaal vanaf uw mobiele apparaat.",
    ),
    WOnbModel(
      imagePath: 'assets/images/worker2.png',
      title: 'Beheer Uw Taken Altijd\n en Overal',
      description:
          'Bekijk, werk bij en voltooi taken onderweg.\nOntvang real-time updates voor uw toegewezen opdrachten.',
    ),
    WOnbModel(
      imagePath: 'assets/images/worker3.png',
      title: "Maak Foto's & Krijg\n Klantbevestiging",
      description:
          "Neem foto's, verzamel digitale handtekeningen en\n houd nauwkeurige gegevens van uw werk in\n enkele seconden bij.",
    ),
  ];

  RxList<double> topPaddings = <double>[200, 120, 145].obs;
  RxList<double> imageHeights = <double>[0.25, 0.35, 0.32].obs;

  void goToNextPage() {
    if (currentPage.value < wOnbPages.length - 1) {
      currentPage.value++;
    } else {
      Get.off(() => WorkerLoginScreen());
    }
  }
}
