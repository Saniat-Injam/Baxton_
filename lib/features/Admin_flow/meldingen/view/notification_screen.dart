import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/meldingen/controller/notification_controller.dart';
import 'package:baxton/features/Admin_flow/meldingen/widget/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final NotificationController notificationController = Get.put(
    NotificationController(),
  );

  NotificationScreen({super.key});

  final List<String> filters = ['Alle', 'Medewerker', 'Klant'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text(
          "Meldiingen",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),

      body: Column(
        children: [
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children:
                    filters.map((filter) {
                      final bool isSelected =
                          notificationController.selectedFilter.value == filter;
                      final int count = notificationController
                          .getNotificationCountForFilter(filter);

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                filter,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      isSelected
                                          ? AppColors.primaryWhite
                                          : AppColors.primaryBlack,
                                ),
                              ),
                              const SizedBox(width: 6),

                              // Circular count box
                              Container(
                                width: 24,
                                height: 20,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? AppColors.grey3
                                          : AppColors.grey3,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '$count',
                                    style: getTextStyle3(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isSelected
                                              ? AppColors.black4
                                              : AppColors.black4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          selected: isSelected,
                          onSelected:
                              (_) => notificationController.setFilter(filter),
                          selectedColor: AppColors.primaryGold,
                          backgroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // NOTIFICATIONS LIST
          Expanded(
            child: Obx(() {
              final list = notificationController.filteredNotifications;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => NotificationCard(notification: list[i]),
              );
            }),
          ),
        ],
      ),
    );
  }
}
