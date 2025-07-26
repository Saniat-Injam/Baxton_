import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final Color backgroundColor;
  final Color borderColor;

  const InfoCard({
    required this.title,
    required this.description,
    required this.iconPath,
    this.backgroundColor = const Color(0xff33DB2A),
    this.borderColor = const Color(0xffEBEBEB),
  });

  // Getter to return the background color with opacity for reuse
  Color get lightBackgroundColor => backgroundColor.withValues(alpha: 0.1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,  // important for responsive height
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: lightBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(iconPath),
              ),
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                height: 1,
              ),
            ),
            SizedBox(height: 18),
            Text(
              description,
              style: getTextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xff666666),
                lineHeight: 12,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
