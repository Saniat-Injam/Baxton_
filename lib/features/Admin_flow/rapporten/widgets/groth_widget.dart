import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrothWidget extends StatelessWidget {
  final String title;
  final RxInt value;
  final RxDouble? growth;
  final bool isRevenue;
  final bool showGrowth;

  const GrothWidget({
    required this.title,
    required this.value,
    this.growth,
    required this.isRevenue,
    this.showGrowth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(12),
        height: 122,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(width: 1, color: Color(0xffEBEBEB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xffA1A1A1),
                lineHeight: 12,
              ),
            ),
            SizedBox(height: 10),
            isRevenue
                ? Text(
                  '\$${value.value}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff62B2FD),
                  ),
                )
                : Text(
                  '${value.value}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff62B2FD),
                  ),
                ),
            if (showGrowth && growth != null) ...[
              SizedBox(height: 10),
              Row(
                children: [
                  // Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                  // SizedBox(width: 4),
                  // Text(
                  //   '${growth!.value.toStringAsFixed(2)}%',
                  //   style: TextStyle(color: Colors.green),
                  // ),
                  Container(
                    height: 20,
                    // width: 63,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      color: Color(0xff33DB2A).withValues(alpha: 0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${growth!.value.toStringAsFixed(1)}%',
                          style: getTextStyle(
                            color: Color(0xff2ABA22),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.trending_up_sharp,
                          color: Color(0xff2ABA22),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
