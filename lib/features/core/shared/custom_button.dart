import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final Color colorButton; // final and no default here
  final Function()? onTap;
  final double borderRadius;
  final Color colorText;
  const CustomButton({
    super.key,
    required this.text,
    this.borderRadius = 40,
    this.padding,
    this.margin,
    this.width,
    this.onTap,
    this.colorButton = Colors.deepOrange,  this.colorText= Colors.white, // 👉 Default color here!
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(

        padding: padding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
        color: colorButton,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
