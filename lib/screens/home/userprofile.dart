import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../backend/authenticanapi/controllerapi/registerapicontroller.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegisterController userController = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
          await userController.loadUserProfile();
          return userController.userProfile.value?.balance;
        }).distinct(), // Avoid redundant UI updates
        builder: (context, snapshot) {
          return Obx(() {
            final user = userController.userProfile.value;
            if (user == null) {
              return Center(child: Text("User profile not found"));
            }

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${user.id}"),
                  Text("Phone: ${user.phone}"),
                  Text("Name: ${user.name}"),
                  Text("Email: ${user.email}"),
                  Text("Balance: ${user.balance}"), // Updates only if balance changes
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
