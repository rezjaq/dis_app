import 'package:camera/camera.dart';
import 'package:dis_app/features/auth/screens/forgetPass_screen.dart';
import 'package:dis_app/features/auth/screens/otp_screen.dart';
import 'package:dis_app/features/auth/screens/register_screen.dart';
import 'package:dis_app/features/auth/screens/login_screen.dart';
import 'package:dis_app/features/auth/screens/welcome_screen.dart';
import 'package:dis_app/features/auth/screens/change_profile.dart';
import 'package:dis_app/features/auth/screens/changePass_screen.dart';
import 'package:dis_app/features/home_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';


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
        '/home': (context) => BaseScreen(cameras: _cameras,),
      },
    );
  }
}

// Splash Screen Widget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animations
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _textAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward().whenComplete(() {
      // Navigate to WelcomeScreen after the animation completes
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: BackgroundPainter(_animation.value),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 240),
                  // zoom and rotate
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(pi * _animation.value)
                      ..scale(1 + 0.5 * _animation.value),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera,
                      size: 120,
                      color: DisColors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Text with animation
                  Opacity(
                    opacity: _textAnimation.value,
                    child: Transform.scale(
                      scale: 1 + 0.2 * _textAnimation.value,
                      child: Text(
                        'FindMe',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Opacity(
                    opacity: _textAnimation.value,
                    child: Transform.scale(
                      scale: 1 + 0.1 * _textAnimation.value,
                      child: Text(
                        'for the best results',
                        style: TextStyle(
                          fontSize: 24,
                          color: DisColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Custom Background Painter with Animation
class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();

    // Latar belakang putih
    paint.color = DisColors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Gelombang kuning dari bawah ke atas
    path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      // Calculate y position based on sine wave to create a wave moving upwards
      final y = size.height * (1 - animationValue) +
          (20 * sin((x / size.width) * (2 * pi) + (pi * animationValue)));
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();

    paint.color = DisColors.primary;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
