import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final double width;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPasswordField;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.backgroundColor = Colors.grey,
    this.width = 0.45, // Default to half the screen width
    this.validator,
    this.controller,
    this.isPasswordField = false, // Default is not a password field
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPasswordField ? _isObscured : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black54),
          filled: true,
          fillColor: widget.backgroundColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff582ae8), width: 2),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              color: Colors.black54,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
