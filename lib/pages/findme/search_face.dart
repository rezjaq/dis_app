import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_app/blocs/searchFace/searchFace_bloc.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/blocs/searchFace/searchFace_state.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;

class SearchFaceScreen extends StatefulWidget {
  @override
  _SearchFaceScreenState createState() => _SearchFaceScreenState();
}

class _SearchFaceScreenState extends State<SearchFaceScreen> {
  bool _isCameraInitialized = false;
  bool _isReloadingCamera = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchFaceBloc>(context).add(InitializeCameraEvent());
  }

  @override
  void dispose() {
    BlocProvider.of<SearchFaceBloc>(context).add(CloseCameraEvent());
    super.dispose();
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
      body: _isReloadingCamera
          ? Center(child: CircularProgressIndicator())
          : BlocBuilder<SearchFaceBloc, SearchFaceState>(
              builder: (context, state) {
                if (state is SearchFaceLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchFaceCameraInitialized) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: CameraPreview(
                            BlocProvider.of<SearchFaceBloc>(context).controller,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: (MediaQuery.of(context).size.width - 150) / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<SearchFaceBloc>(context)
                                .add(CapturePhotoEvent(context: context));
                          },
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
                  );
                } else if (state is SearchFaceNoFaceDetected) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: DisColors.error),
                    ),
                  );
                } else if (state is SearchFaceNoPhotoFound) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: DisColors.error),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
