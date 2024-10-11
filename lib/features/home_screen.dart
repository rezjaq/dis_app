import 'package:camera/camera.dart';
import 'package:dis_app/features/auth/screens/account_screen.dart';
import 'package:dis_app/features/camera_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const BaseScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  List<Widget> get _widgetOptions => <Widget>[
    HomeScreen(),
    CameraScreen(cameras: widget.cameras),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: DisSizes.fontSizeXs),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: DisSizes.fontSizeXs),
        fixedColor: DisColors.primary,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            activeIcon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}