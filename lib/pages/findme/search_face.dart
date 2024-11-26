import 'package:camera/camera.dart';
import 'package:dis_app/blocs/searchFace/searchFace_bloc.dart';
import 'package:dis_app/blocs/searchFace/searchFace_state.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/pages/findme/DisplayPhotoScreen.dart';
import 'package:dis_app/pages/findme/ListFaceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_app/utils/constants/colors.dart';

class SearchFaceScreen extends StatefulWidget {
  @override
  _SearchFaceScreenState createState() => _SearchFaceScreenState();
}

class _SearchFaceScreenState extends State<SearchFaceScreen> {
  late SearchFaceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SearchFaceBloc>(context);
  }

  void _capturePhoto() {
    _bloc.add(CapturePhotoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Selfie',
          style: TextStyle(color: DisColors.white),
        ),
        backgroundColor: DisColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DisColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<SearchFaceBloc, SearchFaceState>(
        listener: (context, state) async {
          if (state is SearchFacePhotoCaptured) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPhotoScreen(imagePath: state.imagePath),
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
          } else if (state is SearchFaceError) {
            print("Error: ${state.message}");
          }
        },
        builder: (context, state) {
          if (state is SearchFaceLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchFaceLoaded) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: CameraPreview(state.controller),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: (MediaQuery.of(context).size.width - 150) / 2,
                  child: ElevatedButton(
                    onPressed: _capturePhoto,
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
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
