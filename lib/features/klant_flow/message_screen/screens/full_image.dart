import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/profile_screen/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullImageView extends StatelessWidget {
  final String imagePath;

  FullImageView({super.key, required this.imagePath});
  final darkcontroller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.textPrimary.withValues(alpha: 0.10),
              child: Image.asset(
                IconPath.arrowleft,
                width: 16,
                height: 12,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child:
          // Image.file(File(imagePath), fit: BoxFit.contain),
          Image.network(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 50);
            },
          ),
        ),
      ),
    );
  }
}
