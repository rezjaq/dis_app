import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart'; // For getting app directory to save images

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  int selectedCameraIndex = 0; // To track current camera (front/back)
  List<String> capturedImages = []; // To store paths of captured images

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() {
    if (controller != null) {
      controller!.dispose();
    }

    controller = CameraController(
      widget.cameras[selectedCameraIndex],
      ResolutionPreset.max,
    );

    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<void> switchCamera() async {
    selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;
    initializeCamera();
  }

  void captureImage() async {
    try {
      if (controller != null && controller!.value.isInitialized) {
        // Mengambil gambar dan menyimpan sebagai XFile
        XFile image = await controller!.takePicture();

        // Mendapatkan jalur file dari gambar yang diambil
        final String filePath = image.path;

        // Menyimpan jalur gambar yang diambil ke dalam daftar
        capturedImages.add(filePath);

        setState(() {});
      }
    } catch (e) {
      print('Error saat mengambil gambar: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: captureImage,
                      child: const Icon(Icons.camera),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: switchCamera,
                      child: const Icon(Icons.switch_camera),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: capturedImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.file(
                          File(capturedImages[index]),
                          width: 100,
                          height: 100,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
