import 'dart:io';
import 'package:dis_app/blocs/photo/photo_bloc.dart';
import 'package:dis_app/blocs/photo/photo_event.dart';
import 'package:dis_app/blocs/photo/photo_state.dart';
import 'package:dis_app/controllers/photo_controller.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class PostFormPhotoScreen extends StatefulWidget {
  final XFile? imageFile;
  final bool
      isFromCamera; // Paramter opsional soalnya ada 2 yang makek buat bedain

  const PostFormPhotoScreen({
    Key? key,
    required this.imageFile,
    this.isFromCamera = false, // Default-nya false
  }) : super(key: key);

  @override
  _PostFormPhotoScreenState createState() => _PostFormPhotoScreenState();
}

class _PostFormPhotoScreenState extends State<PostFormPhotoScreen> {
  final TextEditingController _captionController = TextEditingController();
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc(photoController: PhotoController()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Info Konten"),
          backgroundColor: DisColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _showConfirmationDialog(context);
            },
          ),
          actions: [
            BlocBuilder<PhotoBloc, PhotoState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () async {
                    if (widget.imageFile != null) {
                      final description = _captionController.text.trim();
                      final name = path.basename(widget.imageFile!.path);
                      final file = widget.imageFile!;

                      context.read<PhotoBloc>().add(AddPostPhotoEvent(
                            description: description,
                            name: name,
                            file: file,
                          ));

                      if (state is PhotoSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Konten berhasil disimpan!')),
                        );
                        Navigator.pushReplacementNamed(context, '/home');
                      } else if (state is PhotoFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Gagal menyimpan konten: ${state.message}')),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.imageFile != null)
                Center(
                  child: Image.file(
                    File(widget.imageFile!.path),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Caption',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  hintText: 'Tambahkan caption disini (Maks. 500 karakter)',
                  border: OutlineInputBorder(),
                ),
                maxLength: 500,
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content:
              const Text('Apakah Anda yakin ingin kembali tanpa menyimpan?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
