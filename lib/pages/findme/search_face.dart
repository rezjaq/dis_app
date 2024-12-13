import 'dart:math'; // Tambahkan ini untuk rotasi transformasi.
import 'package:camera/camera.dart';
import 'package:dis_app/blocs/face/face_bloc.dart';
import 'package:dis_app/blocs/face/face_event.dart';
import 'package:dis_app/blocs/face/face_state.dart';
import 'package:dis_app/blocs/searchFace/searchFace_bloc.dart';
import 'package:dis_app/blocs/searchFace/searchFace_state.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/pages/findme/DisplayPhotoScreen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFaceScreen extends StatefulWidget {
  @override
  _SearchFaceScreenState createState() => _SearchFaceScreenState();
}

class _SearchFaceScreenState extends State<SearchFaceScreen> {
  late CameraController _controller;
  bool _isCameraInitialized = false;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    if (_isCameraInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _captureAndProcessFace(BuildContext context) async {
    if (_isCapturing) return;

    try {
      setState(() {
        _isCapturing = true;
      });

      if (!_controller.value.isInitialized) return;
      final XFile photo = await _controller.takePicture();
      final faceBloc = BlocProvider.of<FaceBloc>(context);
      faceBloc.add(FaceDetectionEvent(file: photo));

      setState(() {
        _isCapturing = false;
      });
    } catch (e) {
      setState(() {
        _isCapturing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengambil foto: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deteksi Wajah',
          style: TextStyle(color: DisColors.white),
        ),
        backgroundColor: DisColors.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DisColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<FaceBloc, FaceState>(
        listener: (context, faceState) {
          if (faceState is FaceSuccess) {
            final searchFaceBloc = BlocProvider.of<SearchFaceBloc>(context);
            searchFaceBloc.add(
                SearchMatchedPhotosEvent(userId: faceState.data?['userId']));
          } else if (faceState is FaceFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Gagal mendeteksi wajah: ${faceState.message}")),
            );
          }
        },
        child: BlocListener<SearchFaceBloc, SearchFaceState>(
          listener: (context, searchState) {
            if (searchState is SearchFaceMatchedPhotosLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayPhotoScreen(
                      imagePath: searchState.matchedPhotos[0]),
                ),
              );
            } else if (searchState is SearchFaceNoMatchFound) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Tidak ada kecocokan ditemukan")),
              );
            } else if (searchState is SearchFaceError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${searchState.message}")),
              );
            }
          },
          child: _isCameraInitialized
              ? Stack(
                  children: [
                    Positioned.fill(
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(
                            _controller.description.lensDirection ==
                                    CameraLensDirection.front
                                ? pi
                                : 0),
                        child: CameraPreview(_controller),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: (MediaQuery.of(context).size.width - 150) / 2,
                      child: ElevatedButton(
                        onPressed: () => _captureAndProcessFace(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: DisColors.white,
                          backgroundColor: DisColors.primary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text('Ambil Foto'),
                      ),
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
