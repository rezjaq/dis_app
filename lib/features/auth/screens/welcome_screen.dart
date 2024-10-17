import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dis_app/utils/constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoginSelected = true; // Track the selected button

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
              padding: const EdgeInsets.only(top: 65.0),
              child: Column(
                children: [
                  // Container for logo.svg with customizable width and height
                  Container(
                    width: 150, // You can change this
                    height: 150, // You can change this
                    child: SvgPicture.asset(
                      'assets/images/logofindme.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),

            // Illustration and Welcome Text
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/welcome.svg',
                  height: 315,
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Transform Your Moments into Masterpiece with FindMe',
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
                height: 65, // Button height
                decoration: BoxDecoration(
                  color: Colors
                      .grey[300], // Background color for the switch container
                  borderRadius: BorderRadius.circular(30), // Rounded container
                ),
                child: Stack(
                  children: [
                    // Animated background for the selected button
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: isLoginSelected
                          ? 0
                          : MediaQuery.of(context).size.width * 0.5 - 40,
                      right: isLoginSelected
                          ? MediaQuery.of(context).size.width * 0.5 - 40
                          : 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: Colors.black, // Active background color
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 65,
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
                              // Menunggu animasi selesai sebelum pindah halaman
                              Future.delayed(Duration(milliseconds: 50), () {
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
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 22,
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
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 22,
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
