import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FindMeScreen extends StatefulWidget {
  const FindMeScreen({Key? key}) : super(key: key);

  @override
  _FindMeScreenState createState() => _FindMeScreenState();
}

class _FindMeScreenState extends State<FindMeScreen> {
  int _selectedIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of 33 colors
    final List<Color> colors = [
      Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange,
      Colors.purple, Colors.pink, Colors.brown, Colors.cyan, Colors.lime,
      Colors.indigo, Colors.teal, Colors.amber, Colors.deepOrange, Colors.deepPurple,
      Colors.lightBlue, Colors.lightGreen, Colors.limeAccent, Colors.orangeAccent, Colors.pinkAccent,
      Colors.purpleAccent, Colors.redAccent, Colors.tealAccent, Colors.yellowAccent, Colors.blueAccent,
      Colors.greenAccent, Colors.indigoAccent, Colors.cyanAccent, Colors.amberAccent, Colors.brown[300]!,
      Colors.grey, Colors.blueGrey, Colors.black,
    ];

    final List<Color> favoriteColors = [
      Colors.indigo, Colors.teal, Colors.amber, Colors.deepOrange, Colors.deepPurple,
      Colors.lightBlue, Colors.lightGreen, Colors.limeAccent, Colors.orangeAccent, Colors.pinkAccent,
    ];

    final List<Color> collectionColors = [
      Colors.purpleAccent, Colors.redAccent, Colors.tealAccent, Colors.yellowAccent, Colors.blueAccent,
      Colors.greenAccent, Colors.indigoAccent, Colors.cyanAccent, Colors.amberAccent, Colors.brown[300]!,
    ];

    return Scaffold(
      backgroundColor: DisColors.white,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (context, contraints) {
              double screenWidth = contraints.maxWidth;
              double screenHeight = contraints.maxHeight;
              return Stack(
                children: [
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: DisColors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Find Me',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Find your photo here',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.search,
                                      color: DisColors.primary,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.shopping_cart, color: DisColors.primary),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      'assets/icons/robot_2.svg',
                                      color: DisColors.primary,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(onPressed: () => _onButtonPressed(0), child: Text("All", style: TextStyle(color: _selectedIndex == 0 ? DisColors.primary : DisColors.black))),
                              TextButton(onPressed: () => _onButtonPressed(1) , child: Text("Favorites", style: TextStyle(color: _selectedIndex == 1 ? DisColors.primary : DisColors.black))),
                              TextButton(onPressed: () => _onButtonPressed(2), child: Text("Collections", style: TextStyle(color: _selectedIndex == 2 ? DisColors.primary : DisColors.black))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.125,
                    child: Padding(
                      padding: const EdgeInsets.all(DisSizes.xs),
                      child: Container(
                        width: screenWidth - 2 * DisSizes.xs,
                        height: screenHeight,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            mainAxisExtent: screenHeight * 0.25,
                          ),
                          itemCount: _selectedIndex == 0 ? colors.length : _selectedIndex == 1 ? favoriteColors.length : collectionColors.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('Color: ${_selectedIndex == 0 ? colors[index] : _selectedIndex == 1 ? favoriteColors[index] : collectionColors[index]}');
                              },
                              child: Container(
                                color: _selectedIndex == 0 ? colors[index] : _selectedIndex == 1 ? favoriteColors[index] : collectionColors[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}