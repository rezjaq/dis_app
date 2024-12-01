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
            isFirst: true,
          ),
          _buildToggleButton(
            context: context,
            label: "Post",
            isSelected: !isSellSelected,
            onTap: () => onToggle(false),
            isFirst: false,
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
    required bool
        isFirst, // Tambahkan untuk mengetahui tombol pertama atau kedua
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: DisHelperFunctions.screenWidth(context) * 0.45,
        padding: const EdgeInsets.symmetric(
          horizontal: DisSizes.md,
          vertical: DisSizes.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? DisColors.primary : DisColors.white,
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? const Radius.circular(16) : Radius.zero,
            right: !isFirst ? const Radius.circular(16) : Radius.zero,
          ),
          border: Border.all(
            color: DisColors.primary,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? DisColors.white : DisColors.primary,
            fontSize: DisSizes.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
