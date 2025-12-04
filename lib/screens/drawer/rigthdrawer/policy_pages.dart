import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/colors.dart';

/// Model to represent the CMS content
class CmsPageModel {
  final String content;

  CmsPageModel({required this.content});

  factory CmsPageModel.fromJson(Map<String, dynamic> json) {
    return CmsPageModel(
      content: json['PageName'] ?? '',
    );
  }
}

/// Controller to handle API call and state
class CmsPageController extends GetxController {
  var content = ''.obs;
  var isLoading = true.obs;

  Future<void> fetchPageData(String pageName) async {
    try {
      isLoading.value = true;
      final token = "ADFHNSAMALOUAAKL";
      final url =
          "https://dhanmantragame.com/APIs/WebService1.asmx/ConditionPages?token=$token&PageName=$pageName";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = response.body;

        // Extract JSON array from the XML string
        final startIndex = body.indexOf('[');
        final endIndex = body.lastIndexOf(']');

        if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
          final jsonString = body.substring(startIndex, endIndex + 1);
          final List<dynamic> jsonList = json.decode(jsonString);

          if (jsonList.isNotEmpty) {
            final cmsPage = CmsPageModel.fromJson(jsonList[0]);
            content.value = cmsPage.content;
          } else {
            content.value = "No content found.";
          }
        } else {
          content.value = "Invalid response format.";
        }
      } else {
        content.value = "Failed to load data";
      }
    } catch (e) {
      content.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}

/// UI Screen to display CMS Page content
class CmsPageScreen extends StatelessWidget {
  final String pageName;
  final String title;

  CmsPageScreen({required this.pageName, required this.title});

  final CmsPageController controller = Get.put(CmsPageController());

  @override
  Widget build(BuildContext context) {
    // Trigger data fetch when widget builds
    controller.fetchPageData(pageName);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title, style: GoogleFonts.baloo2(color: AppColors.white,fontWeight:FontWeight.bold)),
        backgroundColor: AppColors.getotp,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Text(
              controller.content.value,
              style: const TextStyle(fontSize: 16,color: Colors.white),
            ),
          );
        }
      }),
    );
  }
}
