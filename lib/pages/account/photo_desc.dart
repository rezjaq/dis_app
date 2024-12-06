import 'dart:io';
import 'package:dis_app/blocs/photo/photo_bloc.dart';
import 'package:dis_app/blocs/photo/photo_event.dart';
import 'package:dis_app/blocs/photo/photo_state.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:dis_app/utils/constants/show_confirmation.dart';

class PostFormPhotoScreen extends StatefulWidget {
  final XFile? imageFile;

  const PostFormPhotoScreen({Key? key, required this.imageFile})
      : super(key: key);

  @override
  _PostFormPhotoScreenState createState() => _PostFormPhotoScreenState();
}

class _PostFormPhotoScreenState extends State<PostFormPhotoScreen> {
  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is PhotoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Konten berhasil disimpan!')),
          );
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is PhotoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan konten: ${state.message}')),
          );
        }
      },
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
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (widget.imageFile != null) {
                  _savePost(widget.imageFile!, _captionController.text);
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
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

  void _savePost(XFile imageFile, String description) {
    final file = File(imageFile.path);
    final name = path.basename(imageFile.path);

    context.read<PhotoBloc>().add(AddPostPhotoEvent(
          name: name,
          description: description,
          file: file,
        ));
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DisShowConfirmation(
          onConfirm: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya
          },
        );
      },
    );
  }
}
