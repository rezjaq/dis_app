import 'package:dis_app/common/widgets/textFormField.dart';
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

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

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
              decoration: BoxDecoration(
                color: DisColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: DisColors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: DisSizes.xl),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DisTextFormField(
                              labelText: "Name",
                              hintText: "Enter your name",
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            DisTextFormField(
                              labelText: "Email",
                              hintText: "Enter your email",
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            DisTextFormField(
                                labelText: "Phone",
                                hintText: "Enter your phone number",
                                controller: _phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Phone number is required";
                                  }
                                  return null;
                                }
                            ),
                            const SizedBox(height: 16),
                            DisTextFormField(
                              labelText: "Password",
                              hintText: "Enter your password",
                              obscureText: true,
                              showPasswordToggle: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            DisTextFormField(
                              labelText: "Confirm Password",
                              hintText: "Re-enter your password",
                              obscureText: true,
                              showPasswordToggle: true,
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm Password is required";
                                }
                                if (value != _passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: DisSizes.xl),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: DisSizes.lg, vertical: 12)),
                              backgroundColor: MaterialStateProperty.all(DisColors.primary),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              minimumSize: MaterialStateProperty.all(Size(double.infinity, 0)),
                            ),
                            child: const Text("Sign Up", style: TextStyle(fontSize: DisSizes.fontSizeMd, color: DisColors.black, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: DisSizes.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? ", style: TextStyle(fontSize: DisSizes.fontSizeSm, color: DisColors.darkGrey)),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Sign In", style: TextStyle(fontSize: DisSizes.fontSizeSm, color: DisColors.primary)),
                            ),
                          ],
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