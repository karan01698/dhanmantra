import 'package:flutter/material.dart';



class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // Adjust size
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5), // Background with opacity
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          child: Opacity(
            opacity: 0.9, // Adjust transparency
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15), // Match container
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.3), // Apply color filter
                  BlendMode.overlay, // Change blending mode
                ),
                child: Image.asset(
                  'assets/alltypesimages.png', // Put image in `assets`
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

    );
  }
}
