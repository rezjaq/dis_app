import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

    _controller.startImageStream((CameraImage image) {
      // Tidak ada logika deteksi wajah di sini
    });
  }

  Future<void> _capturePhoto() async {
    if (_controller.value.isInitialized) {
      try {
        XFile photo = await _controller.takePicture();
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/aligned_face_photo.jpg';
        await photo.saveTo(imagePath);

        // Log untuk memastikan foto disimpan
        print("Foto disimpan di $imagePath");

        // Navigasi ke halaman DisplayPhotoScreen setelah foto diambil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPhotoScreen(imagePath: imagePath),
          ),
        );
      } catch (e) {
        print("Error mengambil foto: $e");
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
        title: Text('Search Face'),
      ),
      body: _isInitialized
          ? Stack(
              children: [
                // Fullscreen CameraPreview
                Positioned.fill(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159), // Horizontal flip
                    child: CameraPreview(_controller),
                  ),
                ),
                // Overlay image (lebih kecil dan posisi lebih tepat di tengah)
                Positioned(
                  top: MediaQuery.of(context).size.height / 3 -
                      140, // Menurunkan overlay sedikit
                  left: (MediaQuery.of(context).size.width - 250) /
                      2, // Posisi horizontal tengah
                  child: Image.asset(
                    'assets/images/overlay.png',
                    width: 250, // Ukuran overlay lebih kecil
                    height: 350, // Ukuran overlay lebih kecil
                    fit: BoxFit.cover,
                  ),
                ),
                // Tombol Ambil Foto di atas layer overlay dan memastikan tidak tertutup
                Positioned(
                  bottom: 40, // Posisi tombol dari bawah
                  left: (MediaQuery.of(context).size.width - 150) /
                      2, // Tengah horizontal
                  child: ElevatedButton(
                    onPressed: _capturePhoto, // Tombol bisa langsung diklik
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white, // Teks hitam
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

class DisplayPhotoScreen extends StatelessWidget {
  final String imagePath;

  DisplayPhotoScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foto Tersimpan'),
      ),
      body: Center(
        child: imagePath.isNotEmpty
            ? Image.file(File(imagePath))
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
