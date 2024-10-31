import 'package:dis_app/pages/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2),
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/forget-password.svg',
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: DisColors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please enter the phone number we will send the OTP to this phone number.',
                    style: TextStyle(
                      fontSize: 16,
                      color: DisColors.darkerGrey,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter your phone number',
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        await Future.delayed(Duration(seconds: 2));

                        setState(() {
                          isLoading = false;
                        });

                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.scale,
                            alignment: Alignment.center,
                            child: OtpVerificationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DisColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 16,
                          color: DisColors.black,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
            if (isLoading)
              Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: DisColors.primary,
                  size: 50,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
