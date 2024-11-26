import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart'; 

class DisShowConfirmation extends StatelessWidget {
  final VoidCallback onConfirm;

  const DisShowConfirmation({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Konfirmasi'),
      content: const Text('Apakah Anda yakin ingin kembali? Foto tidak akan disimpan.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Menutup dialog tanpa melakukan apa-apa
          },
          child: const Text('Tidak', style: TextStyle(color: DisColors.black)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Menutup dialog
            onConfirm(); // Menjalankan callback yang dikirim
          },
          child: const Text('Ya, Saya Yakin', style: TextStyle(color: DisColors.error)),
        ),
      ],
    );
  }
}
