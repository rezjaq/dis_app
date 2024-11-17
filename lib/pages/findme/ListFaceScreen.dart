import 'dart:io';
import 'package:dis_app/pages/findme/search_face.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

class ListFaceScreen extends StatefulWidget {
  final String imagePath;

  ListFaceScreen({required this.imagePath});

  @override
  _ListFaceScreenState createState() => _ListFaceScreenState();
}

class _ListFaceScreenState extends State<ListFaceScreen> {
  bool _isLoading = true;
  List<String> _similarPhotos = []; // Mock similar photos paths

  @override
  void initState() {
    super.initState();
    _loadSimilarPhotos();
  }

  // Simulated loading function for similar faces
  Future<void> _loadSimilarPhotos() async {
    await Future.delayed(Duration(seconds: 2)); // Simulated delay

    // Mock list of similar photos (replace with actual paths or network images if available)
    _similarPhotos = [
      'assets/images/similar_face1.jpg',
      'assets/images/similar_face2.jpg',
      'assets/images/similar_face3.jpg',
      'assets/images/similar_face4.jpg',
    ];

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToSearchFace() {
    // Navigate to search face screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SearchFaceScreen()), // Replace with your actual search face screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to FindMe page
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Selfie'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Greeting with icon and text
              Row(
                children: [
                  Icon(Icons.room, color: DisColors.primary, size: 40),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Halo Bos, RoboYu mencari foto kamu berdasarkan selfie ini',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Display original photo and "Tambah Selfie" button side-by-side
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildOriginalPhoto(),
                  _buildAddSelfieButton(),
                ],
              ),
              SizedBox(height: 20),
              // Display similar photos or skeleton loader
              Expanded(
                child: _isLoading
                    ? _buildSkeletonLoader()
                    : _buildSimilarPhotosGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the original photo with label
  Widget _buildOriginalPhoto() {
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(File(widget.imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text('Original', style: TextStyle(fontSize: 14)),
      ],
    );
  }

  // Widget to display "Tambah Selfie" button with an empty placeholder image
  Widget _buildAddSelfieButton() {
    return GestureDetector(
      onTap: _navigateToSearchFace,
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: DisColors.darkGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text('Tambah Selfie',
                  style: TextStyle(fontSize: 16, color: Colors.purple)),
            ),
          ),
          SizedBox(height: 8),
          Text('Tambah Selfie', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Skeleton loader widget
  Widget _buildSkeletonLoader() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4, // Adjust based on the number of placeholders you want
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: DisColors.darkGrey,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  // Grid view of similar photos
  Widget _buildSimilarPhotosGrid() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _similarPhotos.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(_similarPhotos[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
