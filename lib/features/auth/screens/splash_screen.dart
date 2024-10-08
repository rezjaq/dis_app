import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

class FindMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghapus banner debug
      home: Scaffold(
        body: CustomPaint(
          painter: BackgroundPainter(),
          child: Align(
            // Menggunakan Align untuk mengatur posisi
            alignment: Alignment.topCenter, // Menempatkan ke atas
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Menggunakan min untuk ukuran kolom
              children: [
                SizedBox(height: 240), // Ruang di atas
                Icon(
                  Icons.camera,
                  size: 120,
                  color: Colors.black,
                ),
                SizedBox(height: 10), // Ruang antara ikon dan teks
                Text(
                  'FindMe',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4), // Ruang antara teks judul dan subjudul
                Text(
                  'for the best results',
                  style: TextStyle(
                    fontSize: 2,
                    color: Colors
                        .grey, // Warna teks abu-abu untuk mencocokkan referensi
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();

    // Latar belakang putih
    paint.color = DisColors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Membuat lengkungan halus di tengah menggunakan quadraticBezierTo
    path.moveTo(0, size.height * 0.6); // Mulai di sekitar 60% dari tinggi
    path.quadraticBezierTo(
        size.width * 0.15,
        size.height * 0.65, // Titik kontrol untuk lengkungan halus
        size.width * 0.35,
        size.height * 0.72); // Lengkungan menuju titik ini
    path.lineTo(size.width, size.height * 0.45); // Ujung di sisi kanan
    path.lineTo(size.width, size.height); // Garis ke kanan bawah
    path.lineTo(0, size.height); // Garis ke kiri bawah
    path.close(); // Menutup path

    // Mengisi dengan warna kuning
    paint.color = DisColors.primary;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
