import 'package:dis_app/pages/findme/ListFaceScreen.dart';
import 'package:dis_app/pages/findme/chart_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FindMeScreen extends StatefulWidget {
  const FindMeScreen({Key? key}) : super(key: key);

  @override
  _FindMeScreenState createState() => _FindMeScreenState();
}

class _FindMeScreenState extends State<FindMeScreen> {
  int _selectedIndex = 0;
  bool _isSearching = false;
  String _searchText = '';
  final List<String> _allContents = [
    'content.jpg',
    'dummy_1.jpg',
    'dummy_2.jpg'
  ];
  List<String> _filteredContents = [];
  List<String> _favorites = [];
  List<String> _collection = [];
  final List<String> _selectedImagesForCart = [];

  get imagePath => null;

  @override
  void initState() {
    super.initState();
    _filteredContents = [];
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      _searchText = text;
      _filteredContents = text.isNotEmpty
          ? _allContents
              .where((fileName) => fileName.contains(_searchText))
              .toList()
          : [];
    });
  }

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: DisColors.primary),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchText = '';
              _filteredContents = [];
            });
          },
        ),
        Expanded(
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              border: Border.all(color: DisColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onChanged: _onSearchTextChanged,
                    decoration: InputDecoration(
                      hintText: 'Search by file name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 12),
                    ),
                  ),
                ),
                Icon(Icons.search, color: DisColors.primary),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.filter_list, color: DisColors.primary),
          onPressed: () {
            // Add filter action here
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return _isSearching
        ? _buildSearchBar()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Me',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Find your photo here',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search, color: DisColors.primary),
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
                            builder: (context) => ShoppingCartScreen()),
                      );
                    },
                    icon: Icon(Icons.shopping_cart, color: DisColors.primary),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ListFaceScreen(imagePath: '')),
                      );
                    },
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
          );
  }

  @override
  Widget build(BuildContext context) {
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
                child: _buildHeader(),
              ),
              if (!_isSearching)
                TabBar(
                  labelColor: DisColors.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: DisColors.primary,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Favorite'),
                    Tab(text: 'Collection'),
                  ],
                ),
              Expanded(
                child: _isSearching
                    ? _buildSearchResults(_filteredContents)
                    : TabBarView(
                        children: [
                          _buildGridContent(_allContents),
                          _buildGridContent(_favorites),
                          _buildGridContent(_collection),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<String> contents) {
    if (contents.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: contents.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            'assets/images/dummies/${contents[index]}',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: const Text('Babel Run Action 2024',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Row(
            children: [
              Icon(Icons.location_on, color: Colors.green, size: 16),
              SizedBox(width: 4),
              Text('FotoTree'),
            ],
          ),
          onTap: () {
            print('Selected: ${contents[index]}');
          },
        );
      },
    );
  }

  Widget _buildGridContent(List<String> contents) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: contents.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _showFullImage(context, contents[index]);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/dummies/${contents[index]}',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  void _showFullImage(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/dummies/$image',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (!_favorites.contains(image)) {
                              _favorites.add(image);
                            }
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Iya"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _collection.remove(image);
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Bukan"),
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color: DisColors.white),
                        onPressed: () {
                          setState(() {
                            if (!_favorites.contains(image)) {
                              _favorites.add(image);
                            }
                            ShoppingCartScreen.selectedImage =
                                'assets/images/dummies/$image';
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
