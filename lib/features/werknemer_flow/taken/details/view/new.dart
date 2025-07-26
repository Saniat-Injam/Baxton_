//  // ---Client Review---
//             // Signature Section
//             Text(
//               "Handtekening van de klant",
//               style: getTextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.primaryBlack,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Image.asset(ImagePath.customerSignature),

//             const SizedBox(height: 30),
//             Text(
//               "Opmerking",
//               style: getTextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.primaryBlack,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Taak succesvol voltooid. Het dak is grondig geïnspecteerd en er zijn geen zichtbare schade of schimmel- of watervlekken gevonden. Ik heb voor- en nafoto's genomen voor de documentatie. De klant was tevreden met het werk en gaf bevestiging. Er zijn geen aanvullende problemen gerapporteerd. Ik raad aan om over 6 maanden een vervolginspectie in te plannen om te zorgen dat alles in goede staat blijft.",
//               style: getTextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.secondaryBlack,
//                 lineHeight: 12,
//                 letterSpacing: -0.1,
//               ),
//             ),
//             const SizedBox(height: 30),
//             Text(
//               "Klantbeoordeling",
//               style: getTextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.primaryBlack,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Image.asset(IconPath.starIcon),
//                 SizedBox(width: 4),
//                 Image.asset(IconPath.starIcon),
//                 SizedBox(width: 4),
//                 Image.asset(IconPath.starIcon),
//                 SizedBox(width: 4),
//                 Image.asset(IconPath.starIcon),
//                 SizedBox(width: 4),
//                 Image.asset(IconPath.starIcon),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Lorem ipsum dolor sit amet consectetur. Urna odio sit neque urna. Nisi nisi volutpat pellentesque in tincidunt diam.",
//               style: getTextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.secondaryBlack,
//                 lineHeight: 10,
//               ),
//             ),
//             SizedBox(height: 40),

//             SizedBox(
//               height: 44,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle second button press
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 24,
//                   ),
//                   backgroundColor: AppColors.primaryBlue,

//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(62),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize:
//                       MainAxisSize.min, // Ensures the button wraps its content
//                   children: [
//                     Image.asset(IconPath.downloadIcon),
//                     const SizedBox(width: 12), 
//                     Text(
//                       'Download Rapport',
//                       style: getTextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.primaryWhite,
//                       ), 
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),
//             SizedBox(
//               height: 44,
//               child: OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   side: BorderSide(color: AppColors.primaryBlue),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(62),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Row(
//                   mainAxisSize:
//                       MainAxisSize.min, 
//                   children: [
//                     Image.asset(IconPath.shareIcon),
//                     const SizedBox(width: 12), 
//                     Text(
//                       'Delen',
//                       style: getTextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.primaryBlue,
//                       ), // Ensure text is visible
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: 40),