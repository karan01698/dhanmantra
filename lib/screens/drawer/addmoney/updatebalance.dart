import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:sattagames/screens/drawer/addmoney/paymentscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../constants/colors.dart';
import '../../../main.dart';
import '../../../utils/validator.dart';
import '../../../widgets/reusable_button.dart';
import 'dart:io' if (dart.library.html) 'dart:html' as html;
import 'dart:typed_data';

import '../../profile/profilescreen.dart';
import '../transactionscreen/transcationsscreen.dart';

class UpdaBalanceControllersss extends GetxController {
  var selectedAmount = "".obs;
  var selectedImage = Rx<XFile?>(null);
  RxString transactionId = ''.obs;
  void generateTransactionId() {
    int randomNum = Random().nextInt(900000) + 100000; // 6-digit random number
    String newId = 'TXN$randomNum'; // Optional prefix
    transactionId.value = newId;
  }
  TextEditingController amountController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var base64Image = "".obs;
  var selectedDate = ''.obs;


  void setCurrentDate() {
    final now = DateTime.now();
    final formatted = DateFormat('dd.MM.yyyy').format(now); // 👈 this gives 17.04.2025
    selectedDate.value = formatted;
    logPrint('Selected Date: $formatted');
  }
  void setAmount(String amount) {
    selectedAmount.value = amount;
    amountController.text = amount;
    amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: amountController.text.length),
    );
  }

  Future<void> pickImage() async {
    try {
      if (kIsWeb) {
        // Web: Use FilePicker
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true, // Get bytes directly
        );

        if (result != null && result.files.single.bytes != null) {
          Uint8List bytes = result.files.single.bytes!;
          base64Image.value = base64Encode(bytes);

          // ✅ Store file name for display in TextField
          selectedImage.value = XFile(result.files.single.name);
          logPrint("✅ Image uploaded on Web!");
        } else {
          logPrint("❌ No image selected on Web.");
        }
      } else {
        // Mobile: Use ImagePicker
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);
          List<int> imageBytes = await imageFile.readAsBytes();
          base64Image.value = base64Encode(imageBytes);

          // ✅ Store file for mobile
          selectedImage.value = XFile(pickedFile.path);
          logPrint("✅ Image uploaded on Mobile!");
        } else {
          logPrint("❌ No image selected on Mobile.");
        }
      }
    } catch (e) {
      logPrint("⚠️ Error picking image: $e");
    }
  }

  void clearFields() {
    amountController.clear();
    selectedImage.value = null;
    base64Image.value = "";
  }

  @override
  void dispose() {
    clearFields(); // Reset fields when controller is disposed
    amountController.dispose();
    super.dispose();
  }
}

