// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/common/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_up/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Welcome to What's up",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height / 9),
            SvgPicture.asset(
              "assets/chat.svg",
              height: 340,
              width: 340,
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Read our Privacy Policy, Tap 'Agree and continue' to accept the terms of service ",
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: "Welcome to what's Up",
                function: () => navigateToLoginScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
