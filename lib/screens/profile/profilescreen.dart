import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


import '../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../main.dart';
import '../../utils/validator.dart';
import '../../widgets/reusable_button.dart';
import 'dart:io';
import 'package:get/get.dart';


class ImageController extends GetxController {
  var selectedImage = Rx<File?>(null); // Observable variable for image
  RxString transactionId = ''.obs;
  var selectedDate = ''.obs;
  void generateTransactionId() {
    int randomNum = Random().nextInt(900000) + 100000; // 6-digit random number
    String newId = 'TXN$randomNum'; // Optional prefix
    transactionId.value = newId;
  }
  void setCurrentDate() {
    final now = DateTime.now();
    final formatted = DateFormat('dd.MM.yyyy').format(now); // 👈 this gives 17.04.2025
    selectedDate.value = formatted;
    logPrint('Selected Date: $formatted');
  }
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
    Get.back(); // Close BottomSheet after selection
  }
}


class UpdateDialogBox extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());
  final RegisterController controllerss = Get.put(RegisterController());
  final ImageController imageController = Get.put(ImageController());
  final RegisterController userController = Get.put(RegisterController());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  UpdateDialogBox({Key? key}) : super(key: key) {
    final user = userController.userProfile.value;

    phoneController.text = user?.phone ?? "";  // ✅ Null check added
    nameController.text = user?.name != null && user!.name.isNotEmpty
        ? user!.name[0].toUpperCase() + user!.name.substring(1)
        : "";  // ✅ Null check added
    emailController.text = user?.email ?? ""; // ✅ Null check added
  }

  void _showImagePicker() {
    Get.bottomSheet(
      Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
              title: Text("Take a Photo"),
              onTap: () => imageController.pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primaryColor),
              title: Text("Choose from Gallery"),
              onTap: () => imageController.pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Container(
                width: constraints.maxWidth * 0.9,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),

                        /// 📌 **Profile Image**
                        // GestureDetector(
                        //   onTap: _showImagePicker,
                        //   child: Obx(() {
                        //     return CircleAvatar(
                        //       radius: 40,
                        //       backgroundColor: Colors.grey.shade800,
                        //       backgroundImage: imageController.selectedImage.value != null
                        //           ? FileImage(imageController.selectedImage.value!)
                        //           : null,
                        //       child: imageController.selectedImage.value == null
                        //           ? Icon(Icons.camera_alt, color: Colors.white, size: 30)
                        //           : null,
                        //     );
                        //   }),
                        // ),
                        Image.asset(
                          AppImages.splashLogo,
                          height: 50,
                        ),
                        const SizedBox(height: 10),

                        /// 📌 **Name Field**
                        CustomTextField(
                          controller: nameController,
                          hintText: "Enter your name",
                          prefixIcon: const Icon(Icons.person, size: 20),
                          prefixIconColor: AppColors.getotp,
                          validator: Validators.validateName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10),

                        /// 📌 **Phone Number Field**
                        CustomTextField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          isEnabled: false,
                          controller: phoneController,
                          hintText: "82XXXXXXXX",
                          keyboardType: TextInputType.phone,
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(width: 5),
                              Text("+91"),
                              SizedBox(width: 5),

                            ],
                          ),
                          // flagImage: Image.asset(AppImages.indiaMapIcon,
                          //     width: 24, height: 24),
                          // validator: Validators.validatePhoneNumber,
                          onChanged: (value) {
                            controller.phoneNumberLength.value = value.length;
                          },
                        ),

                        const SizedBox(height: 10),

                        /// 📌 **Email Field**
                        CustomTextField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: emailController,
                          hintText: "Enter your email",
                          prefixIcon: const Icon(Icons.email, size: 20),
                          prefixIconColor: AppColors.getotp,
                          validator: Validators.validateEmail,
                        ),

                        const SizedBox(height: 10),

                        /// 📌 **Submit Button**
                        ReusableButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              final user = UpdateUserModal(
                                phone: phoneController.text,
                                name: nameController.text,
                                email: emailController.text,
                                token: 'BETLAJDNDNDBARKXTER',
                                // profileImage: imageController.selectedImage.value?.path, // Pass image path if selected
                              );

                              RegistrationController.savePhoneNumber(phone: phoneController.text.toString());
                              controllerss.UpdateUsercon(user);
                              Get.back();
                            } else {
                              logPrint("Form Validation Failed");
                            }
                          },
                          text: "Update Profile",
                          backgroundColor: AppColors.primaryColor,
                          height: 35,
                          width: 300,
                        ),

                        const SizedBox(height: 10),


                      ],
                    ),
                  ),
                ),
              ),

              /// 📌 **Cancel Icon (Top Right Inside Dialog)**
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// ✅ **Show Update Dialog (Prevents Accidental Dismiss)**
void showUpdateDialog() {
  Get.dialog(
    UpdateDialogBox(),
    barrierDismissible: false,
  );
}
