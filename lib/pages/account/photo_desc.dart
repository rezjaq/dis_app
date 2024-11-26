import 'dart:convert';
import 'dart:io';
import 'package:dis_app/models/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import 'package:dis_app/utils/constants/show_confirmation.dart'; 

class PostFormPhotoScreen extends StatefulWidget {
  final XFile? imageFile;

  const PostFormPhotoScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  _PostFormPhotoScreenState createState() => _PostFormPhotoScreenState();
}

class _PostFormPhotoScreenState extends State<PostFormPhotoScreen> {
  final TextEditingController _captionController = TextEditingController();
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Konten"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _showConfirmationDialog(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (widget.imageFile != null) {
                await _savePost(widget.imageFile!, _captionController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Konten berhasil disimpan!')),
                );
              }
              Navigator.pushReplacementNamed(context, '/home');
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
    );
  }

  Future<void> clearDummiesData() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory(path.join(dir.path, 'assets/images/dummies'));
      final jsonFile = File(path.join(dir.path, 'dummies.json'));

      // Delete all files in the images directory
      if (await imagesDir.exists()) {
        final files = imagesDir.listSync();
        for (var file in files) {
          if (file is File) {
            await file.delete();
          }
        }
        print('All images deleted from ${imagesDir.path}');
      } else {
        print('Images directory does not exist');
      }

      // Overwrite the JSON file with an empty structure
      if (await jsonFile.exists()) {
        final emptyJson = jsonEncode({"post": []});
        await jsonFile.writeAsString(emptyJson);
        print('All data cleared from dummies.json');
      } else {
        print('dummies.json does not exist');
      }
    } catch (e) {
      print('Error clearing dummies data: $e');
    }
  }

  Future<void> _savePost(XFile image, String desc) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final saveDir = Directory(path.join(dir.path, 'assets/images/dummies'));
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      final fileName = path.basename(image.path);
      final saveImage = await File(image.path).copy(path.join(saveDir.path, fileName));
      print('Image saved to: ${saveImage.path}');

      final postPhoto = PostPhoto(
        id: uuid.v4(),
        url: "${saveImage.path}",
        name: fileName,
        description: desc,
      );

      final jsonFile = File(path.join(dir.path, 'dummies.json'));
      if (await jsonFile.exists()) {
        final jsonString = await jsonFile.readAsString();
        final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
        jsonData['post'].add(postPhoto.toJson());
        print(jsonData);
        await jsonFile.writeAsString(jsonEncode(jsonData));
      } else {
        final jsonData = {
          "post": [postPhoto.toJson()]
        };
        await jsonFile.writeAsString(jsonEncode(jsonData));
      }
    } catch (e) {
      print('Error saving post: $e');
    }
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
