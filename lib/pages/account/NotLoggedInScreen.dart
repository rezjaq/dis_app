import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dis_app/utils/constants/colors.dart';

class NotLoggedInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'My Account',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/unlogin.svg',
                      height: 350,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Please log in to access the app's features, or register if you don't have an account yet.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: DisColors.darkerGrey),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: DisColors.primary, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: DisColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DisColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
