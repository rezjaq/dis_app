import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'dart:io';

class UploadContentPage extends StatefulWidget {
  final Function(String) onUpload;
  final String imagePath;

  UploadContentPage({
    required this.onUpload,
    required this.imagePath,
  });

  @override
  _UploadContentPageState createState() => _UploadContentPageState();
}

class _UploadContentPageState extends State<UploadContentPage> {
  final TextEditingController _hargaDasarController = TextEditingController();
  final TextEditingController _hargaJualController = TextEditingController();
  String _pendapatan = 'IDR 0';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _imagePath; // Menyimpan path gambar yang dipilih

  @override
  void initState() {
    super.initState();
    _imagePath = widget
        .imagePath; // Inisialisasi _imagePath dengan imagePath yang diterima
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
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harga jual harus 10.000 atau kurang'),
          duration: Duration(seconds: 2),
        ),
      );
      _hargaDasarController.clear();
      _hargaJualController.clear();
      setState(() {
        _pendapatan = 'IDR 0';
      });
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path; // Simpan path gambar yang dipilih
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unggah Konten"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: _selectImage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Preview Section
              Center(
                child: Column(
                  children: [
                    _imagePath != null
                        ? Image.file(
                            File(_imagePath!),
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : Text('Silakan pilih gambar'),
                    SizedBox(height: 10),
                    Text(
                      _imagePath != null
                          ? '${File(_imagePath!).lengthSync()} bytes'
                          : 'Ukuran gambar akan ditampilkan di sini',
                      style: TextStyle(color: DisColors.grey),
                    ),
                  ],
                ),
              ),
              // File Name
              Text('Nama File'),
              TextFormField(
                initialValue: _imagePath != null
                    ? _imagePath!.split('/').last
                    : 'Belum ada gambar dipilih',
                readOnly: true,
              ),
              SizedBox(height: 20),

              // Currency and Price
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Mata Uang'),
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
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _hargaDasarController,
                      decoration: InputDecoration(labelText: 'Harga Dasar'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        _updateHargaJual();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Sale Price (Read-Only)
              TextFormField(
                controller: _hargaJualController,
                decoration: InputDecoration(labelText: 'Harga Jual'),
                readOnly: true,
              ),
              Text(
                'Pendapatan kamu: $_pendapatan',
                style: TextStyle(color: DisColors.grey),
              ),
              SizedBox(height: 20),

              // Location (Optional)
              TextFormField(
                decoration: InputDecoration(labelText: 'Lokasi (Opsional)'),
                onTap: () {
                  // Implement Google Maps location picker
                },
              ),
              SizedBox(height: 20),

              // Date and Time
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Tanggal (Opsional)'),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      controller: TextEditingController(
                        text: _selectedDate == null
                            ? ''
                            : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Waktu (Opsional)'),
                      readOnly: true,
                      onTap: () => _selectTime(context),
                      controller: TextEditingController(
                        text: _selectedTime == null
                            ? ''
                            : _selectedTime!.format(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Deskripsi (Opsional)',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),

              // FotoTree (Optional)
              TextFormField(
                decoration: InputDecoration(labelText: 'FotoTree (Opsional)'),
              ),
              SizedBox(height: 20),

              // Tag Nickname User (Optional)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Tag Nickname User (Opsional)',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle add nickname action
                    },
                    child: Text('Tambah'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Upload Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle upload action
                    if (_imagePath != null) {
                      widget.onUpload(_imagePath!);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Silakan pilih gambar sebelum mengunggah.'),
                        ),
                      );
                    }
                  },
                  child: Text('Unggah'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
