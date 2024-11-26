import 'package:dis_app/blocs/user/user_bloc.dart';
import 'package:dis_app/blocs/user/user_event.dart';
import 'package:dis_app/blocs/user/user_state.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController(text: '******'); // Default value

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  
  String? _url;

  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(userController: UserController());
    _userBloc.add(UserGetEvent());
    _userBloc.stream.listen((state) {
      print("Current state: $state");
      if (state is UserSuccess && state.data != null) {
        print("User data received: ${state.data}");
        setState(() {
          _nameController.text = state.data?['name'] ?? '';
          _emailController.text = state.data?['email'] ?? '';
          _usernameController.text = state.data?['username'] ?? '';
          _phoneController.text = state.data?['phone'] ?? '';
          _url = state.data?['photo'] ?? null;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: DisColors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DisColors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: DisColors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false, // Allow scroll when keyboard appears
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DisSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: DisSizes.md),
                    // Profile Picture with edit icon
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _url != null ? NetworkImage(_url!) : AssetImage('assets/images/dummies/content.jpg'),
                        ),
                        CircleAvatar(
                          backgroundColor: DisColors.primary,
                          radius: 18,
                          child: const Icon(
                            Icons.edit,
                            color: DisColors.black,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DisSizes.md),
                    // Name Field
                    _buildTextFormField(_nameController, 'Name', _nameFocusNode),
                    const SizedBox(height: DisSizes.md),
                    // Email Field
                    _buildTextFormField(_emailController, 'Email', _emailFocusNode),
                    const SizedBox(height: DisSizes.md),
                    // Username Field
                    _buildTextFormField(_usernameController, 'Username', _usernameFocusNode),
                    const SizedBox(height: DisSizes.md),
                    // Phone Number Field
                    _buildTextFormField(_phoneController, 'Phone Number', _phoneFocusNode),
                    const SizedBox(height: DisSizes.md),
                    // Password Field with Change Password button
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            _passwordController,
                            'Password',
                            _passwordFocusNode,
                            obscureText: true,
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(width: DisSizes.md),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/change-password');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DisColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: DisSizes.md, vertical: DisSizes.md),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(DisSizes.borderRadiusMd),
                            ),
                          ),
                          child: const Text(
                            'Change Password',
                            style: TextStyle(color: DisColors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DisSizes.lg),
                    // Log Out Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          _showLogoutConfirmationDialog(context);
                        },
                        icon: const Icon(Icons.logout, color: DisColors.error),
                        label: const Text(
                          'Log Out',
                          style: TextStyle(color: DisColors.error),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Save Profile Button
            Padding(
              padding: const EdgeInsets.all(DisSizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showSaveConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(DisSizes.md),
                        backgroundColor: DisColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(DisSizes.borderRadiusMd),
                        ),
                      ),
                      child: const Text(
                        'Save Profile',
                        style: TextStyle(color: DisColors.black),
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

  // Method to build TextFormField with focus border color
  Widget _buildTextFormField(
      TextEditingController controller, String labelText, FocusNode focusNode,
      {bool obscureText = false, bool readOnly = false}) {
    return Focus(
      focusNode: focusNode,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly, // Add read-only property
        decoration: InputDecoration(
          labelText: labelText,
          // Use DisColors for the border colors
          border: OutlineInputBorder(
            borderSide: BorderSide(color: DisColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DisColors.primary, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: DisSizes.md, vertical: DisSizes.sm),
          // Adjust label style to use DisColors for primary text color
          labelStyle: TextStyle(
            color: focusNode.hasFocus ? DisColors.textPrimary : DisColors.darkerGrey,
          ),
          // Background color when not focused
          fillColor: DisColors.lightGrey,
          filled: true,
        ),
        onTap: () {
          setState(() {}); // Trigger rebuild
        },
      ),
    );
  }

  // Show logout confirmation dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Logout?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: const Text(
            'Are you sure want to logout?',
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DisSizes.borderRadiusMd),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: DisSizes.ll),
          actionsPadding: const EdgeInsets.only(bottom: 0), // Adjust bottom padding
          actions: [
            Column(
              children: [
                // Horizontal Divider (Yellow Line)
                Container(
                  width: double.infinity,
                  height: 1,
                  color: DisColors.primary, // Yellow divider color
                ),
                Row(
                  children: [
                    // Cancel Button with Border
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: DisColors.grey),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                    ),
                    // Ok Button with Border
                    Expanded(
                      child: Container(
                        child: TextButton(
                          onPressed: () {
                            _userBloc.add(UserLogoutEvent());
                            _userBloc.stream.listen((state) {
                              if (state is UserSuccess) {
                                Navigator.pushReplacementNamed(context, '/login');
                              }
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('Ok'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Show save confirmation dialog
  void _showSaveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Profile?'),
          content: const Text('Are you sure you want to save your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _userBloc.add(UserUpdateEvent(
                  name: _nameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}