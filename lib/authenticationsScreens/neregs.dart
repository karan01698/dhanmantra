// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../backend/authenticanapi/authencatemodals/registermodals.dart';
// import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
//
//
// class RegisterScreen extends StatelessWidget {
//   final RegisterController controller = Get.put(RegisterController());
//
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController promoCodeController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController balanceController = TextEditingController();
//   final TextEditingController exposureController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Register")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildTextField(phoneController, "Phone"),
//             _buildTextField(passwordController, "Password", isPassword: true),
//             _buildTextField(promoCodeController, "Promo Code"),
//             _buildTextField(nameController, "Name"),
//             _buildTextField(emailController, "Email"),
//             _buildTextField(balanceController, "Balance"),
//             _buildTextField(exposureController, "Exposure"),
//             SizedBox(height: 20),
//
//             Obx(() => controller.isLoading.value
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: () {
//                 final user = User(
//                   phone: phoneController.text,
//                   password: passwordController.text,
//                   promoCode: promoCodeController.text,
//                   name: nameController.text,
//                   email: emailController.text,
//                   balance: balanceController.text,
//                   exposure: exposureController.text, token: 'BETLAJDNDNDBARKXTER', countryCode: '',
//                 );
//
//                 controller.registerUser(user);
//               },
//               child: Text("Register"),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label, {bool isPassword = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }
