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
  bool _agreeToTerms = false;

  // Variables for password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
                height: MediaQuery.of(context).size.height * 0.25,
                color: DisColors.primary,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: DisSizes.md,
            right: DisSizes.md,
            child: Container(
              padding: const EdgeInsets.all(DisSizes.md),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign Up Now",
                      style: TextStyle(
                        fontSize: DisSizes.fontSizeXl,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: DisSizes.xs),
                    const Text(
                      "Discover Your Facial Expressions",
                      style: TextStyle(
                        fontSize: DisSizes.fontSizeSm,
                        color: DisColors.darkGrey,
                      ),
                    ),
                    const SizedBox(height: DisSizes.md),
                    // Name Input
                    DisTextFormField(
                        labelText: "Name",
                        hintText: "Enter your name",
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: DisSizes.md),
                    // Email Input
                    DisTextFormField(
                        labelText: "Email",
                        hintText: "Enter your email",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: DisSizes.md),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Enter your phone number",
                              hintStyle: const TextStyle(
                                color: Colors.orange,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Container(
                                width: 70,
                                alignment: Alignment.center,
                                child: const Text(
                                  '+62',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Phone number is required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DisSizes.md),
                    // Password Input with Show Password Icon
                    DisTextFormField(
                        labelText: "Password",
                        hintText: "Enter your password",
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        showPasswordToggle: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: DisSizes.md),
                    // Confirm Password Input with Show Password Icon
                    DisTextFormField(
                        labelText: "Confirm Password",
                        hintText: "Re-enter your password",
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        showPasswordToggle: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password is required";
                          }
                          if (value != _passwordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: DisSizes.md),
                    // Terms & Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value!;
                            });
                          },
                        ),
                        const Text("I agree to the "),
                        GestureDetector(
                          onTap: () {
                            // Handle terms & conditions link tap
                          },
                          child: const Text(
                            "terms & conditions",
                            style: TextStyle(
                              color: Color(0xFF3458FB),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DisSizes.lg),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _agreeToTerms) {
                          // logic disini bang
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DisColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: DisSizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                          color: DisColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: DisSizes.md),
                    // Sign In Redirection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: DisSizes.fontSizeSm,
                            color: DisColors.darkGrey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: DisSizes.fontSizeSm,
                              color: DisColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.8,
        size.width * 0.5, size.height * 0.85);
    path.quadraticBezierTo(
        size.width * 0.65, size.height * 0.9, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
