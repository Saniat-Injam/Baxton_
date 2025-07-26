// import 'package:flutter/material.dart';

// class ReviewCard extends StatelessWidget {
//   final String name;
//   final String profileImage;
//   final double rating;
//   final String reviewText;

//   const ReviewCard({
//     super.key,
//     required this.name,
//     required this.profileImage,
//     required this.rating,
//     required this.reviewText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Create a list of stars based on rating
//     int fullStars = rating.floor();
//     bool hasHalfStar = (rating - fullStars) >= 0.5;
//     List<Widget> stars = List.generate(5, (index) {
//       if (index < fullStars) {
//         return Image.asset('assets/icons/star.png', height: 12, width: 12);
//       } else if (index == fullStars && hasHalfStar) {
//         return Image.asset('assets/icons/halfstar.png', height: 12, width: 12);
//       } else {
//         return Image.asset(
//           'assets/icons/star_empty.png',
//           height: 12,
//           width: 12,
//         );
//       }
//     });

//     return Container(
//       height: 166,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(width: 1, color: Color(0xffEBEBEB)),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Column(
//               children: [Image.asset(profileImage, height: 32, width: 32)],
//             ),
//             SizedBox(width: 5),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Row(children: stars),
//                 SizedBox(height: 10),
//                 Text(
//                   reviewText,
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w400,
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String profileImage;
  final double rating;
  final String reviewText;

  const ReviewCard({
    super.key,
    required this.name,
    required this.profileImage,
    required this.rating,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    // Create a list of stars based on rating
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    List<Widget> stars = List.generate(5, (index) {
      if (index < fullStars) {
        return Image.asset('assets/icons/star.png', height: 12, width: 12);
      } else if (index == fullStars && hasHalfStar) {
        return Image.asset('assets/icons/halfstar.png', height: 12, width: 12);
      } else {
        return Image.asset(
          IconPath.halfstar,
          height: 12,
          width: 12,
        );
      }
    });

    return Container(
      height: 166,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              children: [
                profileImage.startsWith('http')
                    ? Image.network(
                        profileImage,
                        height: 32,
                        width: 32,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/icons/profilepic.png',
                                height: 32, width: 32),
                      )
                    : Image.asset(profileImage, height: 32, width: 32),
              ],
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Row(children: stars),
                SizedBox(height: 10),
                Text(
                  reviewText,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}