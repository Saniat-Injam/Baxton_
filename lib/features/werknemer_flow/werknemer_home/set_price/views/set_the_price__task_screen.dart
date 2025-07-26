import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/set_price_screen_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/set_the_price__task_detail_screen.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/widget/set_the_price__task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetThePriceTaskScreen extends StatelessWidget {
  final SetPriceController setPriceController = Get.put(SetPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(IconPath.arrowBack),
            ],
          ),
        ),
        title: Text(
          'Stel de Prijzen In',

          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: setPriceController.allSetPricetasks.length,
          itemBuilder: (_, index) {
            final newAllSetPricesTasks =
                setPriceController.allSetPricetasks[index];
            return SetThePriceTaskCard(
              setPriceTask: newAllSetPricesTasks,
              onSetPrice:
                  () => Get.to(
                    () => SetThePriceTaskDetailScreen(
                      setPriceTasks: newAllSetPricesTasks,
                    ),
                  ),
            );
          },
        );
      }),
    );
  }
}
