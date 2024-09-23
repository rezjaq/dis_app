import 'package:flutter/material.dart';
import 'package:dis_app/utils/colors.dart';
import 'package:dis_app/utils/sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.primary, // Background
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Logo
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Column(
                children: [
                  Icon(Icons.ac_unit,
                      size: 40, color: Colors.brown), // Placeholder for logo
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

            // Buttons
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.black, // Dark color for the "Login" button
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Sign-in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .white, // Light color for the "Sign-up" button
                        side: BorderSide(
                            color: Colors.black), // Border around the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Sign-up',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
