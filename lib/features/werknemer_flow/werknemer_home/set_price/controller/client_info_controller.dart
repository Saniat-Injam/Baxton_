import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/client_info_model.dart';
import 'package:get/get.dart';

class ClientInfoController extends GetxController {
  // final ClientInfoModel info;
  // ClientInfoController(this.info);

  var clientInfo = <ClientInfoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() {
    clientInfo.value = [
      ClientInfoModel(
        customerName: 'Virág Mercédesz',
        customerAddress: '258 Cedar St',
        customerPhone: '+123456789',

        location: 'New York',
        dateTime: DateTime(2025, 4, 23, 11, 0),
      ),
      ClientInfoModel(
        customerName: 'Virág Mercédesz',
        customerAddress: '258 Cedar St',
        customerPhone: '+123456789',

        location: 'Los Angeles',
        dateTime: DateTime(2025, 4, 23, 9, 30),
      ),
      ClientInfoModel(
        customerName: 'Virág Mercédesz',
        customerAddress: '258 Cedar St',
        customerPhone: '+123456789',

        location: 'Chicago',
        dateTime: DateTime(2025, 4, 23, 14, 0),
      ),
    ];
  }
}
