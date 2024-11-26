import 'dart:io';
import 'package:flutter/material.dart';

class DisPostSection extends StatelessWidget {
  final List<String> postImagePaths;
  final Function(String) onImageTap;

  const DisPostSection({
    Key? key,
    required this.postImagePaths,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: postImagePaths.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onImageTap(postImagePaths[index]),
          child: Image.file(
            File(postImagePaths[index]),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
