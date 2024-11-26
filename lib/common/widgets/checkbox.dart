import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DisCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final String label;

  const DisCheckbox({
    Key? key,
    this.initialValue = false,
    required this.onChanged,
    this.activeColor = DisColors.primary,
    this.checkColor = DisColors.white,
    this.label = '',
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<DisCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: _onCheckboxChanged,
          activeColor: widget.activeColor,
          checkColor: widget.checkColor,
        ),
        if (widget.label.isNotEmpty)
          Text(widget.label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
