// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html_iframe/flutter_html_iframe.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// class IframeScreen extends StatefulWidget {
//   const IframeScreen({super.key});
//
//   @override
//   State<IframeScreen> createState() => _IframeScreenState();
// }
//
// class _IframeScreenState extends State<IframeScreen> {
//   String? eventId;
//
//   @override
//   void initState() {
//     super.initState();
//     loadEventId();
//   }
//
//   Future<void> loadEventId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final storedEventId = prefs.getString('eventId');
//     await Future.delayed(const Duration(seconds: 2)); // simulate load
//     setState(() {
//       eventId = storedEventId ?? 'defaultEventId';
//     });
//   }
//
//   Widget _buildShimmerPlaceholder() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         child: Column(
//           children: [
//             Container(height: 200, color: Colors.white),
//             const SizedBox(height: 20),
//             Container(height: 20, color: Colors.white),
//             const SizedBox(height: 10),
//             Container(height: 20, color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (eventId == null) {
//       return _buildShimmerPlaceholder();
//     }
//     final screenWidth = MediaQuery.of(context).size.width;
//     // final iframeUrl = "https://dpmatka.in/sr.php?eventid=$eventId&sportid=2";
//     final iframeUrl = "https://dhanmantragame.com/Score.html?eventid=$eventId&sportid=2";
//     // final iframeUrl = "https://dhanmantragame.com/Hello.html";
//
//     return SingleChildScrollView(
//       padding: EdgeInsets.zero, // removes any default scrollview padding
//       child: Container(
//         height:500,
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.zero, // make sure this has no padding
//
//         child: Html(
//           extensions: [
//             IframeHtmlExtension(),
//           ],
//           data: """
//        <div style="width: 400px; margin: 0 auto; padding: 0;">
//     <iframe
//       src="$iframeUrl"
//       width="400px"
//       height="200"
//        style="border: none; margin: 0; padding: 0; display: block;"
//     ></iframe>
//   </div>
//       """,
//         ),
//       ),
//     );
//
//   }
// }