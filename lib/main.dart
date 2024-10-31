import 'package:camera/camera.dart';
import 'package:dis_app/pages/auth/forgetPass_screen.dart';
import 'package:dis_app/pages/auth/otp_screen.dart';
import 'package:dis_app/pages/auth/register_screen.dart';
import 'package:dis_app/pages/auth/login_screen.dart';
import 'package:dis_app/pages/splash_screen.dart';
import 'package:dis_app/pages/welcome_screen.dart';
import 'package:dis_app/pages/account/change_profile.dart';
import 'package:dis_app/pages/account/changePass_screen.dart';
import 'package:dis_app/pages/home_screen.dart';
import 'package:dis_app/pages/camera_screen.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIS App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FindMeSplashScreen(),
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/change-profile': (context) => EditProfileScreen(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/forget-screen': (context) => ForgetPasswordScreen(),
        '/otp-screen': (context) => OtpVerificationScreen(),
        '/home': (context) => BaseScreen(cameras: _cameras),
        '/camera': (context) => CameraScreen(cameras: _cameras),
      },
    );
  }
}
