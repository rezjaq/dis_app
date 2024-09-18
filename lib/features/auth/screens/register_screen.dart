import 'package:flutter/material.dart';
import 'package:dis_app/utils/colors.dart';
import 'package:dis_app/utils/sizes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                color: DisColors.primary,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: DisSizes.md,
            right: DisSizes.md,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: DisSizes.md),
              color: DisColors.white,
              child: Form(
                key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: DisSizes.md),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Sign Up", style: TextStyle(fontSize: DisSizes.fontSizeXl, fontWeight: FontWeight.bold)),
                            const SizedBox(height: DisSizes.xs),
                            const Text("Discover Your Facial Expressions", style: TextStyle(fontSize: DisSizes.fontSizeSm, color: DisColors.darkGrey)),
                          ],
                        ),
                        const SizedBox(height: DisSizes.md),
                        Column(

                        ),
                      ],
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.8, size.width * 0.5, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.9, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}