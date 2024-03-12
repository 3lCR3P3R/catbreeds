import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    required this.controller,
    this.onChange,
    this.hintText,
    this.suffixIconWidget,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? onChange;
  final String? hintText;
  final Widget? suffixIconWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (onChange != null) onChange!(value);
        },
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIconWidget,
        ),
      ),
    );
  }
}
