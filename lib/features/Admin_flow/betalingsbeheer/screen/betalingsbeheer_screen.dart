import 'package:baxton/features/Admin_flow/betalingsbeheer/screen/betalingsbeheer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_search_field.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/widgets/filter_dialog.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/widgets/invoice_card.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/widgets/star_card_1.dart';

class BetalingsbeheerScreen extends StatelessWidget {
  BetalingsbeheerScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final BetalingsbeheerController controller = Get.put(
    BetalingsbeheerController(),
  );

  @override
  Widget build(BuildContext context) {
    controller.fetchInvoiceOverview();
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Navbar(),
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        centerTitle: true,
        title: Text(
          "Betalingsbeheer",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Betalingsoverzicht",
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() {
                final dollar = controller.dollar.value;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    // StatCard1 for "Totaalbedrag ontvangen"
                    FractionallySizedBox(
                      widthFactor:
                          0.48, // Set the width to 48% of the parent width
                      child: StatCard1(
                        iconPath: IconPath.cashalert,
                        title: "Totaalbedrag ontvangen",
                        count: dollar.assigned,
                        countTextStyle: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff62B2FD),
                        ),
                      ),
                    ),

                    // StatCard1 for "In afwachting van betalingen"
                    FractionallySizedBox(
                      widthFactor:
                          0.48, // Set the width to 48% of the parent width
                      child: StatCard1(
                        iconPath: IconPath.moneyaccount,
                        title: "In afwachting van betalingen",
                        count: dollar.inProgress,
                        countTextStyle: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff33DB2A),
                        ),
                      ),
                    ),

                    // StatCard1 for "Achterstallige betalingen"
                    FractionallySizedBox(
                      widthFactor:
                          0.48, // Set the width to 48% of the parent width
                      child: StatCard1(
                        iconPath: IconPath.clockred,
                        title: "Achterstallige betalingen",
                        count: dollar.overdue,
                        countTextStyle: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffDB2A2D),
                        ),
                      ),
                    ),

                    // StatCard1 for "Bevestigde betalingen"
                    FractionallySizedBox(
                      widthFactor:
                          0.48, // Set the width to 48% of the parent width
                      child: StatCard1(
                        iconPath: IconPath.timeralert,
                        title: "Bevestigde betalingen",
                        count: dollar.completed,
                        countTextStyle: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff1E90FF),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: CustomSearchTextField(
                      hintText: "Zoek facturen...",
                      controller: controller.searchController,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 18,
                        color: AppColors.primaryGold,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xffF3E2B0),
                      ),
                    ),
                    child: IconButton(
                      onPressed:
                          () => showDialog(
                            context: context,
                            builder: (context) => FilterDialog(),
                          ),
                      icon: Image.asset(IconPath.filter, height: 24, width: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.invoices.isEmpty) {
                  return const Center(child: Text('Geen facturen beschikbaar'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.invoices.length,
                  itemBuilder: (context, index) {
                    final invoice = controller.invoices[index];
                    return InvoiceCard(
                      invoice: invoice,
                      onDetailsPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BetalingsbeheerDetailsScreen(
                                  invoiceId: invoice.id!,
                                ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
