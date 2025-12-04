import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final double? height;

  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;

  const CustomText(
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
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          height: height ?? 1,
          fontSize: size ?? 14,
          color: color ?? Colors.white,
          fontWeight: weight ?? FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomTextBottom extends StatelessWidget {
  final String? text;
  final double? size;
  final double? height;

  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;

  const CustomTextBottom(
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
      style: GoogleFonts.josefinSans(
        textStyle: TextStyle(
          height: height ?? 1,
          fontSize: size ?? 14,
          color: color ?? Colors.white,
          fontWeight: weight ?? FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomText3 extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? align;

  const CustomText3(
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
      style: GoogleFonts.spaceGrotesk(
        height: height ?? 1,
        textStyle: TextStyle(
            fontSize: size ?? 14,
            color: color ?? Colors.white,
            fontWeight: weight ?? FontWeight.w600),
      ),
    );
  }
}

class CustomText2 extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? align;
  final TextStyle? style;

  const CustomText2(
      {super.key,
      this.text,
      this.size,
      this.color,
      this.style,
      this.weight,
      this.align,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align ?? TextAlign.start,
      style: style ??
          GoogleFonts.libreBaskerville(
            height: height ?? 1,
            textStyle: TextStyle(
                fontSize: size ?? 14,
                color: color ?? Colors.white,
                fontWeight: weight ?? FontWeight.w600),
          ),
    );
  }
}

class CustomText4 extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? align;
  final FontStyle? style;

  const CustomText4(
      {super.key,
      this.text,
      this.size,
      this.color,
      this.style,
      this.weight,
      this.align,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align ?? TextAlign.start,
      style: GoogleFonts.dmSans(
        height: height ?? 1,
        textStyle: TextStyle(
            fontSize: size ?? 14,
            color: color ?? Colors.white,
            fontWeight: weight ?? FontWeight.w600),
      ),
    );
  }
}

class CustomText5 extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? align;

  const CustomText5(
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
      style: GoogleFonts.ubuntu(
        height: height ?? 1,
        textStyle: TextStyle(
            fontSize: size ?? 14,
            color: color ?? Colors.white,
            fontWeight: weight ?? FontWeight.w600),
      ),
    );
  }
}

class CustomText9 extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? align;

  const CustomText9(
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
      style: TextStyle(
          fontFamily: 'font',
          height: height ?? 1,
          fontSize: size ?? 14,
          color: color ?? Colors.white,
          fontWeight: weight ?? FontWeight.w600),
    );
  }
}

class CustomText8 extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? align;

  const CustomText8(
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
      style: GoogleFonts.playfairDisplay(
        height: height ?? 1,
        textStyle: TextStyle(
            fontSize: size ?? 14,
            color: color ?? Colors.white,
            fontWeight: weight ?? FontWeight.w600),
      ),
    );
  }
}

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
      style: GoogleFonts.nunito(
        height: 1,
        textStyle: TextStyle(
            fontSize: size ?? 14,
            color: color ?? Colors.white,
            fontWeight: weight ?? FontWeight.w600),
      ),
    );
  }
}
