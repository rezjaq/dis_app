import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FindMeScreen extends StatelessWidget {
  const FindMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of 33 colors
    final List<Color> colors = [
      Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange,
      Colors.purple, Colors.pink, Colors.brown, Colors.cyan, Colors.lime,
      Colors.indigo, Colors.teal, Colors.amber, Colors.deepOrange, Colors.deepPurple,
      Colors.lightBlue, Colors.lightGreen, Colors.limeAccent, Colors.orangeAccent, Colors.pinkAccent,
      Colors.purpleAccent, Colors.redAccent, Colors.tealAccent, Colors.yellowAccent, Colors.blueAccent,
      Colors.greenAccent, Colors.indigoAccent, Colors.cyanAccent, Colors.amberAccent, Colors.brown[300]!,
      Colors.grey, Colors.blueGrey, Colors.black,
    ];

    return Scaffold(
      backgroundColor: DisColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: DisColors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find Me',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Find your photo here',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(DisSizes.sm),
                                decoration: BoxDecoration(
                                  color: DisColors.white,
                                  borderRadius: BorderRadius.circular(DisSizes.sm),
                                  border: Border.all(
                                    color: DisColors.primary,
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: DisColors.primary,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Search...',
                                        style: TextStyle(
                                          color: DisColors.darkGrey,
                                          fontSize: DisSizes.fontSizeSm,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.shopping_cart, color: DisColors.primary),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/robot_2.svg',
                                color: DisColors.primary,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(onPressed: () {}, child: Text("All", style: TextStyle(color: DisColors.primary))),
                        TextButton(onPressed: () {}, child: Text("Favorites", style: TextStyle(color: DisColors.black))),
                        TextButton(onPressed: () {}, child: Text("Collections", style: TextStyle(color: DisColors.black))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.125,
              child: Padding(
                padding: const EdgeInsets.all(DisSizes.xs),
                child: Container(
                  width: MediaQuery.of(context).size.width - 2 * DisSizes.xs,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
                    ),
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: colors[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}