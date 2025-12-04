import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedDarkTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool enabled; // Added this parameter

  const RoundedDarkTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.enabled, // Initialize it
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        enabled: enabled, // Disable input when bet is active
        style: GoogleFonts.poppins(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Lightly dim field when disabled
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[800]),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
                color: enabled ? Colors.blue : Colors.grey, width: 2.0),
          ),
        ),
        cursorColor: enabled
            ? Colors.blue
            : Colors.grey, // Change cursor color when disabled
      ),
    );
  }
}
