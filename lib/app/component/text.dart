import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final VoidCallback? onTap;

  const CustomText({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp, // <- responsif!
        fontWeight: fontWeight,
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: textWidget);
    } else {
      return textWidget;
    }
  }
}
