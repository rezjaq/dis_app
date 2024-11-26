import 'package:dis_app/pages/account/form_sell.dart';
import 'package:dis_app/pages/account/postSection.dart';
import 'package:dis_app/pages/account/profileHeader.dart';
import 'package:dis_app/pages/account/sectionToggle.dart';
import 'package:dis_app/pages/account/sellSection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

enum SellFilter { all, available, sold }

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isSellSelected = true;
  SellFilter selectedFilter = SellFilter.all;
  List<String> sellImagePaths = [];
  List<String> postImagePaths = [];

  void _toggleSection(bool isSell) {
    setState(() {
      isSellSelected = isSell;
    });
  }

  void _selectFilter(SellFilter filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _showUploadOptions(image.path);
    }
  }

  void _showUploadOptions(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Upload To"),
          content: const Text("Where do you want to upload this image?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadContentPage(
                      imagePath: imagePath,
                      onUpload: (uploadedImagePath) {
                        setState(() {
                          sellImagePaths.add(uploadedImagePath);
                        });
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      },
                    ),
                  ),
                );
              },
              child: const Text("Sell"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  postImagePaths.add(imagePath);
                  isSellSelected = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Post"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(
              onPickImage: _pickImage,
            ),
            SectionToggle(
              isSellSelected: isSellSelected,
              onToggle: _toggleSection,
            ),
            isSellSelected
                ? SellSection(
                    sellImagePaths: sellImagePaths,
                    selectedFilter: selectedFilter,
                    onFilterSelect: _selectFilter,
                  )
                : PostSection(
                    postImagePaths: postImagePaths,
                  ),
          ],
        ),
      ),
    );
  }
}