class UpdatebalanceScreens extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());
  final RegisterController controllerss = Get.put(RegisterController());
  final UpdaBalanceControllersss controller =
  Get.put(UpdaBalanceControllersss());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isLoading = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Balance", style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.getotp,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),

                    /// Grid Buttons for Quick Amount Selection
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.5,
                      children: [
                        "500",
                        "1000",
                        "2000",
                        "5000",
                        "10000",
                        "20000"
                      ].map((amount) {
                        return ReusableButton(
                          onPressed: () => controller.setAmount(amount),
                          text: "+ $amount",
                          gradientColors: [
                            AppColors.getotp1,
                            AppColors.getotp2
                          ],
                          height: 80,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),

                    /// Enter Amount TextField
                    Text("Enter Your Amount",
                        style:
                        TextStyle(color: AppColors.getotp, fontSize: 16)),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: controller.amountController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon:
                        Icon(Icons.currency_rupee, color: Colors.white),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white, width: 5),
                        ),
                        errorStyle: TextStyle(color: Colors.red),
                        hintText: kIsWeb
                            ? (controller.selectedImage.value?.name ??
                            "Enter Amount") // ✅ Show image name on Web
                            : "Enter Amount",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please fill amount";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    /// Upload Payment Image Section
                    Text("Upload Payment Slip",
                        style:
                        TextStyle(color: AppColors.getotp, fontSize: 16)),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showImagePicker(context, controller),
                      child: Obx(() => Container(
                        width: screenWidth,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            /// Show Selected Image if Available
                            if (controller.selectedImage.value != null)
                              Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: kIsWeb
                                        ? MemoryImage(base64Decode(
                                        controller.base64Image
                                            .value)) // ✅ Web
                                        : FileImage(File(controller
                                        .selectedImage
                                        .value!
                                        .path)) // ✅ Convert XFile to File
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            /// Placeholder Text
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text(
                                controller.selectedImage.value != null
                                    ? "Image Selected"
                                    : "Tap to Upload Image",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                    SizedBox(height: 20),

                    SizedBox(height: 600, child: PaymentScreen()),
                    // TableTransactionScreen(),

                    SizedBox(height: 10),

                    // Payment screen widget
                  ],
                ),
              ),
            ),
          ),

          Obx(() => ReusableButton (
            onPressed:() async{
              if (controller.formKey.currentState!.validate()) {
                controllerss.isLoading.value = true; // ✅ Start loading

                try {
                  if (controller.selectedImage.value == null) {
                    Get.snackbar("Error", "Please upload your payment slip",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    controllerss.isLoading.value = false;
                    return;
                  }

                  String? phone = await RegistrationController.getPhoneNumber();
                  if (phone == null || phone.isEmpty) {
                    Get.snackbar("Error", "No saved phone number found.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    controllerss.isLoading.value = false;
                    return;
                  }
                  controller.setCurrentDate();
                  controller.generateTransactionId();
                  final RegisterController userController = Get.put(RegisterController());
                  // var dealer = userController.userProfile.value?.RDate ?? "";
                  final user = WithdrawAmountModal(
                    token: 'BETLAJDNDNDBARKXTER',
                    tid: controller.transactionId.value,
                    amt: controller.amountController.text,
                    purpose: '',
                    type: 'Add',
                    tDate: controller.selectedDate.value,
                    accountNumber: "",
                    ifsc: "",
                    branch: controller.base64Image.value ?? "",
                    upi: "",
                    phone: phone,
                    dealer:  ""
                  );
// p
                  await controllerss.withdrawAmountMethod(user);
                } catch (e) {
                  logPrint("Error: $e");
                } finally {
                  controllerss.isLoading.value = false; // ✅ Stop loading
                }
              } else {
                logPrint("Form Validation Failed");
              }
            },
            text: controllerss.isLoadingss.value ? "Loading..." : "Update Balance", // ✅ Dynamic text update
            backgroundColor: AppColors.getotp,
            height: 35,
            width: 300,
          )),

          /// Add Amount Button with Validation
          // Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: SizedBox(
          //         width: double.infinity,
          //         child: Center(
          //             child: ReusableButton(
          //               onPressed: () async {
          //                 if (controller.formKey.currentState!.validate()) {
          //                   controllerss.isLoading.value =
          //                   true; // ✅ Start loading
          //
          //                   try {
          //                     if (controller.selectedImage.value == null) {
          //                       Get.snackbar(
          //                         "Error",
          //                         "Please upload your payment slip",
          //                         backgroundColor: Colors.red,
          //                         colorText: Colors.white,
          //                       );
          //                       controllerss.isLoading.value = false;
          //                       return;
          //                     }
          //
          //                     String? phone = await RegistrationController
          //                         .getPhoneNumber();
          //                     if (phone == null || phone.isEmpty) {
          //                       Get.snackbar(
          //                         "Error",
          //                         "No saved phone number found.",
          //                         backgroundColor: Colors.red,
          //                         colorText: Colors.white,
          //                       );
          //                       controllerss.isLoading.value = false;
          //                       return;
          //                     }
          //
          //                     final user = WithdrawAmountModal(
          //                       token: 'BETLAJDNDNDBARKXTER',
          //                       tid: '',
          //                       amt: controller.amountController.text,
          //                       purpose: '',
          //                       type: 'ADD',
          //                       tDate: '',
          //                       accountNumber: "",
          //                       ifsc: "",
          //                       branch: controller.base64Image.value ?? "",
          //                       upi: "",
          //                       phone: phone,
          //                     );
          //
          //                     await controllerss.withdrawAmountMethod(user);
          //                   } catch (e) {
          //                     logPrint("Error: $e");
          //                   } finally {
          //                     controllerss.isLoading.value =
          //                     false; // ✅ Stop loading
          //                   }
          //                 } else {
          //                   logPrint("Form Validation Failed");
          //                 }
          //               },
          //               text: "Update Balance",
          //               // ✅ Dynamic text update
          //               backgroundColor: AppColors.getotp,
          //               height: 35,
          //               width: 300,
          //             )),
          //
          //     )),


        ],
      ),
    );
  }

  /// Show Image Picker Options (Camera / Gallery)
  void _showImagePicker(
      BuildContext context, UpdaBalanceControllersss controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: 120,
          child: Column(
            children: [
              Text("Select Image",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera, size: 30),
                    onPressed: () {
                      controller.pickImage(); // ✅ Remove ImageSource parameter
                      Get.back();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.image, size: 30),
                    onPressed: () {
                      controller.pickImage(); // ✅ Remove ImageSource parameter
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class BankDetails {
  final String accountNo;
  final String ifscCode;
  final String bankName; // using "Branch" as bankName
  final String accountName;


  BankDetails({
    required this.accountNo,
    required this.ifscCode,
    required this.bankName,
    required this.accountName,

  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      accountNo: json['Accountnumber'] ?? '',
      ifscCode: json['IFSC'] ?? '',
      bankName: json['Branch'] ?? '',
      accountName: json['Accountholder'] ?? '',

    );
  }
}
 // adjust the path

 // your model class

class BankController extends GetxController {
  var bankList = <BankDetails>[].obs;

  final String apiUrl =
      'https://dhanmantragame.com/APIs/WebService1.asmx/BankAccounts?token=BETLAJDNDNDBARKXTER';

  @override
  void onInit() {
    fetchBankDetails();
    super.onInit();
  }

  void fetchBankDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dealer = prefs.getString('dealer') ?? '';
    logPrint("hellow dealer $dealer");
    try {
      final response = await http.get(Uri.parse('https://dhanmantragame.com/APIs/WebService1.asmx/BankAccounts?token=BETLAJDNDNDBARKXTER&dealer=$dealer'));
      logPrint('https://dhanmantragame.com/APIs/WebService1.asmx/BankAccounts?token=BETLAJDNDNDBARKXTER&dealer=$dealer');

      logPrint("Status Code: ${response.statusCode}");
      logPrint("Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        // Clean the XML-style <string>...</string> wrapper
        final jsonString =
        response.body.replaceAll(RegExp(r'^<string.*?>|<\/string>$'), '');

        final List<dynamic> data = jsonDecode(jsonString);
        bankList.value = data.map((e) => BankDetails.fromJson(e)).toList();
      } else {
        logPrint("API Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      logPrint("Exception: $e");
    }
  }
}

     // adjust path

class BankListScreen extends StatelessWidget {
  final BankController controller = Get.put(BankController());

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to clipboard")),
    );
  }

  Widget buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "$label : $value",
              style: TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(Icons.copy, size: 18, color: AppColors.getotp1),
            onPressed: () => copyToClipboard(context, value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Bank Details"),
        backgroundColor: AppColors.getotp1,
      ),
      body: Obx(() {

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: controller.bankList.length,
          itemBuilder: (context, index) {
            final bank = controller.bankList[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    buildRow(context, "A/C No", bank.accountNo),
                    buildRow(context, "Account Holder", bank.accountName),
                    buildRow(context, "IFSC Code", bank.ifscCode),
                    buildRow(context, "Branch", bank.bankName),

                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

//
//
// class BankDetails {
//   final String bankName;
//   final String accountNo;
//   final String ifscCode;
//   final String accountName;
//   final String minAmount;
//   final String maxAmount;
//
//   BankDetails({
//     required this.bankName,
//     required this.accountNo,
//     required this.ifscCode,
//     required this.accountName,
//     required this.minAmount,
//     required this.maxAmount,
//   });
// }
//
// class BankListScreen extends StatelessWidget {
//   final List<BankDetails> bankList = [
//     BankDetails(
//       bankName: "ICICI",
//       accountNo: "123456789012",
//       ifscCode: "ICIC0000123",
//       accountName: "RAHUL SHARMA",
//       minAmount: "300",
//       maxAmount: "1000000",
//     ),
//     BankDetails(
//       bankName: "HDFC",
//       accountNo: "987654321098",
//       ifscCode: "HDFC0000456",
//       accountName: "PRIYA SINGH",
//       minAmount: "500",
//       maxAmount: "2000000",
//     ),
//     BankDetails(
//       bankName: "AXIS",
//       accountNo: "456789123456",
//       ifscCode: "UTIB0000789",
//       accountName: "AMIT KUMAR",
//       minAmount: "250",
//       maxAmount: "1500000",
//     ),
//   ];
//
//   void copyToClipboard(BuildContext context, String text) {
//     Clipboard.setData(ClipboardData(text: text));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Copied to clipboard")),
//     );
//   }
//
//   Widget buildRow(BuildContext context, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Text(
//               "$label : $value",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.copy, size: 18, color: Colors.green),
//             onPressed: () => copyToClipboard(context, value),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bank Details"),
//         backgroundColor: Colors.green,
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(12),
//         itemCount: bankList.length,
//         itemBuilder: (context, index) {
//           final bank = bankList[index];
//           return Card(
//             elevation: 4,
//             margin: EdgeInsets.symmetric(vertical: 8),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   buildRow(context, "Bank Name", bank.bankName),
//                   buildRow(context, "A/C No", bank.accountNo),
//                   buildRow(context, "IFSC Code", bank.ifscCode),
//                   buildRow(context, "Account Name", bank.accountName),
//                   buildRow(context, "Min Amount", bank.minAmount),
//                   buildRow(context, "Max Amount", bank.maxAmount),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
