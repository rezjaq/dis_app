import 'package:camera/camera.dart';
import 'package:dis_app/pages/findme/DisplayPhotoScreen.dart';
import 'package:dis_app/pages/findme/ListFaceScreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dis_app/utils/constants/colors.dart';

class SearchFaceScreen extends StatefulWidget {
  @override
  _SearchFaceScreenState createState() => _SearchFaceScreenState();
}

class _SearchFaceScreenState extends State<SearchFaceScreen> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.high);
    await _controller.initialize();
    setState(() => _isInitialized = true);
  }

  Future<void> _capturePhoto() async {
    if (_controller.value.isInitialized) {
      try {
        XFile photo = await _controller.takePicture();
        final directory = await getApplicationDocumentsDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final imagePath = '${directory.path}/aligned_face_photo_$timestamp.jpg';

        await photo.saveTo(imagePath);

        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPhotoScreen(imagePath: imagePath),
          ),
        );

        if (result != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListFaceScreen(imagePath: result),
            ),
          );
        }
      } catch (e) {
        print("Error capturing photo: $e");
      }
    } else {
      print("Camera not initialized");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Selfie'),
      ),
      body: _isInitialized
          ? Stack(
              children: [
                Positioned.fill(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: CameraPreview(_controller),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: (MediaQuery.of(context).size.width - 150) / 2,
                  child: ElevatedButton(
                    onPressed: _capturePhoto,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: DisColors.black,
                      backgroundColor: DisColors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
    );
  }
}
