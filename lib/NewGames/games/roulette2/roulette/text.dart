import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText6 extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? align;

  const CustomText6(
      {super.key,
      this.text,
      this.size,
      this.color,
      this.weight,
      this.align,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align ?? TextAlign.start,
      style: GoogleFonts.inter(
        height: 1,
        textStyle: TextStyle(
            fontSize: size ?? 14,
            color: color ?? Colors.white,
            fontWeight: weight ?? FontWeight.w600),
      ),
    );
  }
}
