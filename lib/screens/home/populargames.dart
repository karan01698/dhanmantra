// popular_games_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../constants/colors.dart';
import '../../widgets/reusable_button.dart';
import 'all_games_controller.dart';

//
// class PopularGamesWidget extends StatelessWidget {
//   final String title;
//   final PopularGamesController controller = Get.put(PopularGamesController());
//
//   PopularGamesWidget({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         padding: EdgeInsets.all(10),
//         height: controller.showAll.value ? 450 : 250,
//         decoration: BoxDecoration(
//           color: AppColors.popularContainer,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.baloo2(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//                 ReusableButton(
//                   text: controller.showAll.value ? "Show Less" : "See All",
//                   onPressed: controller.toggleShowAll,
//                   width: 90,
//                   height: 26,
//                   borderRadius: 20,
//                   fontSize: 13,
//                   backgroundColor: Colors.white,
//                   textColor: Color(0xff5d1f31),
//                 ),
//                 ReusableButton(
//                   icon: Icons.arrow_back_ios_new_outlined,
//                   onPressed: controller.scrollLeft,
//                   width: 30,
//                   height: 25,
//                   borderRadius: 5,
//                   iconSize: 15,
//                   iconColor: Color(0xff982a49),
//                   backgroundColor: Color(0xfff9e7e9),
//                 ),
//                 ReusableButton(
//                   icon: Icons.arrow_forward_ios_rounded,
//                   onPressed: controller.scrollRight,
//                   width: 30,
//                   height: 25,
//                   iconSize: 15,
//                   borderRadius: 5,
//                   iconColor: Color(0xff982a49),
//                   backgroundColor: Color(0xfff9e7e9),
//                 )
//               ],
//             ),
//             Divider(height: 20, color: Colors.black),
//             Expanded(
//               child: PageView.builder(
//                 controller: controller.pageController,
//                 itemCount: (controller.allGameImages.length / 6).ceil(),
//                 itemBuilder: (context, pageIndex) {
//                   int startIndex = pageIndex * 6;
//                   int endIndex = (startIndex + 6).clamp(0, controller.allGameImages.length);
//                   List<String> imagesToShow = controller.allGameImages.sublist(startIndex, endIndex);
//
//                   return GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 0.6,
//                     ),
//                     itemCount: imagesToShow.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         color: AppColors.cardColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(
//                             imagesToShow[index],
//                             fit: BoxFit.fill, // Makes image cover entire card
//                             height: double.infinity, // Ensures full height
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
// reusable_popular_games_widget.dart


class ReusablePopularGamesWidget extends StatelessWidget {
  final String title;
  final PopularGamesController controller;
  final List<String> imagesList;

  ReusablePopularGamesWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.imagesList, // Dynamically pass the list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(10),
        height: controller.showAll.value ? 450 : 250,
        decoration: BoxDecoration(
          color: AppColors.popularContainer,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                ReusableButton(
                  text: controller.showAll.value ? "Show Less" : "See All",
                  onPressed: controller.toggleShowAll,
                  width: 90,
                  height: 26,
                  borderRadius: 20,
                  fontSize: 13,
                  backgroundColor: Colors.white,
                  textColor: Color(0xff5d1f31),
                ),
                ReusableButton(
                  icon: Icons.arrow_back_ios_new_outlined,
                  onPressed: controller.scrollLeft,
                  width: 30,
                  height: 25,
                  borderRadius: 5,
                  iconSize: 15,
                  iconColor: Color(0xff982a49),
                  backgroundColor: Color(0xfff9e7e9),
                ),
                ReusableButton(
                  icon: Icons.arrow_forward_ios_rounded,
                  onPressed: controller.scrollRight,
                  width: 30,
                  height: 25,
                  iconSize: 15,
                  borderRadius: 5,
                  iconColor: Color(0xff982a49),
                  backgroundColor: Color(0xfff9e7e9),
                )
              ],
            ),
            Divider(height: 20, color: Colors.black),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: (imagesList.length / 6).ceil(),
                itemBuilder: (context, pageIndex) {
                  int startIndex = pageIndex * 6;
                  int endIndex = (startIndex + 6).clamp(0, imagesList.length);
                  List<String> imagesToShow = imagesList.sublist(startIndex, endIndex);

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: imagesToShow.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppColors.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imagesToShow[index],
                            fit: BoxFit.fill, // Makes image cover entire card
                            height: double.infinity, // Ensures full height
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

