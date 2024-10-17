import 'dart:io';
import 'dart:ui';
import 'package:dis_app/features/auth/screens/photo_desc.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

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
  late CameraController cameraController;
  late Future<void> cameraValue;
  bool isRearCamera = true;
  bool isCameraChanging = false;
  double _opacity = 1.0;
  FlashMode flashMode = FlashMode.off;
  double _rotationAngle = 0.0;
  XFile? _imageFile;

  void startCamera(int camera) async {
    setState(() {
      isCameraChanging = true;
      _opacity = 0.0;
    });
    cameraController = CameraController(
      widget.cameras[camera],
      ResolutionPreset.high,
      enableAudio: false,
    );
    cameraValue = cameraController.initialize();
    await cameraValue;
    cameraController.setFlashMode(flashMode);
    setState(() {
      _opacity = 1.0;
      isCameraChanging = false;
    });
  }

  void toggleFlash() {
    setState(() {
      flashMode =
          (flashMode == FlashMode.off) ? FlashMode.torch : FlashMode.off;
    });
    cameraController.setFlashMode(flashMode);
  }

  @override
  void initState() {
    super.initState();
    startCamera(0);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    try {
      await cameraValue;
      _imageFile = await cameraController.takePicture();

      if (_imageFile != null) {
        if (isRearCamera) {
          await savePicture(_imageFile!);
        } else {
          await savePicture(_imageFile!);
        }

        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> savePicture(XFile imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, '${DateTime.now()}.jpg');
    File originalImage = File(imageFile.path);
    img.Image? image = img.decodeImage(await originalImage.readAsBytes());

    if (!isRearCamera && image != null) {
      image = img.flipHorizontal(image);
    }

    File savedImage = await File(path).writeAsBytes(img.encodeJpg(image!));
    print('Image saved to: $path');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: 100,
                        child: isRearCamera
                            ? CameraPreview(cameraController)
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(3.14159),
                                child: CameraPreview(cameraController),
                              ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          // Back button in the top left corner
          if (_imageFile == null)
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    icon:
                        const Icon(Icons.close_rounded, color: DisColors.white),
                    iconSize: DisSizes.xl,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          if (_imageFile == null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Flash button
                    IconButton(
                      onPressed: toggleFlash,
                      icon: Icon(
                        flashMode == FlashMode.off
                            ? Icons.flash_off
                            : Icons.flash_on,
                        color: DisColors.white,
                      ),
                    ),
                    // Capture button
                    GestureDetector(
                      onTap: takePicture,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: CameraIcon(),
                      ),
                    ),
                    // Flip camera animaiton
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRearCamera = !isRearCamera;
                          _rotationAngle += 3.14;
                        });
                        startCamera(isRearCamera ? 0 : 1);
                      },
                      child: AnimatedRotation(
                        turns: _rotationAngle / (2 * 3.14),
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.cached,
                          color: DisColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_imageFile != null)
            Stack(
              children: [
                Center(
                  child: Image.file(
                    File(_imageFile!.path),
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: DisColors.white),
                        iconSize: DisSizes.xl,
                        onPressed: () {
                          setState(() {
                            _imageFile = null;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: const Icon(Icons.check, color: DisColors.white),
                        iconSize: DisSizes.xl,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostFormPhotoScreen(imageFile: _imageFile),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class CameraIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DisColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.85, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CameraIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(50, 50),
      painter: CameraIconPainter(),
    );
  }
}
