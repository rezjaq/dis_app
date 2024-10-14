import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InfoKontenScreen extends StatelessWidget {
  final XFile? imageFile;

  const InfoKontenScreen({Key? key, required this.imageFile}) : super(key: key);

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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Konten berhasil disimpan!')),
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
            if (imageFile != null)
              Center(
                child: Image.file(
                  File(imageFile!.path),
                  width: 150, // Lebar gambar bisa disesuaikan
                  height: 150, // Tinggi gambar bisa disesuaikan
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
              decoration: const InputDecoration(
                hintText: 'Tambahkan caption disini (Maks. 300 karakter)',
                border: OutlineInputBorder(),
              ),
              maxLength: 300, // Maksimal 300 karakter
              maxLines: 3, // Caption bisa diisi hingga 3 baris
            ),
            const SizedBox(height: 20),
            const Text(
              'FotoTree (Opsional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ketik nama FotoTree',
                border: OutlineInputBorder(),
              ),
            ),
          ],
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
          content: const Text(
              'Apakah Anda yakin ingin kembali? Foto tidak akan disimpan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Ya, Saya Yakin'),
            ),
          ],
        );
      },
    );
  }
}
