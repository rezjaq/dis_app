import 'dart:async';
import 'package:dis_app/blocs/auth/auth_bloc.dart';
import 'package:dis_app/blocs/auth/auth_event.dart';
import 'package:dis_app/blocs/auth/auth_state.dart';
import 'package:dis_app/common/widgets/alertBanner.dart';
import 'package:dis_app/common/widgets/textFormField.dart';
import 'package:dis_app/controllers/auth_controller.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:dis_app/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(authController: AuthController()),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              DisHelperFunctions.navigateToRoute(context, '/home');
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    if (state is AuthLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state is AuthSuccess)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                          child: DisAlertBanner(message: state.message, color: DisColors.success, icon: Icons.check_circle)
                      ),
                    if (state is AuthFailure)
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: DisAlertBanner(message: state.message, color: DisColors.error, icon: Icons.error)
                      ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ClipPath(
                        clipper: TopWaveClipper(), // kurva
                        child: Container(
                          height: DisHelperFunctions.screenHeight(context) * 0.5,
                          color: DisColors.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/login.svg',
                                  height: DisHelperFunctions.screenHeight(context) * 0.4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: DisHelperFunctions.screenHeight(context) * 0.3,
                      left: DisSizes.md,
                      right: DisSizes.md,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Title and Description
                              const Text(
                                "Hi, Welcome Back! 👋",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Let's Detect Your Facial Emotion",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Email or Phone Number Field
                              DisTextFormField(
                                  labelText: "Email or Phone Number",
                                  hintText: "Enter your email or phone number",
                                  controller: _emailOrPhoneController,
                                  validator: (value) {
                                    return DisValidator.validateEmpty(value);
                                  }),
                              const SizedBox(height: DisSizes.md),
                              // Password Field
                              DisTextFormField(
                                labelText: "Password",
                                hintText: "Enter your password",
                                obscureText: !_isPasswordVisible,
                                showPasswordToggle: true,
                                controller: _passwordController,
                                validator: (value) {
                                  return DisValidator.validateEmpty(value);
                                },
                              ),
                              const SizedBox(height: DisSizes.md),
                              // Remember Me and Forgot Password Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _rememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            _rememberMe = value ?? false;
                                          });
                                        },
                                      ),
                                      const Text("Remember Me"),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      DisHelperFunctions.navigateToRoute(context, '/forgot-password');
                                    },
                                    child: const Text("Forgot Password?",
                                        style: TextStyle(color: DisColors.error)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: DisSizes.md),
                              // Login Button
                              ElevatedButton(
                                onPressed: () {
                                  // DisHelperFunctions.navigateToRoute(context, '/home'); // If you not connect to API, you can use this code
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      AuthLoginEvent(
                                        emailOrPhone: _emailOrPhoneController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  } // If you connect to API, you can use this code
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: DisColors.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: DisColors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: DisSizes.md),
                              // Sign Up link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account? "),
                                  TextButton(
                                    onPressed: () {
                                      DisHelperFunctions.navigateToRoute(context, '/register');
                                    },
                                    child: const Text("Sign Up",
                                        style: TextStyle(color: DisColors.primary)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.95);
    path.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.85,
      size.width * 0.5,
      size.height * 0.9,
    );
    path.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.95,
      size.width,
      size.height * 0.85,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}