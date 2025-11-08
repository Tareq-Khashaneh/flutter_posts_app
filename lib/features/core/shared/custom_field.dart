import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomField extends StatefulWidget {
  CustomField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.maxLines = 1,
    this.hint,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.isPassword,

    this.controller,
    this.isFilled = true,
    this.borderRadius = 20,
    this.fillColor = AppColors.fieldColor,
    this.borderSide = BorderSide.none,
    this.validator,
    this.enabledBorderSide = const BorderSide(color: Colors.transparent),
    this.focusedBorderSide = const BorderSide(color: Colors.transparent, width: 2),
  });
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final String? label;
  final String? hint;
  final bool isFilled;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final double borderRadius;
  late bool? isPassword;
  final BorderSide borderSide;
  final Color fillColor;
  final int maxLines;
  final BorderSide enabledBorderSide;
  final BorderSide focusedBorderSide;
  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          validator: widget.validator,
          keyboardType: widget.textInputType,
          onChanged: widget.onChanged,
          obscureText: widget.isPassword != null ? widget.isPassword! : false,
          decoration: InputDecoration(
            labelText: widget.label,
            filled: widget.isFilled,
            fillColor: widget.fillColor,
            hintText: widget.hint,
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: widget.borderSide,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: widget.enabledBorderSide,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: widget.focusedBorderSide,
            ),
            suffixIcon: widget.isPassword != null
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isPassword = !widget.isPassword!;
                      });
                    },
                    icon: widget.isPassword!
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )
                : widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ],
    );
  }
}
