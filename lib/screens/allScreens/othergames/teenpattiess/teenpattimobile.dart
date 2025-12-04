import 'package:flutter/material.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpattitablet.dart';
import '../../../../utils/responsvie_web_mobile.dart';
import '../../../../widgets/reusable_button.dart';

class TeenPattiTableMobile extends StatelessWidget {
  const TeenPattiTableMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/rummytables.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Players
              Positioned(
                top: ResponsiveHelpers.h(130),
                left: ResponsiveHelpers.w(360),
                child: playerIcon(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                  'Karandd',
                ),
              ),
              Positioned(
                top: ResponsiveHelpers.h(130),
                right: ResponsiveHelpers.w(360),
                child: playerIcon(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                  'Dheerajddd',
                ),
              ),
              Positioned(
                left: ResponsiveHelpers.w(280),
                top: screenHeight / 2 - ResponsiveHelpers.h(-50),
                child: playerIcon(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                  'Rishab',
                ),
              ),
              Positioned(
                right: ResponsiveHelpers.w(280),
                top: screenHeight / 2 - ResponsiveHelpers.h(-50),
                child: playerIcon(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                  'Avinash',
                ),
              ),
              Positioned(
                bottom: ResponsiveHelpers.h(20),
                child: playerIcon(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                  'Manish',
                ),
              ),

              // Pot Text
              Positioned(
                top: ResponsiveHelpers.h(400),
                child: Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Bd',
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.sp(50),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Pot Amount Box
              Positioned(
                top: ResponsiveHelpers.h(340),
                child: Container(
                  width: ResponsiveHelpers.w(100),
                  height: ResponsiveHelpers.h(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    border: Border.all(color: Colors.yellow, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '₹ 20,000',
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.sp(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),

              // Action Buttons
               Positioned(
                right: 60,
                bottom: 10,
                child: GameActionButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playerIcon(String imageUrl, String name) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool showFront = false;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_red_eye, color: Colors.white, size: 20),
              onPressed: () {
                setState(() {
                  showFront = !showFront;
                });
              },
            ),
            SizedBox(
              height: ResponsiveHelpers.h(50),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(ResponsiveHelpers.w(-20), 0),
                    child: Transform.rotate(
                      angle: -0.3,
                      child: Image.network(
                        showFront
                            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0w9X8Px4_Anjei3NXxIsTPLwiqO6ukgbVHQ&s'
                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWry3YF7OgVLIVbP02ArSwtojOuzmjeiAdpw&s',
                        width: ResponsiveHelpers.w(30),
                        height: ResponsiveHelpers.h(45),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Image.network(
                    showFront
                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0w9X8Px4_Anjei3NXxIsTPLwiqO6ukgbVHQ&s'
                        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWry3YF7OgVLIVbP02ArSwtojOuzmjeiAdpw&s',
                    width: ResponsiveHelpers.w(25),
                    height: ResponsiveHelpers.h(40),
                    fit: BoxFit.cover,
                  ),
                  Transform.translate(
                    offset: Offset(ResponsiveHelpers.w(20), 0),
                    child: Transform.rotate(
                      angle: 0.3,
                      child: Image.network(
                        showFront
                            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0w9X8Px4_Anjei3NXxIsTPLwiqO6ukgbVHQ&s'
                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWry3YF7OgVLIVbP02ArSwtojOuzmjeiAdpw&s',
                        width: ResponsiveHelpers.w(25),
                        height: ResponsiveHelpers.h(40),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ResponsiveHelpers.h(8)),
            CircleAvatar(
              radius: ResponsiveHelpers.r(40),
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(height: ResponsiveHelpers.h(6)),
            Text(
              name,
              style: TextStyle(
                fontSize: ResponsiveHelpers.sp(14),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
//
// class GameActionButtons extends StatelessWidget {
//   const GameActionButtons({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: ResponsiveHelpers.h(2)),
//       padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(10)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _buildActionButton(
//             text: "Pack",
//             onPressed: () {},
//           ),
//
//           _buildActionButton(
//             text: "Chaal",
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required String text,
//     required VoidCallback onPressed,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: ReusableButton(
//         text: text,
//         isShimmer: true,
//         shimmerDuration: const Duration(seconds: 3),
//         onPressed: onPressed,
//         width: ResponsiveHelpers.w(100),
//         height: ResponsiveHelpers.h(40),
//         borderRadius: 5,
//         fontSize: 15,
//         backgroundColor: Colors.black.withOpacity(0.6),
//         textColor: Colors.white,
//         borderColor: Colors.yellow,
//         borderWidth: 1,
//       ),
//     );
//   }
// }
