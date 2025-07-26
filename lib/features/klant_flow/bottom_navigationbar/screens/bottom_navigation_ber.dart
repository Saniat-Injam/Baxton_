import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/bottom_navigationbar/controller/navigation_ber_controller.dart';
import 'package:baxton/features/klant_flow/home_screen/screens/home_screen.dart';
import 'package:baxton/features/klant_flow/message_screen/screens/chat_page.dart';
import 'package:baxton/features/klant_flow/profile_screen/screens/profile_edit_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BottomNavbar extends StatelessWidget {
  BottomNavbar({super.key});
  final BottomNavbarController controller = Get.put(BottomNavbarController());
  // final List<Widget> pages = [
  //   HomeScreen(),
  //   TaskScreen(),
  //   MessageScreen(),
  //   ProfileScreen(),
  // ];
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return TaskScreen();
      case 2:
        return MessageScreen();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(() => _getPage(controller.currentIndex.value)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, -0),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                passiveImage: IconPath.deactivatehome,
                activeImage: IconPath.activehome,
                index: 0,
              ),
              _buildNavItem(
                passiveImage: IconPath.deactivatetask,
                activeImage: IconPath.activetask,
                index: 1,
              ),
              _buildNavItem(
                passiveImage: IconPath.deactivatechat,
                activeImage: IconPath.activechat,
                index: 2,
              ),
              _buildNavItem(
                passiveImage: IconPath.deactivateperson,
                activeImage: IconPath.activeperson,
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? activeImage : passiveImage,
              height: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 6), // spacing between image and dot
            if (isSelected)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color:
                      AppColors
                          .primaryGold, // or any color you want for the circle
                  shape: BoxShape.circle,
                ),
              )
            else
              SizedBox(height: 6), // empty space to keep alignment consistent
          ],
        );
      }),
    );
  }
}
