import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DisBlankFindMe extends StatelessWidget {
  const DisBlankFindMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80), // Mengatur padding atas
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menambahkan asset gambar SVG
            SvgPicture.asset(
              'assets/images/noPost.svg',
              height: 250,
            ),
            const SizedBox(height: 10), // Sedikit jarak antara gambar dan teks
            const Text(
              'Cannot load data',
              style: TextStyle(
                fontSize: 18,
                color: DisColors.darkGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5), // Sedikit jarak antara teks
            const Text(
              'Your content will appear here once available.',
              style: TextStyle(fontSize: 14, color: DisColors.darkGrey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
