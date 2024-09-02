import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final int? maxlines;
  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.onEditingComplete,
    this.obscureText,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxlines ?? 1,
      onTap: onTap,
      keyboardType: keyboardType,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText ?? false,
      cursorHeight: 20,
      validator: validator,
      onChanged: onChanged,
      cursorColor: const Color(0xff83829A),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 8,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(color: Color(0xff83829A), width: 0.4)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(color: Color(0xff83829A), width: 0.4)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(color: Color(0xff83829A), width: 0.4)),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xff000000),
            fontWeight: FontWeight.normal),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
