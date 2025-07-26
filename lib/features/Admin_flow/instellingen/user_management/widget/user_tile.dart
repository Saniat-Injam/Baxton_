import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/instellingen/user_management/model/user_model.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius:
                screenWidth * 0.06, // Responsive radius (6% of screen width)
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          const SizedBox(width: 10),

          // Name and Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    fontSize: screenWidth * 0.035, // Responsive font size
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    fontSize: screenWidth * 0.032, // Responsive font size
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGold,
                  ),
                ),
              ],
            ),
          ),

          // Role dropdown and more button
          SizedBox(
            width:
                screenWidth *
                0.35, // Allocate 35% of screen width for dropdown and button
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Dropdown
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryWhite,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: true,
                        value: user.role,
                        icon: Image.asset(IconPath.dropDown2, width: 16),
                        style: getTextStyle(
                          lineHeight: 12,
                          fontSize: screenWidth * 0.032,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                        items:
                            ['Beheerder', 'Werknemer', 'Klant']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(
                                      role,
                                      overflow:
                                          TextOverflow
                                              .ellipsis, // Prevent text overflow
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          // Handle role update
                        },
                        // Constrain dropdown menu width
                        dropdownColor: AppColors.primaryWhite,
                        menuMaxHeight: 200, // Limit dropdown height
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                // More Button
                IconButton(
                  icon: Image.asset(IconPath.more, width: 30), // Smaller icon
                  onPressed: () {
                    // Handle more options
                  },
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
