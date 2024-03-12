import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final prefixIcon;
  final readonly;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.labelText,
    this.onSaved,
    this.validator,
    this.prefixIcon,
    this.readonly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hintText ?? '',
        labelText: labelText ?? '',
        prefixIcon: prefixIcon ?? SizedBox(),
      ),
      onSaved: onSaved,
      validator: validator,
);
}
}