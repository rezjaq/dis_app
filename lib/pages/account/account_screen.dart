import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'dart:io';

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
                setState(() {
                  sellImagePaths.add(imagePath);
                  isSellSelected = true;
                });
                Navigator.of(context).pop();
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
            Container(
              width: double.infinity,
              height: DisHelperFunctions.screenHeight(context) * 0.300,
              decoration: const BoxDecoration(
                color: DisColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
              padding: const EdgeInsets.only(
                top: DisSizes.appBarHeight - 12,
                left: DisSizes.lg,
                right: DisSizes.md,
                bottom: DisSizes.lg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: DisHelperFunctions.screenWidth(context) * 0.3,
                    height: DisHelperFunctions.screenWidth(context) * 0.3,
                    decoration: BoxDecoration(
                      color: DisColors.white,
                      borderRadius: BorderRadius.circular(
                          DisHelperFunctions.screenWidth(context) * 0.3),
                      border: Border.all(
                        color: DisColors.white,
                        width: 1.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          DisHelperFunctions.screenWidth(context) * 0.3),
                      child: Image.asset(
                        'assets/images/profile_2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: DisHelperFunctions.screenWidth(context) * 0.55,
                    height: DisHelperFunctions.screenHeight(context) * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "steffanie_joe_brown",
                          style: TextStyle(
                            color: DisColors.black,
                            fontSize: DisSizes.fontSizeLg,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: DisSizes.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "1,234",
                                  style: TextStyle(
                                    color: DisColors.black,
                                    fontSize: DisSizes.lg,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                    color: DisColors.black,
                                    fontSize: DisSizes.fontSizeXs,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "1,234",
                                  style: TextStyle(
                                    color: DisColors.black,
                                    fontSize: DisSizes.lg,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Following",
                                  style: TextStyle(
                                    color: DisColors.black,
                                    fontSize: DisSizes.fontSizeXs,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: DisSizes.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                DisHelperFunctions.navigateToRoute(
                                    context, '/change-profile');
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: DisSizes.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: DisColors.white,
                                  borderRadius: BorderRadius.circular(
                                      DisSizes.buttonRadius),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: DisSizes.iconSm,
                                      color: DisColors.black,
                                    ),
                                    const SizedBox(width: DisSizes.xs),
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        color: DisColors.black,
                                        fontSize: DisSizes.fontSizeXs,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _pickImage();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: DisSizes.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: DisColors.white,
                                  borderRadius: BorderRadius.circular(
                                      DisSizes.buttonRadius),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: DisSizes.iconSm,
                                      color: DisColors.black,
                                    ),
                                    const SizedBox(width: DisSizes.xs),
                                    Text(
                                      "Upload",
                                      style: TextStyle(
                                        color: DisColors.black,
                                        fontSize: DisSizes.fontSizeXs,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DisSizes.md,
                vertical: DisSizes.md,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _toggleSection(true),
                    child: Container(
                      alignment: Alignment.center,
                      width: DisHelperFunctions.screenWidth(context) * 0.45,
                      padding: const EdgeInsets.symmetric(
                        horizontal: DisSizes.md,
                        vertical: DisSizes.sm,
                      ),
                      decoration: BoxDecoration(
                        color: isSellSelected
                            ? DisColors.primary
                            : DisColors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(DisSizes.buttonRadius),
                        ),
                        border: Border.all(
                          color: DisColors.primary,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "Sell",
                        style: TextStyle(
                          color: DisColors.black,
                          fontSize: DisSizes.fontSizeSm,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleSection(false),
                    child: Container(
                      alignment: Alignment.center,
                      width: DisHelperFunctions.screenWidth(context) * 0.45,
                      padding: const EdgeInsets.symmetric(
                        horizontal: DisSizes.md,
                        vertical: DisSizes.sm,
                      ),
                      decoration: BoxDecoration(
                        color: isSellSelected
                            ? DisColors.white
                            : DisColors.primary,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(DisSizes.buttonRadius),
                        ),
                        border: Border.all(
                          color: DisColors.primary,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: DisColors.black,
                          fontSize: DisSizes.fontSizeSm,
                          fontWeight: FontWeight.w500,
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

  Widget _buildSellSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 16.0,
              top: 5.0,
              right: 5.0,
              bottom: 5.0), // Added left padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildFilterButton("All", SellFilter.all),
              _buildFilterButton("Available", SellFilter.available),
              _buildFilterButton("Sold", SellFilter.sold),
            ],
          ),
        ),
        Padding(
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
        ),
      ],
    );
  }

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

  Widget _buildFilterButton(String label, SellFilter filter) {
    final isSelected = selectedFilter == filter;
    return GestureDetector(
      onTap: () => _selectFilter(filter),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? DisColors.primary : DisColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: DisColors.primary,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? DisColors.black : DisColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
