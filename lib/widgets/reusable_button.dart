import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReusableButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double fontSize;
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;
  final String? imagePath;
  final double? imageSize;
  final bool isShimmer;
  final Duration shimmerDuration;
  final AlignmentGeometry alignment;

  const ReusableButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.backgroundColor,
    this.gradientColors,
    this.textColor = Colors.white,
    this.height = 50,
    this.width = 150,
    this.borderRadius = 10,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.fontSize = 16,
    this.icon,
    this.iconColor,
    this.iconSize = 24,
    this.imagePath,
    this.imageSize = 24,
    this.isShimmer = false,
    this.shimmerDuration = const Duration(seconds: 2),
    this.alignment = Alignment.center,
  })  : assert(
  backgroundColor != null || gradientColors != null,
  'Either backgroundColor or gradientColors must be provided',
  ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: 6, // Optional for Material shadow as well
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: Colors.white24, // Ripple splash effect
        highlightColor: Colors.white10,
         child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: gradientColors == null ? backgroundColor : null,
          gradient: gradientColors != null
              ? LinearGradient(
            colors: gradientColors!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Stack(
          children: [
            // ⬇️ Wrap the content in a Container for alignment
            Container(
              height: height,
              width: width,
              alignment: alignment, // ✅ Apply alignment here
              child: _buildContent(),
            ),
            if (isShimmer)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: Colors.white.withOpacity(0.5),
                    period: shimmerDuration,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),

    ),
    );
  }

  Widget _buildContent() {
    List<Widget> children = [];

    if (imagePath != null) {
      children.add(
        Image.asset(
          imagePath!,
          height: imageSize,
          width: imageSize,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported, size: 24, color: Colors.red);
          },
        ),
      );
    }

    if (icon != null) {
      children.add(Icon(icon, color: iconColor ?? textColor, size: iconSize));
    }

    if (text != null) {
      children.add(Text(
        text!,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children
          .map((widget) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: widget,
      ))
          .toList(),
    );
  }
}
