import 'dart:io';
import 'package:dis_app/blocs/displayPhoto/displayPhoto_bloc.dart';
import 'package:dis_app/blocs/displayPhoto/displayPhoto_event.dart';
import 'package:dis_app/blocs/displayPhoto/displayPhoto_state.dart';
import 'package:dis_app/blocs/searchFace/searchFace_bloc.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/pages/findme/ListFaceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_app/utils/constants/colors.dart';

class DisplayPhotoScreen extends StatelessWidget {
  final String imagePath;

  DisplayPhotoScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Selfie'),
      ),
      body: BlocConsumer<DisplayPhotoBloc, DisplayPhotoState>(
        listener: (context, state) {
          if (state is DisplayPhotoSavedState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListFaceScreen(
                  imagePath: state.savedPath,
                  matchedFaces: [],
                ),
              ),
            );
          } else if (state is DisplayPhotoErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          if (state is DisplayPhotoSavingState) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath.isNotEmpty)
                Container(
                  height: 500,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Apakah kamu puas dengan hasilnya?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<DisplayPhotoBloc>().add(RetakePhotoEvent());
                      context
                          .read<SearchFaceBloc>()
                          .add(InitializeCameraEvent());
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DisColors.primary,
                      foregroundColor: DisColors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Ambil Ulang'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<DisplayPhotoBloc>()
                          .add(SavePhotoEvent(photoPath: imagePath));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListFaceScreen(
                            imagePath: imagePath,
                            matchedFaces: [],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DisColors.primary,
                      foregroundColor: DisColors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Ya'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
