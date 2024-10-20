import 'package:camera/camera.dart';
import 'package:dis_app/features/auth/screens/account_screen.dart';
import 'package:dis_app/features/camera_screen.dart';
import 'package:dis_app/features/findme/screens/findme_screen.dart';
import 'package:dis_app/features/photo/models/photo_model.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:io';

class BaseScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const BaseScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  List<Widget> get _widgetOptions => <Widget>[
        HomeScreen(
          cameras: widget.cameras,
        ),
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
          onTap: _onItemTapped,
          backgroundColor:
              _selectedIndex == 0 ? DisColors.black : DisColors.white,
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
          items: const [
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
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomeScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PostPhoto>> _posts = fetchPostPhotos();

  @override
  void initState() {
    super.initState();
  }

  Future<List<PostPhoto>> fetchPostPhotos() async {
    final dir = await getApplicationDocumentsDirectory();
    final jsonFile = File(path.join(dir.path, 'dummies.json'));

    if (await jsonFile.exists()) {
      final jsonString = await jsonFile.readAsString();
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final posts = jsonData['post'] as List<dynamic>;

      // Filter the posts to only include those whose files exist
      List<PostPhoto> existingPosts = [];
      for (var post in posts) {
        final photo = PostPhoto.fromJson(post);
        final file = File(photo.url);
        if (await file.exists()) {
          existingPosts.add(photo);
        }
      }
      return existingPosts;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.black,
      body: Stack(
        children: [
          FutureBuilder<List<PostPhoto>>(
            future: _posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No posts available'));
              } else {
                final post = snapshot.data!;

                // Filter out posts with non-existing files
                final validPosts = post.where((photo) {
                  final file = File(photo.url);
                  return file.existsSync();
                }).toList();

                // Check if there are valid posts to display
                if (validPosts.isEmpty) {
                  return Center(child: Text('No valid photos available'));
                }

                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: validPosts.length,
                  itemBuilder: (context, index) {
                    final photo = validPosts[index];
                    final file =
                        File(photo.url); // This should always exist now
                    return Container(
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.125,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.74,
                              child: Image.file(file, fit: BoxFit.cover),
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
                                    Text("Steve Jobs",
                                        style: TextStyle(
                                            color: DisColors.white,
                                            fontSize: DisSizes.fontSizeSm,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: DisColors.white, width: 1),
                                          borderRadius: BorderRadius.circular(
                                              DisSizes.xs),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: DisSizes.md,
                                              vertical: DisSizes.xs),
                                          child: Text("Follow",
                                              style: TextStyle(
                                                  color: DisColors.white,
                                                  fontSize:
                                                      DisSizes.fontSizeXs)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(photo.description,
                                    style: TextStyle(
                                        color: DisColors.white,
                                        fontSize: DisSizes.fontSizeSm)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: DisColors.white,
                                        size: DisSizes.md),
                                    const SizedBox(width: 4),
                                    Text("Malang, Indonesia",
                                        style: TextStyle(
                                            color: DisColors.white,
                                            fontSize: DisSizes.fontSizeXs)),
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
                                _menuButton(Icons.favorite_border_rounded,
                                    '359', DisColors.white, () {}),
                                const SizedBox(height: 8),
                                _menuButton(Icons.chat_bubble_outline_rounded,
                                    '20', DisColors.white, () {}),
                                const SizedBox(height: 8),
                                _menuButton(Icons.more_horiz_rounded, '',
                                    DisColors.white, () {
                                  _showDialog(context);
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height * 0.05,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(cameras: widget.cameras),
                  ),
                );
              },
              icon: const Icon(Icons.add_a_photo_outlined,
                  color: DisColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Column _menuButton(
      IconData icon, String text, Color color, void Function()? onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 4),
        if (text.isNotEmpty)
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

Future<void> _showDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: AlertDialog(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Options",
                      style: TextStyle(
                        color: DisColors.black,
                        fontSize: DisSizes.fontSizeMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        _dialogOption(Icons.share, "Share Content"),
                        _dialogOption(Icons.report_gmailerrorred_rounded,
                            "Report Content"),
                        _dialogOption(Icons.block_rounded, "Block"),
                      ],
                    ),
                    Divider(color: DisColors.primary, thickness: 1.5),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close',
                          style: TextStyle(color: DisColors.primary)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _dialogOption(IconData icon, String title) {
  return ListTile(
    leading: Icon(icon, color: DisColors.black),
    title: Text(title,
        style:
            TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeSm)),
    onTap: () {},
  );
}
