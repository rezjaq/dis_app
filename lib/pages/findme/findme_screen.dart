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
  bool _isSearching = false; // Toggle search view

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> contents = [
      'assets/images/dummies/content.jpg',
      'assets/images/dummies/dummy_1.jpg',
      'assets/images/dummies/dummy_2.jpg',
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
                                        hintText: 'Search Creator',
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
                        itemCount: contents.length * 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print('Index: {$index}');
                            },
                            child: Container(
                              child: Expanded(
                                child: Image.asset(contents[index % 3], fit: BoxFit.cover,),
                              ),
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
                        itemCount: contents.length * 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print('Index: {$index}');
                            },
                            child: Container(
                              child: Expanded(
                                child: Image.asset(contents[index % 3], fit: BoxFit.cover,),
                              ),
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
                        itemCount: contents.length * 2,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print('Index: {$index}');
                            },
                            child: Container(
                              child: Expanded(
                                child: Image.asset(contents[index % 3], fit: BoxFit.cover,),
                              ),
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
