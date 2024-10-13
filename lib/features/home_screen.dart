import 'package:camera/camera.dart';
import 'package:dis_app/features/auth/screens/account_screen.dart';
import 'package:dis_app/features/camera_screen.dart';
import 'package:dis_app/features/findme/screens/findme_screen.dart';
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
    FindMeScreen(),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selectedIndex == 0 ? DisColors.white : DisColors.grey,
              width: 1.0,
            ),
          ),
        ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: _selectedIndex == 0 ? DisColors.black : DisColors.white,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: DisSizes.fontSizeXs,
              color: DisColors.primary,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: DisSizes.fontSizeXs,
              color: _selectedIndex == 0 ? DisColors.white : DisColors.black,
            ),
            unselectedIconTheme: IconThemeData(
              color: _selectedIndex == 0 ? DisColors.white : DisColors.black,
            ),
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
                label: 'FindMe',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                activeIcon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
          )
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];

    return Scaffold(
      backgroundColor: DisColors.black,
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: colors.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.125,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.74,
                          color: colors[index],
                        ),
                      ),
                      Positioned(
                        left: DisSizes.md,
                        bottom: DisSizes.md,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: DisColors.white,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text("Steve Jobs", style: TextStyle(color: DisColors.white, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: DisColors.white, width: 1),
                                      borderRadius: BorderRadius.circular(DisSizes.xs),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: DisSizes.md, vertical: DisSizes.xs),
                                      child: Text("Follow", style: TextStyle(color: DisColors.white, fontSize: DisSizes.fontSizeXs)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text("Malang Run 2024 🎉", style: TextStyle(color: DisColors.white, fontSize: DisSizes.fontSizeSm)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: DisColors.white, size: DisSizes.md),
                                const SizedBox(width: 4),
                                Text("Malang, Indonesia", style: TextStyle(color: DisColors.white, fontSize: DisSizes.fontSizeXs)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: DisSizes.md,
                        bottom: 72,
                        child: Column(
                          children: [
                            _menuButton(Icons.favorite_border_rounded, '359', DisColors.white),
                            const SizedBox(height: 8),
                            _menuButton(Icons.chat_bubble_outline_rounded, '20', DisColors.white),
                            const SizedBox(height: 8),
                            _menuButton(Icons.more_horiz_rounded, '', DisColors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height * 0.05,
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo_outlined, color: DisColors.white)),
          ),
        ],
      ),
    );
  }
}

Widget _menuButton(IconData icon, String text, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton(onPressed: () {}, icon: Icon(icon, color: color)),
      const SizedBox(height: 4),
      if (text == '') const SizedBox(height: 0) else Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    ],
  );
}