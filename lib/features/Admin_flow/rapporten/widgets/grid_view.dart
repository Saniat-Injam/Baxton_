import 'package:baxton/features/Admin_flow/rapporten/controller/rapporten_controller.dart';
import 'package:baxton/features/Admin_flow/rapporten/widgets/groth_widget.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class gridview extends StatelessWidget {
  const gridview({super.key, required this.rapportenController});

  final RapportenController rapportenController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GrothWidget(
                title: 'Taak Voltooid',
                value: rapportenController.tasksCompleted,
                growth: rapportenController.revenueGrowth,
                isRevenue: false,
                showGrowth: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: GrothWidget(
                title: 'Taak In Afwachting',
                value: rapportenController.tasksPending,
                growth: rapportenController.revenueGrowth,
                isRevenue: false,
                showGrowth: false,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GrothWidget(
                title: 'Totaal Aantal Werknemers',
                value: rapportenController.totalEmployees,
                isRevenue: false,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: GrothWidget(
                title: 'Omzet',
                value: rapportenController.revenue,
                growth: rapportenController.revenueGrowth,
                isRevenue: true,
                showGrowth: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
