import 'package:camera/camera.dart';
import 'package:dis_app/blocs/face/face_bloc.dart';
import 'package:dis_app/blocs/face/face_event.dart';
import 'package:dis_app/blocs/face/face_state.dart';
import 'package:dis_app/pages/findme/DisplayPhotoScreen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SearchFaceScreen extends StatefulWidget {
  @override
  _SearchFaceScreenState createState() => _SearchFaceScreenState();
}

class _SearchFaceScreenState extends State<SearchFaceScreen> {
  late CameraController _controller;
  bool _isCameraInitialized = false;
  final ImagePicker _imagePicker = ImagePicker();

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

  void _captureAndDetectFace(BuildContext context) async {
    try {
      if (!_controller.value.isInitialized) return;

      final XFile photo = await _controller.takePicture();
      final imagePath = photo.path;

      final FaceBloc faceBloc = BlocProvider.of<FaceBloc>(context);
      faceBloc.add(FaceDetectionEvent(file: photo));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPhotoScreen(imagePath: imagePath),
        ),
      );
    } catch (e) {
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
      body: _isCameraInitialized
          ? Stack(
              children: [
                Positioned.fill(child: CameraPreview(_controller)),
                Positioned(
                  bottom: 40,
                  left: (MediaQuery.of(context).size.width - 150) / 2,
                  child: ElevatedButton(
                    onPressed: () => _captureAndDetectFace(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: DisColors.white,
                      backgroundColor: DisColors.primary,
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
