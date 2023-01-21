import 'package:flutter/material.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/responisve/responsive_layout.dart';
import 'package:whats_up/screens/mobile_screen_layout.dart';
import 'package:whats_up/screens/web_screen_layout.dart';

 void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whats-up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        backgroundColor: backgroundColor,
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
