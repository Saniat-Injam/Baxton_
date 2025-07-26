import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({super.key});
  
  final BetalingsbeheerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.clearAllFilters();
    });

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
            Align(
              alignment: Alignment.center,
              child: Text(
                "Filter",
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildMonthDropdown(),
            const SizedBox(height: 10),
            _buildYearDropdown(),
            const SizedBox(height: 10),
            _buildTaaktypeDropdown(context),
            const SizedBox(height: 10),
            _buildTaakstatusDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Maand",
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => DropdownButtonFormField<String?>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: controller.selectedMonth.value,
          items: [
            'January', 'februari', 'maart', 'april', 'mei', 'juni',
            'juli', 'augustus', 'september', 'oktober', 'november', 'december'
          ].map((month) => DropdownMenuItem<String?>(
            value: month,
            child: Text(
              month,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGold,
              ),
            ),
          )).toList(),
          onChanged: (value) {
            controller.setSelectedMonth(value);
            _checkAndClose();
          },
          hint: Text(
            'Maand',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryGold,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildYearDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Year", style: getTextStyle()),
        const SizedBox(height: 10),
        Obx(() => DropdownButtonFormField<String?>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: controller.selectedYear.value,
          items: List.generate(
            DateTime.now().year - 1950 + 1,
            (index) {
              final year = (1950 + index).toString();
              return DropdownMenuItem<String?>(
                value: year,
                child: Text(
                  year,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGold,
                  ),
                ),
              );
            },
          ),
          onChanged: (value) {
            controller.setSelectedYear(value);
            _checkAndClose();
          },
          hint: Text(
            'Select Year',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryGold,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildTaaktypeDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Taaktype", style: getTextStyle()),
        const SizedBox(height: 10),
        Obx(() => DropdownButtonFormField<String?>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          isDense: true,
          value: controller.selectedTaaktype.value,
          items: [
            'Schimmelinspecties en -behandelingen',
            'Voor- en na-inspecties van huurwoningen en nazorg',
            'Vochtbeheersing',
            'Stucwerk',
            'Schilderen en coaten',
            'Nicotinevlekken verwijderen',
            'Hulpteam en nooddienst (24/7)',
          ].map((type) => DropdownMenuItem<String?>(
            value: type,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              child: Text(
                type,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGold,
                ),
              ),
            ),
          )).toList(),
          onChanged: (value) {
            controller.setSelectedTaakType(value);
            _checkAndClose();
          },
          hint: Text(
            'Schimmelinspecties en -behandelingen',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryGold,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildTaakstatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Taakstatus", style: getTextStyle()),
        const SizedBox(height: 10),
        Obx(() => DropdownButtonFormField<String?>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: controller.selectedTaakStatus.value,
          items: [
            'In Behandeling',
            'Niet Toegewezen',
            'Voltooid',
          ].map((status) => DropdownMenuItem<String?>(
            value: status,
            child: Text(
              status,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGold,
              ),
            ),
          )).toList(),
          onChanged: (value) {
            controller.setSelectedTaakStatus(value);
            _checkAndClose();
          },
          hint: Text(
            'In Behandeling',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryGold,
            ),
          ),
        )),
      ],
    );
  }

  void _checkAndClose() {
    if (controller.allFiltersSelected) {
      Get.back();
    }
  }
}