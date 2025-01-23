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

class IncomeCards extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final double width;
  final double height;

  const IncomeCards({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    this.width = 0.7,
    this.height = 200,
  });
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_downward_outlined),
                Text(text2),
              ],
            ),
          ),
          SizedBox(
            child: Text(
              text3,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
