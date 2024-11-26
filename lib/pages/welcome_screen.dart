import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dis_app/utils/constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoginSelected = false; // Track the selected button

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
            padding: EdgeInsets.only(
                top: DisHelperFunctions.screenHeight(context) * 0.05),
            child: Column(
              children: [
                // Container for logo.svg with customizable width and height
                Container(
                  width: DisHelperFunctions.screenWidth(context) *
                      0.4, // Adjusted width
                  height: DisHelperFunctions.screenWidth(context) *
                      0.4, // Adjusted height
                  child: SvgPicture.asset(
                    'assets/images/logofindme.svg',
                    fit: BoxFit.contain,
                    color: DisColors.white,
                  ),
                ),
                SizedBox(
                    height: DisHelperFunctions.screenHeight(context) * 0.01),
              ],
            ),
          ),

          // Illustration and Welcome Text
          Column(
            children: [
              SvgPicture.asset(
                'assets/images/welcome.svg',
                height: DisHelperFunctions.screenHeight(context) *
                    0.4, // Adjusted height
              ),
              SizedBox(height: DisHelperFunctions.screenHeight(context) * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DisHelperFunctions.screenWidth(context) * 0.1),
                child: Text(
                  'Transform Your Moments into Masterpiece with FindMe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: DisHelperFunctions.screenWidth(context) *
                        0.04, // Adjusted font size
                    color: Colors.brown[400],
                  ),
                ),
              ),
            ],
          ),

          // Switch-like Buttons with Animation
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: DisHelperFunctions.screenWidth(context) * 0.1,
                vertical: DisHelperFunctions.screenHeight(context) * 0.04),
            child: Container(
              height: DisHelperFunctions.screenHeight(context) *
                  0.08, // Adjusted height
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
                        : DisHelperFunctions.screenWidth(context) * 0.5 -
                            DisHelperFunctions.screenWidth(context) * 0.1,
                    right: isLoginSelected
                        ? DisHelperFunctions.screenWidth(context) * 0.5 -
                            DisHelperFunctions.screenWidth(context) * 0.1
                        : 0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 50),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.black, // Active background color
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: DisHelperFunctions.screenHeight(context) * 0.08,
                      width: DisHelperFunctions.screenWidth(context) * 0.5 -
                          DisHelperFunctions.screenWidth(context) * 0.1,
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
                              DisHelperFunctions.navigateToRoute(
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
                                fontSize:
                                    DisSizes.fontSizeXl, // Adjusted font size
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
                              DisHelperFunctions.navigateToRoute(
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
                                fontSize:
                                    DisSizes.fontSizeXl, // Adjusted font size
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
      )),
    );
  }
}
