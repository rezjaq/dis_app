import 'package:camera/camera.dart';
import 'package:dis_app/features/auth/screens/forgetPass_screen.dart';
import 'package:dis_app/features/auth/screens/otp_screen.dart';
import 'package:dis_app/features/auth/screens/register_screen.dart';
import 'package:dis_app/features/auth/screens/login_screen.dart';
import 'package:dis_app/features/auth/screens/welcome_screen.dart';
import 'package:dis_app/features/auth/screens/change_profile.dart';
import 'package:dis_app/features/auth/screens/changePass_screen.dart';
import 'package:dis_app/common/widgets/splash_screen.dart';
import 'package:dis_app/features/home_screen.dart';
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
      home: SplashScreen(),
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/change-profile': (context) => EditProfileScreen(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/forget-screen': (context) => ForgetPasswordScreen(),
        '/otp-screen': (context) => OtpVerificationScreen(),
        '/home': (context) => BaseScreen(
              cameras: _cameras,
            ),
      },
    );
  }
}
