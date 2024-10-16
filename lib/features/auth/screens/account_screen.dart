import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    List<Color> colors = [Colors.red, Colors.green, Colors.blue]; // Dummy list
    List<Color> favoriteColors = [Colors.orange, Colors.purple, Colors.yellow];
    List<Color> collectionColors = [Colors.brown, Colors.cyan, Colors.pink];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                padding: const EdgeInsets.only(top: 56, left: 20, right: 20, bottom: 32),
                child: Container(
                  width: double.infinity,
                  height: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: DisColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/dummies/content.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Aminah", style: TextStyle(color: DisColors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                padding: const EdgeInsets.all(DisSizes.sm),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "1,208",
                                          style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Followers",
                                          style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "1,208",
                                          style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: DisColors.white,
                                      borderRadius: BorderRadius.circular(DisSizes.sm),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, color: DisColors.black),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: DisColors.white,
                                      borderRadius: BorderRadius.circular(DisSizes.sm),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add, color: DisColors.black),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Upload",
                                          style: TextStyle(
                                            color: DisColors.black,
                                            fontSize: 12,
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
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectedIndex = 0;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0 ? DisColors.primary : DisColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(DisSizes.xs),
                          bottomLeft: Radius.circular(DisSizes.xs),
                        ),
                        border: Border.all(
                          color: DisColors.primary,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Sell",
                        style: TextStyle(
                          color: DisColors.black,
                          fontSize: DisSizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectedIndex = 1;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1 ? DisColors.primary : DisColors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(DisSizes.xs),
                          bottomRight: Radius.circular(DisSizes.xs),
                        ),
                        border: Border.all(
                          color: DisColors.darkGrey,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: DisColors.black,
                          fontSize: DisSizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
              ),
              itemCount: _selectedIndex == 0 ? colors.length : _selectedIndex == 1 ? favoriteColors.length : collectionColors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print('Color: ${_selectedIndex == 0 ? colors[index] : _selectedIndex == 1 ? favoriteColors[index] : collectionColors[index]}');
                  },
                  child: Container(
                    color: _selectedIndex == 0 ? colors[index] : _selectedIndex == 1 ? favoriteColors[index] : collectionColors[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}