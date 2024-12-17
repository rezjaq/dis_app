import 'dart:io';
import 'package:dis_app/blocs/face/face_bloc.dart';
import 'package:dis_app/blocs/listFace/listFace_bloc.dart';
import 'package:dis_app/blocs/listFace/listFace_event.dart';
import 'package:dis_app/blocs/listFace/listFace_state.dart';
import 'package:dis_app/blocs/searchFace/searchFace_bloc.dart';
import 'package:dis_app/controllers/face_controller.dart';
import 'package:dis_app/models/face_model.dart';
import 'package:dis_app/pages/findme/search_face.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFaceScreen extends StatefulWidget {
  final String imagePath;
  final List<Face> matchedFaces;
  final String userId;

  const ListFaceScreen({
    required this.imagePath,
    required this.matchedFaces,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  _ListFaceScreenState createState() => _ListFaceScreenState();
}

class _ListFaceScreenState extends State<ListFaceScreen> {
  @override
  void initState() {
    super.initState();
    // Memuat data wajah mirip berdasarkan userId
    context.read<ListFaceBloc>().add(LoadSimilarPhotos(widget.userId));
  }

  void _navigateToSearchFace() {
    // Navigasi ke layar "SearchFaceScreen"
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FaceBloc(faceController: FaceController()),
            ),
            BlocProvider(
              create: (context) => SearchFaceBloc(FaceController()),
            ),
          ],
          child: SearchFaceScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ListFaceBloc>().add(ClearListFace());
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tambah Selfie',
            style: TextStyle(color: DisColors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DisColors.white),
            onPressed: () {
              context.read<ListFaceBloc>().add(ClearListFace());
              Navigator.pop(context);
            },
          ),
          backgroundColor: DisColors.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.room, color: DisColors.primary, size: 40),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Halo, RoboYu sedang mencari foto berdasarkan selfie ini',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     _buildOriginalPhoto(),
              //     _buildAddSelfieButton(),
              //   ],
              // ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocConsumer<ListFaceBloc, ListFaceState>(
                  listener: (context, state) {
                    if (state is ListFaceError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ListFaceLoading) {
                      return _buildSkeletonLoader();
                    } else if (state is ListFaceLoaded) {
                      return _buildSimilarPhotosGrid(state.similarFaces);
                    } else if (state is ListFaceError) {
                      return Center(
                        child: Text(state.message,
                            style: const TextStyle(color: Colors.red)),
                      );
                    }
                    return const SizedBox.shrink();
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
        const SizedBox(height: 8),
        const Text('Original', style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildAddSelfieButton() {
    return GestureDetector(
      onTap: _navigateToSearchFace,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 156,
            width: 160,
            decoration: BoxDecoration(
              color: DisColors.darkGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.add_a_photo_sharp,
                size: 40,
                color: DisColors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Tambah Selfie', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

  Widget _buildSimilarPhotosGrid(List<Face> faces) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: faces.length + 1,
        itemBuilder: (context, index) {
          if (index == faces.length) {
            return _buildAddSelfieButton();
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.network(
                  faces[index].url,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                if (index == 0)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: const Text(
                        'Original',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
