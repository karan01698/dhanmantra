// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// import '../../backend/sliderapi.dart';
//
// class SliderScreen extends StatelessWidget {
//   final SliderController controller = Get.put(SliderController());
//   final PageController pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(() {
//           if (controller.banners.isEmpty) {
//             return _buildShimmerEffect();
//           } else {
//             return _buildPageView();
//           }
//         }),
//       ],
//     );
//   }
//
//   Widget _buildShimmerEffect() {
//     return SizedBox(
//       height: 200,
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 4,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Container(
//                   width: 300,
//                   height: 200,
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPageView() {
//     return SizedBox(
//       height: 200,
//       child: PageView.builder(
//         controller: pageController,
//         itemCount: controller.banners.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 2),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(5),
//               child: CachedNetworkImage(
//                 imageUrl: controller.banners[index],
//                 fit: BoxFit.fill,
//                 placeholder: (context, url) => Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: Container(
//                     width: 300,
//                     height: 200,
//                     color: Colors.white,
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../backend/sliderapi.dart';
import '../../widgets/catchedimages.dart';
// Import the reusable widget
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../backend/sliderapi.dart';
import '../../widgets/catchedimages.dart';

class SliderScreen extends StatelessWidget {
  final SliderController controller = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.banners.isEmpty) {
            return _buildShimmerEffect();
          } else {
            return _buildPageView();
          }
        }),
      ],
    );
  }

  Widget _buildShimmerEffect() {
    return SizedBox(
      height: 200,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 300,
                  height: 200,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: controller.pageController, // Auto scroll enabled
        itemCount: controller.banners.length,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Image.network(
             'https://dhanmantragame.com/Images/${controller.banners[index]}',
              width: 300,
              height: 200,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}

// class SliderScreen extends StatelessWidget {
//   final SliderController controller = Get.put(SliderController());
//   final PageController pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(() {
//           if (controller.banners.isEmpty) {
//             return _buildShimmerEffect();
//           } else {
//             return _buildPageView();
//           }
//         }),
//       ],
//     );
//   }
//
//   Widget _buildShimmerEffect() {
//     return SizedBox(
//       height: 200,
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 4,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Container(
//                   width: 300,
//                   height: 200,
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPageView() {
//     return SizedBox(
//       height: 200,
//       child: PageView.builder(
//         controller: pageController,
//         itemCount: controller.banners.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 2),
//             child: CachedImageWidget(
//               imageUrl: controller.banners[index],
//               width: 300,
//               height: 200,
//               fit: BoxFit.fill,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
