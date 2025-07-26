
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/home_screen/widgets/service_widget.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/job_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/model/all_task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestedServicesScreen extends StatelessWidget {
  const RequestedServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobController jobsController = Get.put( JobController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Requested Services'),
      ),
      body: FutureBuilder<List<ServiceRequest>>(
        future: jobsController.fetchServiceRequestsForStatus('PENDING'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textThird,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => jobsController.fetchServiceRequestsForStatus('PENDING'),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Geen aangevraagde diensten",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textThird,
                ),
              ),
            );
          }

          final requestedServices = snapshot.data!;
          debugPrint('Requested Services Count: ${requestedServices.length}');
          for (var i = 0; i < requestedServices.length; i++) {
            debugPrint('Service $i: ${requestedServices[i].toJson()}');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: requestedServices.length,
            itemBuilder: (context, index) {
              final service = requestedServices[index];
              return ServiceContainer(service: service);
            },
          );
        },
      ),
    );
  }
}
