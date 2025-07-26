// lib/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart
// ignore_for_file: unnecessary_null_comparison

import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/model/get_invoice_model.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/model/get_invoice_overview_model.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/model/invoice_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BetalingsbeheerController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  // Reactive variables for filters
  final Rx<String?> selectedMonth = Rx<String?>(null);
  final Rx<String?> selectedTaaktype = Rx<String?>(null);
  final Rx<String?> selectedTaakStatus = Rx<String?>(null);
  final Rx<String?> selectedYear = Rx<String?>(null);
  final RxBool isLoading = false.obs;

  var assignedTo = 'Theresa Webb'.obs;
  var expertise = 'Dak Specialist';
  var status = 'Betaling in afwachting'.obs;
  var amount = '\$5000'.obs;

  // Ensure assignees is an RxList<String>
  final RxList<String> assignees = <String>['Theresa Webb', 'John Doe', 'Emma Brown'].obs;

  List<String> statusOptions = [
    'Betaling in afwachting',
    'Bevestigd',
    'Voltooid',
  ];

  // Invoices list
  final RxList<Invoice> invoices = <Invoice>[].obs;

  // Invoice details
  final Rx<Invoic?> invoiceDetails = Rx<Invoic?>(null);

  // Stats
  final dollar = TaskStatsModel(
    assigned: 0,
    inProgress: 0,
    completed: 0,
    overdue: 0,
    unassigned: 0,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint('BetalingsbeheerController initialized');
    // Ensure unique assignees without breaking RxList
    assignees.assignAll(assignees.toSet()); // toSet() removes duplicates, assignAll maintains RxList
    debugPrint('Assignees initialized: ${assignees.toList()}');
    fetchInvoiceOverview();
  }

  Future<void> fetchInvoiceOverview() async {
    isLoading.value = true;
    try {
      debugPrint('Starting fetchInvoiceOverview');
      await EasyLoading.show(
        status: 'Loading invoices...',
        maskType: EasyLoadingMaskType.black,
      );
      debugPrint('EasyLoading shown');

      String? token = await AuthService.getToken();
      debugPrint('Token retrieved: ${token != null ? 'Valid token' : 'Null or empty token'}');

      if (token == null || token.isEmpty) {
        debugPrint('No token found. User is not authenticated.');
        await EasyLoading.showError('Authentication error: No token available');
        throw Exception('Token is not available');
      }

      final String apiUrl = Urls.getinvoiceoverview;
      debugPrint('Making GET request to $apiUrl');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('API response received with status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('Parsing JSON response');
        final jsonData = jsonDecode(response.body);
        debugPrint('JSON decoded: $jsonData');
        final invoiceOverview = getinvoiceoverview.fromJson(jsonData);
        debugPrint('Invoice overview parsed: success=${invoiceOverview.success}');

        if (invoiceOverview.success == true && invoiceOverview.data != null) {
          debugPrint('Processing invoice overview data');
          if (invoiceOverview.data!.totalInvoices != null) {
            final totalInvoices = invoiceOverview.data!.totalInvoices!;
            dollar.value = TaskStatsModel(
              assigned: totalInvoices.totalAmountReceived ?? 0,
              inProgress: totalInvoices.pendingPayments ?? 0,
              completed: totalInvoices.confirmedInvoicesCount ?? 0,
              overdue: totalInvoices.latePayments ?? 0,
              unassigned: invoiceOverview.data!.invoices
                      ?.where((i) => i.workerProfileId == null)
                      .length ??
                  0,
            );
          } else {
            debugPrint('No totalInvoices data found');
          }

          if (invoiceOverview.data!.invoices != null) {
            debugPrint('Processing invoices list');
            invoices.clear();
            debugPrint('Invoices list cleared');
            invoices.addAll(invoiceOverview.data!.invoices!.map((apiInvoice) {
              final invoice = Invoice(
                id: apiInvoice.id,
                invoiceNumber: apiInvoice.invoiceNumber ?? 'Unknown',
                customerName: apiInvoice.clientProfile?.user?.name ?? 'Unknown',
                taskName: apiInvoice.serviceRequest?.taskType?.name ?? 'Unknown',
                amount: '\$${apiInvoice.totalAmount ?? 0}',
                date: apiInvoice.dateIssued ?? 'Unknown',
                status: _mapInvoiceStatus(apiInvoice.invoiceStatus),
              );
              debugPrint('Mapped invoice: ${invoice.invoiceNumber}, id: ${invoice.id}, status: ${invoice.status}');
              return invoice;
            }).toList());
            debugPrint('Invoices list updated with ${invoices.length} invoices');
          } else {
            debugPrint('No invoices data found');
          }

          await EasyLoading.showSuccess('Invoices loaded successfully');
          debugPrint('EasyLoading success shown');
        } else {
          debugPrint('API returned unsuccessful response: ${invoiceOverview.message}');
          await EasyLoading.showError(invoiceOverview.message ?? 'Failed to fetch data');
        }
      } else {
        debugPrint('API request failed with status: ${response.statusCode}');
        await EasyLoading.showError('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in fetchInvoiceOverview: $e');
      await EasyLoading.showError('An error occurred: $e');
    } finally {
      isLoading.value = false;
      await EasyLoading.dismiss();
      debugPrint('EasyLoading dismissed');
    }
  }

  Future<void> fetchInvoiceDetails(String invoiceId) async {
    isLoading.value = true;
    try {
      debugPrint('Starting fetchInvoiceDetails for ID: $invoiceId');
      await EasyLoading.show(
        status: 'Loading invoice details...',
        maskType: EasyLoadingMaskType.black,
      );
      debugPrint('EasyLoading shown');

      String? token = await AuthService.getToken();
      debugPrint('Token retrieved: ${token != null ? 'Valid token' : 'Null or empty token'}');

      if (token == null || token.isEmpty) {
        debugPrint('No token found. User is not authenticated.');
        await EasyLoading.showError('Authentication error: No token available');
        throw Exception('Token is not available');
      }

      final String apiUrl = 'https://freepik.softvenceomega.com/ts/invoice/get/$invoiceId';
      debugPrint('Making GET request to $apiUrl');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('API response received with status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('Parsing JSON response');
        final jsonData = jsonDecode(response.body);
        debugPrint('JSON decoded: $jsonData');
        final invoiceDetail = Invoic.fromJson(jsonData);
        debugPrint('Invoice details parsed: success=${invoiceDetail.success}, message=${invoiceDetail.message}');

        if (invoiceDetail.success == true && invoiceDetail.data != null) {
          invoiceDetails.value = invoiceDetail;
          debugPrint('Invoice details updated: ${invoiceDetail.data.invoiceNumber}');
          // Update assignedTo and ensure it's in assignees
          final workerName = invoiceDetail.data.workerInfo.name;
          debugPrint('Worker name from API: $workerName');
          if (workerName.isNotEmpty && !assignees.contains(workerName)) {
            assignees.add(workerName);
            debugPrint('Added $workerName to assignees');
          }
          assignedTo.value = assignees.contains(workerName) ? workerName : assignees.first;
          debugPrint('Set assignedTo to: ${assignedTo.value}');
          amount.value = '\$${invoiceDetail.data.serviceDetail.fold(0, (sum, item) => sum + item.taskPrice)}';
          status.value = _mapInvoiceStatusToString(invoiceDetail.data.serviceRequestDetails.paymentType);
          await EasyLoading.showSuccess('Invoice details loaded successfully');
        } else {
          debugPrint('API returned unsuccessful response: ${invoiceDetail.message}');
          await EasyLoading.showError(invoiceDetail.message);
          invoiceDetails.value = null;
        }
      } else {
        debugPrint('API request failed with status: ${response.statusCode}');
        await EasyLoading.showError('Failed to fetch invoice details: ${response.statusCode}');
        invoiceDetails.value = null;
      }
    } catch (e) {
      debugPrint('Error in fetchInvoiceDetails: $e');
      await EasyLoading.showError('An error occurred: $e');
      invoiceDetails.value = null;
    } finally {
      isLoading.value = false;
      await EasyLoading.dismiss();
      debugPrint('EasyLoading dismissed');
    }
  }

  PaymentStatus _mapInvoiceStatus(String? status) {
    debugPrint('Mapping invoice status: $status');
    switch (status?.toLowerCase()) {
      case 'pending':
        debugPrint('Mapped to PaymentStatus.pending');
        return PaymentStatus.pending;
      case 'confirmed':
        debugPrint('Mapped to PaymentStatus.confirmed');
        return PaymentStatus.confirmed;
      case 'overdue':
        debugPrint('Mapped to PaymentStatus.overdue');
        return PaymentStatus.overdue;
      default:
        debugPrint('Mapped to default PaymentStatus.pending');
        return PaymentStatus.pending;
    }
  }

  String _mapInvoiceStatusToString(String? paymentType) {
    switch (paymentType?.toLowerCase()) {
      case 'pending':
        return 'Betaling in afwachting';
      case 'confirmed':
        return 'Bevestigd';
      case 'overdue':
        return 'Achterstallig';
      default:
        return 'Betaling in afwachting';
    }
  }

  void setSelectedMonth(String? month) {
    debugPrint('Setting selectedMonth: $month');
    selectedMonth.value = month;
  }

  void setSelectedTaakType(String? type) {
    debugPrint('Setting selectedTaaktype: $type');
    selectedTaaktype.value = type;
  }

  void setSelectedTaakStatus(String? status) {
    debugPrint('Setting selectedTaakStatus: $status');
    selectedTaakStatus.value = status;
  }

  void setSelectedYear(String? year) {
    debugPrint('Setting selectedYear: $year');
    selectedYear.value = year;
  }

  void clearAllFilters() {
    debugPrint('Clearing all filters');
    selectedMonth.value = null;
    selectedTaaktype.value = null;
    selectedTaakStatus.value = null;
    selectedYear.value = null;
    debugPrint('All filters cleared');
  }

  bool get allFiltersSelected {
    final result = selectedMonth.value != null &&
        selectedYear.value != null &&
        selectedTaaktype.value != null &&
        selectedTaakStatus.value != null;
    debugPrint('allFiltersSelected checked: $result');
    return result;
  }

  String selectedProfile = 'Theresa Webb';

  void updateSelectedProfile(String? newValue) {
    debugPrint('Updating selectedProfile: $newValue');
    if (newValue != null) {
      selectedProfile = newValue;
      debugPrint('selectedProfile updated to: $selectedProfile');
    } else {
      debugPrint('No update: newValue is null');
    }
  }
}