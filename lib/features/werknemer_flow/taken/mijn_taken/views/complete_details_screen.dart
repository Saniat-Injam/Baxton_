
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/signature_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/details/controller/task_execution_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/widget/new_checkList_widget.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/confirm_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/download_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/photo_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/photo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteDetailsScreen extends StatelessWidget {
  final String taskId;
  final UpcomingTaskController controller = Get.find<UpcomingTaskController>();

  final TaskExecutionController taskExecutionController = Get.put(
    TaskExecutionController(),
  );
  final SharedSignatureController signatureController =
      Get.find<SharedSignatureController>();
  final ConfirmedTaskController confirmedTaskController =
      Get.find<ConfirmedTaskController>();
  CompleteDetailsScreen({super.key, required this.taskId});
  final DownloadController downloadController = Get.put(DownloadController());
  @override
  Widget build(BuildContext context) {
    final photoController = Get.put(
      PhotoController(repository: PhotoRepository(), taskId: taskId),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTaskDetails(taskId);
    });

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(IconPath.arrowBack),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Voltooide Taakdetails",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryBlack),
      ),
      body: Obx(() {
        final data = controller.taskDetailsModel.value;
        if (data == null) {
          return const Center(child: Text('Geen gegevens beschikbaar'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTaskInfoView(data),
              SizedBox(height: 8.h),
              _buildKlanteninformatieView(data),
              SizedBox(height: 10.h),
              _buildPaymentType(data),
              SizedBox(height: 10.h),
              _buildChecklistSection(context, controller),
              SizedBox(height: 40.h),
              _buildBeforePhotosSection(controller, photoController),
              SizedBox(height: 40.h),
              _buildAfterPhotosSection(controller, photoController),
              SizedBox(height: 40.h),
              _buildSignatureSection(data),
              SizedBox(height: 30.h),
              _buildNotesSection(data),
              SizedBox(height: 40.h),
              _buildKlantBeoordelingSection(data),
              SizedBox(height: 40.h),
              _buildActionButtons(data),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTaskInfoView(dynamic data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffEBEBEB)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(15.sp),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.name ?? 'No Task Name',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(data.problemDescription ?? 'No Description'),
          SizedBox(height: 16.h),
          _buildTimeAndLocationRow(data),
        ],
      ),
    );
  }

  Widget _buildTimeAndLocationRow(dynamic data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 20.sp,
              color: AppColors.buttonPrimary,
            ),
            SizedBox(width: 4.w),
            Text(
              data.preferredTime != null
                  ? data.preferredTime!.split('T')[1].substring(0, 5)
                  : 'No data',
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: AppColors.buttonPrimary,
            ),
            const SizedBox(width: 4),
            Text(data.city ?? 'No data'),
          ],
        ),
      ],
    );
  }

  Widget _buildKlanteninformatieView(dynamic data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffEBEBEB)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(15.sp),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Klanteninformatie',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildInfoRow('Naam', data.clientProfile?.userName ?? 'No data'),
          SizedBox(height: 5.h),
          _buildInfoRow('Telefoonnummer', data.phoneNumber ?? 'No data'),
          SizedBox(height: 5.h),
          _buildInfoRow(
            'Gewenste datum',
            data.preferredDate?.split('T')[0] ?? 'No data',
          ),
          SizedBox(height: 5.h),
          _buildInfoRow(
            'Gewenste tijd',
            data.preferredTime != null
                ? data.preferredTime!.split('T')[1].substring(0, 5)
                : 'No data',
          ),
          SizedBox(height: 5.h),
          _buildInfoRow('Taaktype', data.taskTypeName ?? 'No data'),
        ],
      ),
    );
  }

  Widget _buildPaymentType(dynamic data) {
    return Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffFBF6E6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '\$${data.basePrice?.toStringAsFixed(2) ?? '0.00'}',
        style: GoogleFonts.roboto(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryGold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14.sp, color: Color(0xff666666)),
        ),
        SizedBox(width: 4.w),
        Text(value),
      ],
    );
  }

  Widget _buildChecklistSection(
    BuildContext context,
    UpcomingTaskController upcomingTaskController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TaakChecklist",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        const SizedBox(height: 20),

        Obx(() {
          // final details = upcomingTaskController.taskDetailsModel.value;
          // final items = details?.tasks ?? [];

          final details = upcomingTaskController.taskDetailsModel.value;
          final allItems = details?.tasks ?? [];
          final items = allItems.where((item) => item.done == true).toList();
          if (items.isEmpty) {
            return const Text('Geen checklist items.');
          }

          return Column(
            children:
                items.map((item) {
                  return NewChecklistWidget(item: item, onChanged: (val) {});
                }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildBeforePhotosSection(
    UpcomingTaskController upcomingTaskController,
    PhotoController photoController,
  ) {
    return Obx(() {
      final beforePhotos =
          upcomingTaskController.taskDetailsModel.value?.beforePhoto ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhotoUploadSectionView(
            onTap: () {},
            buttonText: "Voor Foto",
            photos: beforePhotos,
          ),
        ],
      );
    });
  }

  Widget _buildAfterPhotosSection(
    UpcomingTaskController upcomingTaskController,
    PhotoController photoController,
  ) {
    return Obx(() {
      final afterPhotos =
          upcomingTaskController.taskDetailsModel.value?.afterPhoto ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhotoUploadSectionView(
            onTap: () {},
            buttonText: "Na Foto",
            photos: afterPhotos,
          ),
        ],
      );
    });
  }

  Widget _buildPhotoUploadSectionView({
    required VoidCallback onTap,
    required String buttonText,
    required List<dynamic> photos,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.secondaryBlue,
              border: Border.all(color: AppColors.primaryBlue),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(IconPath.camera),
                const SizedBox(height: 8),
                Text(
                  buttonText,
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // 📷 Show images from API (not local)
        if (photos.isEmpty)
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.primaryGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Image.asset(IconPath.photoUpload),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: photos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, index) {
              final item = photos[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryGrey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(item.url ?? '', fit: BoxFit.cover),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(6),
                    //   child: Text(
                    //     item.caption ?? '',
                    //     style: getTextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w400,
                    //       color: AppColors.primaryBlack,
                    //     ),
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildSignatureSection(data) {
    final signatureUrl = data.signature?.url;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Handtekening van de klant",
            style: getTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlack,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryGrey.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child:
              signatureUrl != null && signatureUrl.isNotEmpty
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      signatureUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconPath.photoUpload,
                        height: 50,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 10.h),
                      Text('No Signature found'),
                    ],
                  ),
        ),
      ],
    );
  }

  Widget _buildNotesSection(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Opmerking",
            style: getTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlack,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Text(data.note ?? 'Geen opmerking beschikbaar'),
      ],
    );
  }

  Widget _buildKlantBeoordelingSection(data) {
    final rating = data.rating;
    final review = data.review;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Klantbeoordeling",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        SizedBox(height: 15.h),
        Row(children: _buildStarIcons(rating)),
        SizedBox(height: 12.h),
        Text(
          (review != null && review.trim().isNotEmpty)
              ? review
              : 'Geen beoordeling beschikbaar',
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryBlack,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildStarIcons(double? rating) {
    final stars = <Widget>[];
    final int fullStars = rating?.floor() ?? 0;

    for (int i = 0; i < 5; i++) {
      stars.add(
        Icon(
          i < fullStars ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 24.sp,
        ),
      );
    }
    return stars;
  }

  Widget _buildActionButtons(dynamic data) {
    return Column(
      children: [
        SizedBox(
          height: 44.h,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await downloadController.downloadReport(data);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              backgroundColor: AppColors.primaryBlue,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(62),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/download.png'),
                SizedBox(width: 12.w),
                Text(
                  'Download Rapport',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 44.h,
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              side: BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(62),
              ),
            ),
            onPressed: () async {
              await downloadController.shareReport(data);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(IconPath.shareIcon),
                const SizedBox(width: 12),
                Text(
                  'Delen',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ), // Ensure text is visible
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
