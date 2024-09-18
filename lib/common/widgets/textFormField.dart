import 'package:dis_app/utils/colors.dart';
import 'package:dis_app/utils/sizes.dart';
import 'package:flutter/material.dart';

class DisTextFormField extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool showPasswordToggle;
  final TextEditingController? controller;

  const DisTextFormField({
    Key? key,
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
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: DisColors.grey,
          fontSize: DisSizes.fontSizeXs,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: DisColors.primary,
          ),
        ),
        suffixIcon: widget.showPasswordToggle
            ? IconButton(
          icon: Icon(
            size: DisSizes.sm,
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
      style: TextStyle(
        fontSize: DisSizes.fontSizeXs,
        fontWeight: FontWeight.w400,
      ),
      obscureText: _obscureText,
      validator: widget.validator,
      controller: widget.controller,
    );
  }
}