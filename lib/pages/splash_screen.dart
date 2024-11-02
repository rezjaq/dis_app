import 'dart:async';
import 'package:dis_app/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

class FindMeSplashScreen extends StatefulWidget {
  @override
  _FindMeSplashScreenState createState() => _FindMeSplashScreenState();
}

class _FindMeSplashScreenState extends State<FindMeSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _spaceAnimation;
  late Animation<double> _iTranslationAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _textScaleAnimation;
  bool _showI = false;

  // For the background wave animation
  late Animation<double> _backgroundAnimation;
  bool _startWaveAnimation = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _spaceAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _iTranslationAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _textScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    // For background animation
    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    Timer(Duration(seconds: 1), () {
      setState(() {
        _showI = true;
      });

      // Start wave animation after the 'i' appears with delay
      Timer(Duration(seconds: 1), () {
        setState(() {
          _startWaveAnimation = true; // Start wave animation
        });

        // Navigate to WelcomeScreen after a delay
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ),
          );
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedText() {
    return AnimatedBuilder(
      animation: _spaceAnimation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _textScaleAnimation,
              child: Text(
                'F',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: DisColors.black,
                ),
              ),
            ),
            SizedBox(width: _spaceAnimation.value),
            if (_showI)
              FadeTransition(
                opacity: _opacityAnimation,
                child: Transform.translate(
                  offset: Offset(_iTranslationAnimation.value, 0),
                  child: ScaleTransition(
                    scale: _textScaleAnimation,
                    child: Text(
                      'i',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: DisColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(width: _spaceAnimation.value),
            ScaleTransition(
              scale: _textScaleAnimation,
              child: Text(
                'N',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: DisColors.black,
                ),
              ),
            ),
            SizedBox(width: _spaceAnimation.value),
            ScaleTransition(
              scale: _textScaleAnimation,
              child: Text(
                'D',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: DisColors.black,
                ),
              ),
            ),
            SizedBox(width: _spaceAnimation.value),
            ScaleTransition(
              scale: _textScaleAnimation,
              child: Text(
                'M',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: DisColors.black,
                ),
              ),
            ),
            SizedBox(width: _spaceAnimation.value),
            ScaleTransition(
              scale: _textScaleAnimation,
              child: Text(
                'E',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: DisColors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background wave animation
          AnimatedBuilder(
            animation: _backgroundAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: BackgroundPainter(_backgroundAnimation.value),
                child:
                    Container(), // You can leave this empty or size as per your need
              );
            },
          ),
          // Centered text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// BackgroundPainter for the wave effect
class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();

    // Draw background
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw wave based on animation value
    path.moveTo(0, size.height); // Start from the bottom
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(size.width, size.height * (1 - animationValue));
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * (0.55 - animationValue * 0.55),
      0,
      size.height * (1 - animationValue),
    );
    path.lineTo(0, size.height);
    path.close();

    paint.color = DisColors.primary;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Always repaint for animation
  }
}
