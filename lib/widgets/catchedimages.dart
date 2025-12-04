// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';
//
// class CachedImageWidget extends StatelessWidget {
//   final String imageUrl;
//   final double width;
//   final double height;
//   final BoxFit fit;
//   final double borderRadius;
//
//   const CachedImageWidget({
//     Key? key,
//     required this.imageUrl,
//     this.width = double.infinity,
//     this.height = double.infinity,
//     this.fit = BoxFit.cover,
//     this.borderRadius = 5.0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: CachedNetworkImage(
//         imageUrl: imageUrl,
//         width: width,
//         height: height,
//         fit: fit,
//         placeholder: (context, url) => Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child: Container(
//             width: width,
//             height: height,
//             color: Colors.white,
//           ),
//         ),
//         errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
//       ),
//     );
//   }
// }
