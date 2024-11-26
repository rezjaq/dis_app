import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class SectionToggle extends StatelessWidget {
  final bool isSellSelected;
  final ValueChanged<bool> onToggle;

  const SectionToggle({
    Key? key,
    required this.isSellSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DisSizes.md,
        vertical: DisSizes.md,
      ),
      child: Row(
        children: [
          _buildToggleButton(
            context: context,
            label: "Sell",
            isSelected: isSellSelected,
            onTap: () => onToggle(true),
          ),
          _buildToggleButton(
            context: context,
            label: "Post",
            isSelected: !isSellSelected,
            onTap: () => onToggle(false),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: DisHelperFunctions.screenWidth(context) *
            0.45, // Gunakan BuildContext
        padding: const EdgeInsets.symmetric(
          horizontal: DisSizes.md,
          vertical: DisSizes.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? DisColors.primary : DisColors.white,
          borderRadius: isSelected
              ? const BorderRadius.horizontal(left: Radius.circular(16))
              : const BorderRadius.horizontal(right: Radius.circular(16)),
          border: Border.all(
            color: DisColors.primary,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: DisColors.black,
            fontSize: DisSizes.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
