import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/blocs/photo/photo_bloc.dart';
import 'package:dis_app/blocs/photo/photo_event.dart';
import 'package:dis_app/blocs/photo/photo_state.dart';

class UploadContentPage extends StatefulWidget {
  final String imagePath;

  const UploadContentPage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  _UploadContentPageState createState() => _UploadContentPageState();
}

class _UploadContentPageState extends State<UploadContentPage> {
  final TextEditingController _hargaDasarController = TextEditingController();
  final TextEditingController _hargaJualController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fileNameController = TextEditingController();

  String _pendapatan = 'IDR 0';
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath;
    _fileNameController.text =
        _imagePath?.split('/').last ?? 'Belum ada gambar dipilih';
  }

  void _updateHargaJual() {
    double hargaDasar = double.tryParse(_hargaDasarController.text) ?? 0;
    if (hargaDasar <= 10000) {
      _hargaJualController.text = hargaDasar.toStringAsFixed(0);
      double income = hargaDasar - (hargaDasar * 0.05);
      setState(() {
        _pendapatan = 'IDR ${income.toStringAsFixed(0)}';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harga jual harus 10.000 atau kurang'),
        ),
      );
      _hargaDasarController.clear();
      _hargaJualController.clear();
      setState(() {
        _pendapatan = 'IDR 0';
      });
    }
  }

  void _uploadPhoto() {
    if (_imagePath == null || _hargaDasarController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi semua data sebelum mengunggah.'),
        ),
      );
      return;
    }

    context.read<PhotoBloc>().add(AddSellPhotoEvent(
          name: _fileNameController.text,
          basePrice: double.parse(_hargaDasarController.text),
          sellPrice: double.parse(_hargaJualController.text),
          description: _descriptionController.text,
          file: File(_imagePath!),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is PhotoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto berhasil diunggah!')),
          );
          Navigator.pop(context);
        } else if (state is PhotoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengunggah foto: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Form Sell"),
          backgroundColor: DisColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Preview Section
                Center(
                  child: Column(
                    children: [
                      _imagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.file(
                                File(_imagePath!),
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Text('Silakan pilih gambar'),
                      const SizedBox(height: 10),
                      Text(
                        _imagePath != null
                            ? '${File(_imagePath!).lengthSync()} bytes'
                            : 'Ukuran gambar akan ditampilkan di sini',
                        style: const TextStyle(color: DisColors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),

                // File Name Section
                const Text('File Name',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _fileNameController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.insert_drive_file),
                    border: OutlineInputBorder(),
                    labelText: 'File Name',
                  ),
                ),
                const SizedBox(height: 16.0),

                // Currency and Price Section
                const Text('Currency and Price',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Currency',
                        ),
                        items: ['IDR'].map((currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: (value) {
                          // Handle currency change
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _hargaDasarController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Basic Price',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          _updateHargaJual();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Sale Price (Read-Only)
                const Text('Selling Price',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _hargaJualController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Selling Price',
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Your earnings: $_pendapatan',
                  style: const TextStyle(color: DisColors.darkerGrey),
                ),
                const SizedBox(height: 16.0),

                // Description
                const Text('Description',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description (Optional)',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),

                Center(
                  child: SizedBox(
                    width: double.infinity, // Membuat tombol selebar layar
                    child: ElevatedButton(
                      onPressed: _uploadPhoto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DisColors.primary,
                        foregroundColor: DisColors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Upload',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
