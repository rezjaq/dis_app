import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/pages/account/form_sell.dart';
import 'package:dis_app/pages/account/change_profile.dart';
import 'dart:convert';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isSellSelected = true;
  List<String> sellImagePaths = [];
  List<String> postImagePaths = [];

  void _toggleSection(bool isSell) {
    setState(() {
      isSellSelected = isSell;
    });
  }

  void _showImageDialog(String imagePath) {
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UploadContentPage(
                      imagePath: imagePath,
                      onUpload: (String uploadedImagePath) {
                        setState(() {
                          sellImagePaths.add(uploadedImagePath);
                          isSellSelected =
                              true; // Optional: Keeps the selection on Sell
                        });
                        Navigator.of(context).pop();
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
                  isSellSelected = false; // Switch to Post section
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: const BoxDecoration(
                color: DisColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 20, right: 20, bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showImageDialog('assets/images/profile_2.jpg');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: const BoxDecoration(
                          color: DisColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/profile_2.jpg'),
                        ),
                      ),
                    ),
                    // Profile Info
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            "FAZA FIZI FUFU FAFA",
                            style: TextStyle(
                              color: DisColors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Followers and Following Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Followers
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text("1",
                                        style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 4),
                                    Text("Followers",
                                        style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              // Following
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text("12000",
                                        style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 4),
                                    Text("Following",
                                        style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Edit Profile and Upload Button Row
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/change-profile');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: DisColors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(DisSizes.sm),
                                  ),
                                ),
                                icon: const Icon(Icons.edit,
                                    color: DisColors.black),
                                label: const Text("Edit Profile",
                                    style: TextStyle(
                                        color: DisColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: _pickImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: DisColors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(DisSizes.sm),
                                  ),
                                ),
                                icon: const Icon(Icons.add,
                                    color: DisColors.black),
                                label: const Text("Upload",
                                    style: TextStyle(
                                        color: DisColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Toggle Sell/Post Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _toggleSection(true),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSellSelected
                              ? DisColors.primary
                              : DisColors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(DisSizes.xs),
                            bottomLeft: Radius.circular(DisSizes.xs),
                          ),
                          border: Border.all(
                            color: DisColors.primary,
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          "Sell",
                          style: TextStyle(
                              color: DisColors.black,
                              fontSize: DisSizes.fontSizeMd,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _toggleSection(false),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: !isSellSelected
                              ? DisColors.primary
                              : DisColors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(DisSizes.xs),
                            bottomRight: Radius.circular(DisSizes.xs),
                          ),
                          border: Border.all(
                            color: DisColors.darkGrey,
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          "Post",
                          style: TextStyle(
                              color: DisColors.black,
                              fontSize: DisSizes.fontSizeMd,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isSellSelected ? _buildSellSection() : _buildPostSection(),
          ],
        ),
      ),
    );
  }

  // Sell
  Widget _buildSellSection() {
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
        itemCount: sellImagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showImageDialog(sellImagePaths[index]),
            child: Container(
              color: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  File(sellImagePaths[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Post
  Widget _buildPostSection() {
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
            onTap: () => _showImageDialog(postImagePaths[index]),
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
}
