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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: DisSizes.md, vertical: DisHelperFunctions.screenHeight(context) * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Expanded(
                child: SvgPicture.asset(
                  'assets/images/logofindme.svg',
                  fit: BoxFit.contain,
                  color: DisColors.white,
                  width: DisHelperFunctions.screenWidth(context) * 0.3,
                  height: DisHelperFunctions.screenWidth(context) * 0.3,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Expanded(
                  child: SvgPicture.asset(
                    'assets/images/welcome.svg',
                    height: DisHelperFunctions.screenHeight(context) * 0.4,
                  ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: DisHelperFunctions.screenWidth(context) * 0.9, // Lek pingin diganti
              child: Text(
                'Transform Your Moments into Masterpiece with FindMe',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: DisColors.darkerGrey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DisSizes.lg),
              child: Container(
                width: double.infinity,
                height: DisHelperFunctions.screenHeight(context) * 0.1,
                child: Stack(
                  children: [
                    Positioned(
                      left: DisHelperFunctions.screenWidth(context) * 0.35,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginSelected = false;
                          });
                          Future.delayed(Duration(milliseconds: 50), () {
                            Navigator.pushNamed(context, '/register');
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: DisSizes.md, horizontal: DisSizes.sm),
                          width: DisHelperFunctions.screenWidth(context) * 0.425,
                          decoration: BoxDecoration(
                            color: isLoginSelected ? DisColors.darkerGrey.withOpacity(0.8) : DisColors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: isLoginSelected ? DisColors.white : DisColors.darkerGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginSelected = true;
                          });
                          Future.delayed(Duration(milliseconds: 50), () {
                            Navigator.pushNamed(context, '/login');
                          });
                        },
                        child: Container(
                          width: DisHelperFunctions.screenWidth(context) * 0.425,
                          padding: EdgeInsets.symmetric(vertical: DisSizes.md, horizontal: DisSizes.sm),
                          decoration: BoxDecoration(
                            color: isLoginSelected ? DisColors.white : DisColors.darkerGrey,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: isLoginSelected ? DisColors.darkerGrey : DisColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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