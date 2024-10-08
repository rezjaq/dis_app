import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DisTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool showPasswordToggle;
  final TextEditingController? controller;

  const DisTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.controller,
  }) : super(key: key);

  @override
  _DisTextFormFieldState createState() => _DisTextFormFieldState();
}

class _DisTextFormFieldState extends State<DisTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: DisColors.textPrimary),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: DisColors.textPrimary),
        filled: true,
        fillColor: DisColors.softGrey,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: DisColors.darkGrey)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: DisColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: DisColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: DisColors.error),
        ),
        errorStyle:
            TextStyle(fontSize: DisSizes.fontSizeXs, color: DisColors.error),
        suffixIcon: widget.showPasswordToggle
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: DisColors.darkGrey),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      style:
          TextStyle(fontSize: DisSizes.fontSizeXs, fontWeight: FontWeight.w400),
      obscureText: _obscureText,
      validator: widget.validator,
    );
  }
}
