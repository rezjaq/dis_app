import 'package:flutter/material.dart';
import 'dart:io';

class PostSection extends StatelessWidget {
  final List<String> postImagePaths;

  const PostSection({
    Key? key,
    required this.postImagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
        ),
        itemCount: postImagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showImageDialog(context, postImagePaths[index]),
            child: Container(
              color: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  File(postImagePaths[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
