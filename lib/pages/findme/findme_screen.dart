import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dis_app/blocs/chart/chart_bloc.dart';
import 'package:dis_app/blocs/chart/chart_event.dart';
import 'package:dis_app/blocs/photo/photo_bloc.dart';
import 'package:dis_app/controllers/photo_controller.dart';
import 'package:dis_app/models/photo_model.dart';
import 'package:dis_app/pages/findme/ListFaceScreen.dart';
import 'package:dis_app/pages/findme/chart_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import '../../blocs/photo/photo_event.dart';
import '../../blocs/photo/photo_state.dart';
import '../../utils/constants/blank_findme.dart';

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
                            builder: (context) => ListFaceScreen(
                                  imagePath: '',
                                  matchedFaces: [],
                                  userId: '',
                                )),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => PhotoBloc(photoController: PhotoController())
              ..add(FindmePhotoEvent())),
      ],
      child: DefaultTabController(
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
                            // Tab "All"
                            BlocBuilder<PhotoBloc, PhotoState>(
                              builder: (context, state) {
                                if (state is PhotoLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is FindmeSuccess) {
                                  if (state.all != null) {
                                    final allPhotos =
                                        (state.all!['data'] as List)
                                            .map((photo) =>
                                                SellPhoto.fromJson(photo))
                                            .toList();

                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        context
                                            .read<PhotoBloc>()
                                            .add(FindmePhotoEvent());
                                      },
                                      child: allPhotos.isNotEmpty
                                          ? _buildGridContent(allPhotos,
                                              activeTab: "All")
                                          : ListView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.8,
                                                  child: const Center(
                                                    child: DisBlankFindMe(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    );
                                  }
                                }

                                return RefreshIndicator(
                                  onRefresh: () async {
                                    context
                                        .read<PhotoBloc>()
                                        .add(FindmePhotoEvent());
                                  },
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: const Center(
                                          child: DisBlankFindMe(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            // Tab "Favorite"
                            BlocBuilder<PhotoBloc, PhotoState>(
                              builder: (context, state) {
                                if (state is PhotoLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is FindmeSuccess) {
                                  final favorites =
                                      state.favorites?["data"] ?? [];
                                  print(
                                      'Favorites in UI: $favorites'); // Debugging

                                  return RefreshIndicator(
                                    onRefresh: () async {
                                      context
                                          .read<PhotoBloc>()
                                          .add(FindmePhotoEvent());
                                    },
                                    child: favorites.isNotEmpty
                                        ? _buildGridContent(
                                            favorites
                                                .map((photo) =>
                                                    SellPhoto.fromJson(photo))
                                                .toList(),
                                            activeTab: "Favorite",
                                          )
                                        : ListView(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.8,
                                                child: const Center(
                                                  child: DisBlankFindMe(),
                                                ),
                                              ),
                                            ],
                                          ),
                                  );
                                }
                                // Default UI jika state bukan FindmeSuccess
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    context
                                        .read<PhotoBloc>()
                                        .add(FindmePhotoEvent());
                                  },
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: const Center(
                                          child: DisBlankFindMe(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            // Tab "Collection"
                            BlocBuilder<PhotoBloc, PhotoState>(
                              builder: (context, state) {
                                if (state is PhotoLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is FindmeSuccess) {
                                  if (state.collections != null) {
                                    final collectionPhotos =
                                        (state.collections!['data'] as List)
                                            .map((photo) {
                                      return SellPhoto.fromJson(photo);
                                    }).toList();

                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        context
                                            .read<PhotoBloc>()
                                            .add(FindmePhotoEvent());
                                      },
                                      child: collectionPhotos.isNotEmpty
                                          ? _buildGridContent(collectionPhotos,
                                              activeTab: "Collection")
                                          : ListView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.8,
                                                  child: const Center(
                                                    child: DisBlankFindMe(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    );
                                  }
                                }

                                return RefreshIndicator(
                                  onRefresh: () async {
                                    context
                                        .read<PhotoBloc>()
                                        .add(FindmePhotoEvent());
                                  },
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: const Center(
                                          child: DisBlankFindMe(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ini buat search
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
              Icon(Icons.location_on, color: DisColors.success, size: 16),
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

  Widget _buildGridContent(List<SellPhoto> contents,
      {bool isCollection = false, required String activeTab}) {
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
            _showFullImage(context, contents[index], activeTab);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              contents[index].url,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  void _showFullImage(BuildContext context, SellPhoto photo, String activeTab) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Stack(
            children: [
              Center(
                child: Image.network(
                  photo.url,
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
                      if (activeTab == "All") ...[
                        ElevatedButton(
                          onPressed: () {
                            // Add to favorites
                            context.read<PhotoBloc>().add(
                                  AddToFavoritesEvent(imageUrl: photo.url),
                                );
                            Navigator.pop(context);
                          },
                          child: const Text("Iya"),
                        ),
                        IconButton(
                          icon:
                              Icon(Icons.shopping_cart, color: DisColors.white),
                          onPressed: () {
                            // Add to cart
                            context.read<CartBloc>().add(
                                  AddCartItemEvent(photoId: photo.id),
                                );

                            // Add to favorites
                            context.read<PhotoBloc>().add(
                                  AddToFavoritesEvent(imageUrl: photo.url),
                                );

                            // Optionally refresh the state if needed
                            context.read<PhotoBloc>().add(FindmePhotoEvent());

                            // Close the dialog or navigate back
                            Navigator.pop(context);
                          },
                        ),
                      ] else if (activeTab == "Collection") ...[
                        IconButton(
                          icon: Icon(Icons.download, color: DisColors.white),
                          onPressed: () async {
                            await _downloadImage(photo.url);
                            Navigator.pop(context);
                          },
                        ),
                      ],
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

  //downloadnya disini
  Future<void> _downloadImage(String imageUrl) async {
    try {
      final directory = await getExternalStorageDirectory();
      final uri = Uri.parse(imageUrl);
      final fileName = generateFileName(uri.path);
      final path = '${directory!.path}/$fileName';

      final dio = Dio();
      await dio.download(imageUrl, path);

      print("Gambar berhasil diunduh ke: $path");

      // Show a toast notification
      Fluttertoast.showToast(
        msg: "Gambar berhasil diunduh!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print("Gagal mengunduh gambar: $e");

      // Show a toast notification for failure
      Fluttertoast.showToast(
        msg: "Gagal mengunduh gambar: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  String generateFileName(String url) {
    final bytes = utf8.encode(url);
    final hash = md5.convert(bytes);
    return '$hash.jpg';
  }
}
