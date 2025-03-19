// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isPassword;
  bool obscureText;

  CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        suffixIcon:
            widget.isPassword
                ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  child: Icon(
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
                : null,
      ),
    );
  }
}
