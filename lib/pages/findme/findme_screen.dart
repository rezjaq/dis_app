import 'package:dis_app/pages/findme/chart_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FindMeScreen extends StatefulWidget {
  const FindMeScreen({Key? key}) : super(key: key);

  @override
  _FindMeScreenState createState() => _FindMeScreenState();
}

class _FindMeScreenState extends State<FindMeScreen> {
  int _selectedIndex = 0;
  bool _isSearching = false;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.cyan,
      Colors.lime,
      Colors.indigo,
      Colors.teal,
      Colors.amber,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.limeAccent,
      Colors.orangeAccent,
      Colors.pinkAccent,
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.tealAccent,
      Colors.yellowAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.indigoAccent,
      Colors.cyanAccent,
      Colors.amberAccent,
      Colors.brown[300]!,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
    ];

    final List<Color> favoriteColors = [
      Colors.indigo,
      Colors.teal,
      Colors.amber,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.limeAccent,
      Colors.orangeAccent,
      Colors.pinkAccent,
    ];

    final List<Color> collectionColors = [
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.tealAccent,
      Colors.yellowAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.indigoAccent,
      Colors.cyanAccent,
      Colors.amberAccent,
      Colors.brown[300]!,
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: DisColors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: DisColors.white,
                child: _isSearching
                    ? Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: DisColors.primary),
                            onPressed: () {
                              setState(() {
                                _isSearching = false;
                              });
                            },
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: DisColors.primary, width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        hintText: '',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.search, color: DisColors.primary),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.filter_list,
                                color: DisColors.primary),
                            onPressed: () {
                              // Add filter action here
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
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
                            children: [
                              IconButton(
                                icon: Icon(Icons.search,
                                    color: DisColors.primary),
                                onPressed: () {
                                  setState(() {
                                    _isSearching = true;
                                  });
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShoppingCartScreen()),
                                  );
                                },
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: DisColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  //disini
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
              ),
              if (!_isSearching) ...[
                TabBar(
                  labelColor: DisColors.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: DisColors.primary,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Favorite'),
                    Tab(text: 'Collection'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          mainAxisExtent:
                              DisHelperFunctions.screenHeight(context) * 0.25,
                        ),
                        itemCount: colors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print('Color: ${colors[index]}');
                            },
                            child: Container(
                              color: colors[index],
                            ),
                          );
                        },
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          mainAxisExtent:
                              DisHelperFunctions.screenHeight(context) * 0.25,
                        ),
                        itemCount: favoriteColors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print('Color: ${favoriteColors[index]}');
                            },
                            child: Container(
                              color: favoriteColors[index],
                            ),
                          );
                        },
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          mainAxisExtent:
                              DisHelperFunctions.screenHeight(context) * 0.25,
                        ),
                        itemCount: collectionColors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print('Color: ${collectionColors[index]}');
                            },
                            child: Container(
                              color: collectionColors[index],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
