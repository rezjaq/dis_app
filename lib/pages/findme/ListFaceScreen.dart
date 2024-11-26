import 'dart:io';
import 'package:dis_app/blocs/searchFace/searchFace_bloc.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/models/face_model.dart';
import 'package:dis_app/pages/findme/search_face.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/blocs/listFace/listFace_bloc.dart';
import 'package:dis_app/blocs/listFace/listFace_event.dart';
import 'package:dis_app/blocs/listFace/listFace_state.dart';

class ListFaceScreen extends StatefulWidget {
  final String imagePath;

  ListFaceScreen({required this.imagePath});

  @override
  _ListFaceScreenState createState() => _ListFaceScreenState();
}

class _ListFaceScreenState extends State<ListFaceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListFaceBloc>().add(LoadSimilarPhotos());
  }

  void _navigateToSearchFace() {
    context.read<SearchFaceBloc>().add(InitializeCameraEvent());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchFaceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tambah Selfie',
            style: TextStyle(color: DisColors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: DisColors.white),
            onPressed: () {
              context.read<ListFaceBloc>().add(ClearListFace());
              Navigator.pop(context);
            },
          ),
          backgroundColor: DisColors.primary,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildOriginalPhoto(),
                  _buildAddSelfieButton(),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ListFaceBloc, ListFaceState>(
                  builder: (context, state) {
                    if (state is ListFaceLoading) {
                      return _buildSkeletonLoader();
                    } else if (state is ListFaceLoaded) {
                      return _buildSimilarPhotosGrid(state.similarPhotos);
                    } else if (state is ListFaceError) {
                      return Center(
                        child: Text(state.message,
                            style: TextStyle(color: Colors.red)),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              child: Icon(
                Icons.add_a_photo_sharp,
                size: 40,
                color: DisColors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text('Tambah Selfie', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
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

  Widget _buildSimilarPhotosGrid(List<PhotoModel> photos) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(photos[index].imagePath),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
