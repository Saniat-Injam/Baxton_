import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/profile_setup/model/worker_specialist_model.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({super.key});

  final FilterController _filterController = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterController.clearAllFilters();
    });

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            _buildLocatieDropdown(),
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

  Widget _buildLocatieDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Locatie",
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => DropdownButtonFormField<String?>(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: _filterController.selectedMonth.value,
            items:
                [
                      'January',
                      'februari',
                      'maart',
                      'april',
                      'mei',
                      'juni',
                      'juli',
                      'augustus',
                      'september',
                      'oktober',
                      'november',
                      'december',
                    ]
                    .map(
                      (month) => DropdownMenuItem<String?>(
                        value: month,
                        child: Text(
                          month,
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
              _filterController.setSelectedMonth(value);
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
          ),
        ),
      ],
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
        Obx(
          () => DropdownButtonFormField<String?>(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: _filterController.selectedMonth.value,
            items:
                [
                      'January',
                      'februari',
                      'maart',
                      'april',
                      'mei',
                      'juni',
                      'juli',
                      'augustus',
                      'september',
                      'oktober',
                      'november',
                      'december',
                    ]
                    .map(
                      (month) => DropdownMenuItem<String?>(
                        value: month,
                        child: Text(
                          month,
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
              _filterController.setSelectedMonth(value);
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
          ),
        ),
      ],
    );
  }

  Widget _buildYearDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Year", style: getTextStyle()),
        const SizedBox(height: 10),
        Obx(
          () => DropdownButtonFormField<String?>(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: _filterController.selectedYear.value,
            items: List.generate(DateTime.now().year - 1950 + 1, (index) {
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
            }),
            onChanged: (value) {
              _filterController.setSelectedYear(value);
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
          ),
        ),
      ],
    );
  }

  Widget _buildTaaktypeDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Taaktype", style: getTextStyle()),
        const SizedBox(height: 10),
        Obx(() {
          return DropdownButtonFormField<WorkerSpecialist>(
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              // contentPadding: const EdgeInsets.symmetric(
              //   horizontal: 16,
              //   vertical: 10,
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFC0C0C0)),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFC0C0C0),
                  width: 2,
                ),
              ),
            ),
            hint: Text(
              "Select expertise",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGold,
              ),
            ),
            value: _filterController.selectedSpecialist.value,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF666666),
            ),
            dropdownColor: Colors.white,
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            menuMaxHeight: 300,
            items:
                _filterController.specialistList.asMap().entries.map((entry) {
                  int index = entry.key;
                  WorkerSpecialist specialist = entry.value;

                  return DropdownMenuItem(
                    value: specialist,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 4,
                          ),
                          child: Text(
                            specialist.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGold,
                            ),
                          ),
                        ),

                        if (index < _filterController.specialistList.length - 1)
                          const Divider(
                            height: 1,
                            thickness: 0.5,
                            color: AppColors.buttonPrimary,
                            indent: 4,
                            endIndent: 4,
                          ),
                      ],
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) _filterController.selectSpecialist(value);
            },
            selectedItemBuilder: (BuildContext context) {
              return _filterController.specialistList.map<Widget>((specialist) {
                return Text(
                  specialist.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                );
              }).toList();
            },
          );
        }),
      ],
    );
  }

  Widget _buildTaakstatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Taakstatus", style: getTextStyle()),
        const SizedBox(height: 10),
        Obx(
          () => DropdownButtonFormField<String?>(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: _filterController.selectedTaakStatus.value,
            items:
                ['In Behandeling', 'Niet Toegewezen', 'Voltooid']
                    .map(
                      (status) => DropdownMenuItem<String?>(
                        value: status,
                        child: Text(
                          status,
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
              _filterController.setSelectedTaakStatus(value);
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
          ),
        ),
      ],
    );
  }

  void _checkAndClose() {
    if (_filterController.allFiltersSelected) {
      Get.back();
    }
  }
}
