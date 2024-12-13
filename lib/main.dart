import 'package:camera/camera.dart';
import 'package:dis_app/blocs/chart/chart_bloc.dart';
import 'package:dis_app/blocs/displayPhoto/displayPhoto_bloc.dart';
import 'package:dis_app/blocs/listFace/listFace_bloc.dart';
import 'package:dis_app/blocs/photo/photo_bloc.dart';
import 'package:dis_app/blocs/searchFace/searchFace_bloc.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/blocs/user/user_bloc.dart';
import 'package:dis_app/controllers/face_controller.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/models/user_model.dart';
import 'package:dis_app/pages/account/account_screen.dart';
import 'package:dis_app/pages/auth/forgetPass_screen.dart';
import 'package:dis_app/pages/auth/otp_screen.dart';
import 'package:dis_app/pages/auth/register_screen.dart';
import 'package:dis_app/pages/auth/login_screen.dart';
import 'package:dis_app/pages/bank/bank_screen.dart';
import 'package:dis_app/pages/bank/listBank_screen.dart';
import 'package:dis_app/pages/splash_screen.dart';
import 'package:dis_app/pages/transaction/balance_screen.dart';
import 'package:dis_app/pages/transaction/payment_page.dart';
import 'package:dis_app/pages/transaction/transaction_screen.dart';
import 'package:dis_app/pages/transaction/withdrawal_history_screen.dart';
import 'package:dis_app/pages/welcome_screen.dart';
import 'package:dis_app/pages/account/change_profile.dart';
import 'package:dis_app/pages/account/changePass_screen.dart';
import 'package:dis_app/pages/home_screen.dart';
import 'package:dis_app/pages/camera_screen.dart';
import 'package:dis_app/pages/withdraw/withdraw_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'controllers/photo_controller.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;

  final faceController = FaceController();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc(userController: UserController())),
        BlocProvider(
            create: (_) => PhotoBloc(photoController: PhotoController())),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (context) => ListFaceBloc()),
        BlocProvider(
            create: (context) =>
                SearchFaceBloc(faceController)..add(InitializeCameraEvent())),
        BlocProvider(create: (_) => DisplayPhotoBloc()),
      ],
      child: MyApp(),
    ),
  );
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
        '/change-profile': (context) => EditProfileScreen(
              user: ModalRoute.of(context)!.settings.arguments as User,
            ),
        '/change-password': (context) => ChangePasswordScreen(),
        '/forget-password': (context) => ForgetPasswordScreen(),
        '/otp-screen': (context) => OtpVerificationScreen(),
        '/home': (context) => BaseScreen(cameras: _cameras),
        '/camera': (context) => CameraScreen(cameras: _cameras),
        '/transaction': (context) => TransactionScreen(),
        '/balance': (context) => BalanceScreen(),
        '/bank-account': (context) => BankScreen(),
        // '/BankAccountListScreen': (context) => BankAccountListScreen(),
        '/withdraw': (context) => WithdrawScreen(),
        '/history-withdrawal': (context) => WithdrawalHistoryScreen(),
        '/payment': (context) => PaymentPage(),
      },
    );
  }
}
