// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
// import '../../../../../backend/huraf/haruf_controller_wallet.dart';
//
//
// class GameInputWidget extends StatefulWidget {
//   final void Function(Map<String, String>) onChanged;
//
//   const GameInputWidget({super.key, required this.onChanged});
//
//   @override
//   State<GameInputWidget> createState() => _GameInputWidgetState();
// }
//
// class _GameInputWidgetState extends State<GameInputWidget> {
//   final Map<String, TextEditingController> _controllers = {};
//   final HarufWalletController walletController = Get.put(HarufWalletController());
//
//   @override
//   void initState() {
//     super.initState();
//
//     for (int i = 1; i <= 10; i++) {
//       _controllers['A$i'] = TextEditingController();
//       _controllers['B$i'] = TextEditingController();
//     }
//
//     _controllers.forEach((key, controller) {
//       controller.addListener(_notifyChange);
//     });
//
//     RegistrationController.getPhoneNumber().then((phone) {
//       if (phone != null && phone.isNotEmpty) {
//         walletController.fetchBalance(phone);
//       }
//     });
//   }
//
//   void _notifyChange() {
//     final Map<String, String> data = {};
//     _controllers.forEach((key, controller) {
//       final value = controller.text.trim();
//       if (value.isNotEmpty) {
//         data[key] = value;
//       }
//     });
//     widget.onChanged(data);
//   }
//
//   @override
//   void dispose() {
//     _controllers.forEach((_, c) => c.dispose());
//     super.dispose();
//   }
//
//   Widget buildInputBox(String label) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(color: Colors.white)),
//         const SizedBox(height: 4),
//         Container(
//           height: 60,
//           width: 60,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             color: Colors.grey[900],
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.white24),
//           ),
//           child: TextField(
//             controller: _controllers[label],
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(border: InputBorder.none),
//             keyboardType: TextInputType.number,
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Wallet Row
//           Row(
//             children: const [
//               SizedBox(width: 30),
//               Expanded(
//                 child: Text(
//                   "Ander Game",
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(width: 40),
//               Expanded(
//                 child: Text(
//                   "Bahar Game",
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//
//           // No Expanded here
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: GridView.count(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   childAspectRatio: 4 / 4.5,
//                   children: [for (int i = 1; i <= 10; i++) buildInputBox('A$i')],
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: GridView.count(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   childAspectRatio: 4 / 4.5,
//                   children: [for (int i = 1; i <= 10; i++) buildInputBox('B$i')],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../../backend/huraf/haruf_controller_wallet.dart';

class GameInputWidget extends StatefulWidget {
  final void Function(Map<String, String>) onChanged;

  const GameInputWidget({super.key, required this.onChanged});

  @override
  State<GameInputWidget> createState() => _GameInputWidgetState();
}

class _GameInputWidgetState extends State<GameInputWidget> {
  final Map<String, TextEditingController> _controllers = {};
  final HarufWalletController walletController = Get.put(HarufWalletController());

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 10; i++) {
      String labelA = (i == 10) ? 'A0' : 'A$i';
      String labelB = (i == 10) ? 'B0' : 'B$i';
      _controllers[labelA] = TextEditingController();
      _controllers[labelB] = TextEditingController();
    }

    _controllers.forEach((key, controller) {
      controller.addListener(_notifyChange);
    });

    RegistrationController.getPhoneNumber().then((phone) {
      if (phone != null && phone.isNotEmpty) {
        walletController.fetchBalance(phone);
      }
    });
  }

  void _notifyChange() {
    final Map<String, String> data = {};
    _controllers.forEach((key, controller) {
      final value = controller.text.trim();
      if (value.isNotEmpty) {
        data[key] = value;
      }
    });
    widget.onChanged(data);
  }

  @override
  void dispose() {
    _controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  Widget buildInputBox(String label) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 4),
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: TextField(
            controller: _controllers[label],
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(border: InputBorder.none),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallet Row
          Row(
            children: const [
              SizedBox(width: 30),
              Expanded(
                child: Text(
                  "Ander Game",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Text(
                  "Bahar Game",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // No Expanded here
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 4.5,
                  children: [
                    for (int i = 1; i <= 10; i++)
                      buildInputBox(i == 10 ? 'A0' : 'A$i')
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 4.5,
                  children: [
                    for (int i = 1; i <= 10; i++)
                      buildInputBox(i == 10 ? 'B0' : 'B$i')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
