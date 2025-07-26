import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  static BarChartGroupData _buildBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroups = [
      _buildBarGroup(0, 77, const Color(0xFF62B2FD)),
      _buildBarGroup(1, 100, const Color(0xFF9BDFC4)),
      _buildBarGroup(2, 72, const Color(0xFFF99BAB)),
      _buildBarGroup(3, 56, const Color(0xFFFFB44F)),
      _buildBarGroup(4, 39, const Color(0xFF9F97F7)),
      _buildBarGroup(5, 91, const Color(0xFFB8C4CE)),
      _buildBarGroup(6, 76, const Color(0xFF0D7FE9)),
    ];

    Widget buildLegendItem(Color color, String text) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF8C97A7),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ],
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 328, maxWidth: 770),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 102,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 29,
                      height: 102,
                      margin: EdgeInsets.only(right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '200',
                            style: TextStyle(
                              color: Color(0xFFB8C4CE),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            '100',
                            style: TextStyle(
                              color: Color(0xFFB8C4CE),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            '75',
                            style: TextStyle(
                              color: Color(0xFFB8C4CE),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            '50',
                            style: TextStyle(
                              color: Color(0xFFB8C4CE),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            '25',
                            style: TextStyle(
                              color: Color(0xFFB8C4CE),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Color(0xFFB8C4CE),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            barGroups: barGroups,
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(show: false),
                            barTouchData: BarTouchData(enabled: false),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  buildLegendItem(Color(0xFF62B2FD), 'Dakinspectie'),
                  buildLegendItem(Color(0xFF9BDFC4), 'Schimmelverwijdering'),
                  buildLegendItem(Color(0xFFF99BAB), 'Plumbing Repairs'),
                  buildLegendItem(
                    Color(0xFFFFB44F),
                    'Herstel van Elektrisch Systeem',
                  ),
                  buildLegendItem(Color(0xFF9F97F7), 'HVAC Onderhoud'),
                  buildLegendItem(Color(0xFFB8C4CE), 'Vastgoedonderhoud'),
                  buildLegendItem(
                    Color(0xFF0D7FE9),
                    'Ongediertebestrijding Behandeling',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
