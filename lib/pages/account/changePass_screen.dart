import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _currentPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(color: DisColors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: DisColors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DisColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(DisSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: DisSizes.ll),
                  // Current Password Field
                  const Text('Current Password'),
                  const SizedBox(height: 10),
                  _buildTextFormField(_currentPasswordController,
                      'Enter your current password', _currentPasswordFocusNode,
                      obscureText: true),
                  const SizedBox(height: DisSizes.ll),
                  // New Password Field
                  const Text('New Password'),
                  const SizedBox(height: 10),
                  _buildTextFormField(_newPasswordController,
                      'Enter your new password', _newPasswordFocusNode,
                      obscureText: true),
                  const SizedBox(height: DisSizes.ll),
                  // New Password Confirmation Field
                  const Text('New Password Confirmation'),
                  const SizedBox(height: 10),
                  _buildTextFormField(_confirmPasswordController,
                      'Re-type your new password', _confirmPasswordFocusNode,
                      obscureText: true),
                ],
              ),
            ),
          ),
          // Save Password Button
          Padding(
            padding: const EdgeInsets.all(DisSizes.md),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/change-profile');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(DisSizes.md),
                  backgroundColor: DisColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DisSizes.borderRadiusMd),
                  ),
                ),
                child: const Text(
                  'Save Password',
                  style: TextStyle(color: DisColors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String labelText, FocusNode focusNode,
      {bool obscureText = false}) {
    return Focus(
      focusNode: focusNode,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: labelText,
          filled: true,
          fillColor: DisColors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DisSizes.borderRadiusMd),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: DisSizes.md, vertical: DisSizes.sm),
        ),
        onTap: () {
          setState(() {});
        },
      ),
    );
  }
}
