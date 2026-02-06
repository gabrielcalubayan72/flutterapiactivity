import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller; // ADD THIS

  const RegisterTextField({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller, // ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // ADD THIS
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}