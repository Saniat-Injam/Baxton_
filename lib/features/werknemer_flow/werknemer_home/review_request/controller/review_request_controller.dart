import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/model/review_request_model.dart';
import 'package:get/get.dart';

class ReviewRequestController extends GetxController {
  final reviewData =
      ReviewRequestModel(
        invoiceNumber: "INV-2025-001",
        issuedDate: "April 14, 2025",
        dueDate: "April 28, 2025",
        clientName: "Samantha Green",
        clientPhone: "+001 234 567",
        clientEmail: "example123@gmail.com",
        clientCity: "London",
        clientPostcode: "1243",
        employeeName: "Samantha Green",
        employeePhone: "+001 234 567",
        serviceDetails: {
          "Maatinspectie": 500,
          "Schilderen & Coaten": 1000,
          "Nicotinevlekken Verwijderen": 3500,
        },
        bankName: "Bank of Netherlands",
        iban: "NL20BANK1234567890",
        bic: "BANKNL2A",
      ).obs;
}
