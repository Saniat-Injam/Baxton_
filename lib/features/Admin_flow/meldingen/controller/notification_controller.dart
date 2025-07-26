import 'package:baxton/features/Admin_flow/meldingen/model/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxString selectedFilter = 'Alle'.obs;
  RxList<NotificationModel> allNotifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    allNotifications.value = [
      NotificationModel(
        message:
            "Je taak om het dak van het XYZ-pand te inspecteren is toegewezen. Bekijk de details.",
        time: "15h",
        userImage: "https://randomuser.me/api/portraits/men/1.jpg",
        isRead: false,
        type: "Medewerker",
      ),
      NotificationModel(
        message:
            "Het loodgietersysteem van het ABC-gebouw heeft onderhoud nodig. Plan een bezoek.",
        time: "2d",
        userImage: "https://randomuser.me/api/portraits/men/2.jpg",
        isRead: true,
        type: "Klant",
      ),
      NotificationModel(
        message:
            "Je hebt een vergadering over het HVAC-systeem op het DEF-kantoor. Bevestig je aanwezigheid.",
        time: "1d",
        userImage: "https://randomuser.me/api/portraits/men/3.jpg",
        isRead: true,
        type: "Medewerker",
      ),
      NotificationModel(
        message:
            "Het landschapsontwerp voor het GHI-park is afgerond. Bekijk de voorstellen.",
        time: "3d",
        userImage: "https://randomuser.me/api/portraits/men/4.jpg",
        isRead: false,
        type: "Medewerker",
      ),
      NotificationModel(
        message:
            "Evalueer alstublieft de elektrische bedrading in het JKL-magazijn. Rapporteer bevindingen.",
        time: "5h",
        userImage: "https://randomuser.me/api/portraits/men/5.jpg",
        isRead: true,
        type: "Medewerker",
      ),
      NotificationModel(
        message:
            "De brandveiligheidsaudit voor het MNO-complex is binnenkort verschuldigd. Bereid de benodigde documenten voor.",
        time: "1w",
        userImage: "https://randomuser.me/api/portraits/men/6.jpg",
        isRead: true,
        type: "Medewerker",
      ),
      NotificationModel(
        message:
            "Je analyse van bouwmaterialen voor de PQR-locatie is nu nodig. Dien je rapport in.",
        time: "4d",
        userImage: "https://randomuser.me/api/portraits/men/7.jpg",
        isRead: true,
        type: "Medewerker",
      ),
    ];
  }

  void markAllAsRead() {
    allNotifications.value =
        allNotifications
            .map(
              (n) => NotificationModel(
                message: n.message,
                time: n.time,
                userImage: n.userImage,
                isRead: true,
                type: n.type,
              ),
            )
            .toList();
  }

  void setFilter(String type) {
    selectedFilter.value = type;
  }

  List<NotificationModel> get filteredNotifications {
    if (selectedFilter.value == 'Alle') {
      return allNotifications;
    } else {
      return allNotifications
          .where((notification) => notification.type == selectedFilter.value)
          .toList();
    }
  }

  int getNotificationCountForFilter(String filter) {
    if (filter == 'Alle') {
      return allNotifications.length;
    } else {
      return allNotifications.where((n) => n.type == filter).length;
    }
  }
}
