import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:get/get.dart';

class SetPriceController extends GetxController {
  var allSetPricetasks = <SetPriceTaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() {
    allSetPricetasks.value = [
      SetPriceTaskModel(
        title: 'Inspecteer het dak',
        shortDescription:
            'Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.',
        description:
            "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",
        location: 'New York',
        dateTime: DateTime(2025, 4, 23, 11, 0),
        prepay: true,
        customerName: 'Jan de Vries',
        customerPhone: '0612345678',
        customerAddress: 'Amsterdam',
      ),
      SetPriceTaskModel(
        title: 'Reinig de goten',
        shortDescription:
            'Verwijder bladeren en vuil uit de goten voor goede afwatering en controleer op blokkades.',
        description:
            "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",
        location: 'Los Angeles',
        dateTime: DateTime(2025, 4, 23, 9, 30),
      ),
      SetPriceTaskModel(
        title: 'Inspecteer de fundering',
        shortDescription:
            'Controleer de fundering op scheuren of tekenen van verzakking. Kijk of er water rond de basis van de structuur verzamelt.',
        description:
            "Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!",
        location: 'Chicago',
        dateTime: DateTime(2025, 4, 23, 14, 0),
      ),
    ];
  }

  void onSetPrice(SetPriceTaskModel task) {
    Get.snackbar('Prijs Instellen', 'Stel prijs in voor "${task.title}"');
  }
}
