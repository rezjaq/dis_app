import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/pages/welcome_screen.dart';

void main() => runApp(FindMeSplashScreen());

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

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Duration for animation
    );

    // Space animation to control the gap between letters
    _spaceAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Translation animation for moving the "i" from behind
    _iTranslationAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Opacity animation for fading in the "i"
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    // Text scale animation for a popping effect
    _textScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    // Start the space animation
    _controller.forward();

    // Timer to trigger showing the "i" after 1 second
    Timer(Duration(seconds: 1), () {
      setState(() {
        _showI = true; // Show the "i"
      });

      // Timer to navigate to the welcome screen after the animation finishes
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(), // Navigate to welcome screen
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: DisColors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated text
              AnimatedBuilder(
                animation: _spaceAnimation,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Letter F
                      ScaleTransition(
                        scale: _textScaleAnimation,
                        child: Text(
                          'F',
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: DisColors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(5.0, 5.0),
                              ),
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(-3.0, -3.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Animate space between F and "i"
                      SizedBox(width: _spaceAnimation.value),
                      // Conditionally show "i" when animation triggers
                      if (_showI)
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: Transform.translate(
                            offset: Offset(_iTranslationAnimation.value, 0),
                            child: ScaleTransition(
                              scale: _textScaleAnimation,
                              child: Text(
                                'i', // The letter "i"
                                style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: DisColors
                                      .textPrimary, // Primary color for "i"
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: DisColors.grey,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: DisColors.grey,
                                      offset: Offset(-3.0, -3.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Animate space between "i" and N
                      SizedBox(width: _spaceAnimation.value),
                      // Letter N
                      ScaleTransition(
                        scale: _textScaleAnimation,
                        child: Text(
                          'N',
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: DisColors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(5.0, 5.0),
                              ),
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(-3.0, -3.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Animate space between N and D
                      SizedBox(width: _spaceAnimation.value),
                      // Letter D
                      ScaleTransition(
                        scale: _textScaleAnimation,
                        child: Text(
                          'D',
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: DisColors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(5.0, 5.0),
                              ),
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(-3.0, -3.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Animate space between D and M
                      SizedBox(width: _spaceAnimation.value),
                      // Letter M
                      ScaleTransition(
                        scale: _textScaleAnimation,
                        child: Text(
                          'M',
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: DisColors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(5.0, 5.0),
                              ),
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(-3.0, -3.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Animate space between M and E
                      SizedBox(width: _spaceAnimation.value),
                      // Letter E
                      ScaleTransition(
                        scale: _textScaleAnimation,
                        child: Text(
                          'E',
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: DisColors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(5.0, 5.0),
                              ),
                              Shadow(
                                blurRadius: 10.0,
                                color: DisColors.grey,
                                offset: Offset(-3.0, -3.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
