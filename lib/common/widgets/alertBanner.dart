import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

void showCustomAlertBanner(
    BuildContext context,
    VoidCallback onTap,
    Widget child, {
      Duration durationOfStayingOnScreen = const Duration(seconds: 3),
      Duration durationOfScalingUp = const Duration(milliseconds: 300),
      Duration durationOfScalingDown = const Duration(milliseconds: 300),
      Duration durationOfLeavingScreenBySwipe = const Duration(milliseconds: 300),
      Curve curveScaleUpAnim = Curves.easeIn,
      Curve curveScaleDownAnim = Curves.easeOut,
      Curve curveTranslateAnim = Curves.easeInOut,
      bool safeAreaTopEnabled = true,
      bool safeAreaBottomEnabled = true,
      bool safeAreaLeftEnabled = true,
      bool safeAreaRightEnabled = true,
    }) {
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => SafeArea(
      top: safeAreaTopEnabled,
      bottom: safeAreaBottomEnabled,
      left: safeAreaLeftEnabled,
      right: safeAreaRightEnabled,
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.up,
            onDismissed: (direction) {
              overlayEntry.remove();
            },
            child: GestureDetector(
              onTap: onTap,
              child: child,
            ),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context)!.insert(overlayEntry);

  Future.delayed(durationOfStayingOnScreen, () {
    overlayEntry.remove();
  });
}

class DisAlertBanner extends StatefulWidget {
  final String message;
  final Color color;
  final IconData icon;

  const DisAlertBanner({
    Key? key,
    required this.message,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  _DisAlertBannerState createState() => _DisAlertBannerState();
}

class _DisAlertBannerState extends State<DisAlertBanner> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCustomAlertBanner(
        context,
            () {
          setState(() {
            _isVisible = false;
          });
        },
        _buildBannerContent(),
      );
    });
  }

  bool _isVisible = true;

  Widget _buildBannerContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widget.color,
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: DisColors.white),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                widget.message,
                style: const TextStyle(color: DisColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // The banner will be shown using showCustomAlertBanner
  }
}