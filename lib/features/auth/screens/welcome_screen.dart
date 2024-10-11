import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dis_app/utils/constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Logo
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Column(
                children: [
                  Icon(Icons.ac_unit, size: 40, color: Colors.brown),
                  SizedBox(height: 8),
                  Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),

            // Illustration and Welcome Text
            Column(
              children: [
                SvgPicture.asset(
                  'assets/image/welcome.svg',
                  height: 315,
                ),
                SizedBox(height: 32),
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown[600],
                  ),
                ),
                Text(
                  'Emotion Detect',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown[400],
                    ),
                  ),
                ),
              ],
            ),

            // Switch-like Buttons with Animation
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 32.0),
              child: Container(
                height: 50, // Button height
                decoration: BoxDecoration(
                  color: DisColors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    // Animated background for the selected button
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      left: isLoginSelected
                          ? 0
                          : MediaQuery.of(context).size.width * 0.5 - 40,
                      right: isLoginSelected
                          ? MediaQuery.of(context).size.width * 0.5 - 40
                          : 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: DisColors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5 - 40,
                      ),
                    ),

                    Row(
                      children: [
                        // Login Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoginSelected = true;
                              });
                              Future.delayed(Duration(milliseconds: 300), () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: isLoginSelected
                                      ? DisColors.white
                                      : DisColors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Sign-up Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoginSelected = false;
                              });
                              // Menunggu animasi selesai sebelum pindah halaman
                              Future.delayed(Duration(milliseconds: 300), () {
                                Navigator.pushReplacementNamed(
                                    context, '/register');
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Sign-up',
                                style: TextStyle(
                                  color: isLoginSelected
                                      ? DisColors.black
                                      : DisColors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
