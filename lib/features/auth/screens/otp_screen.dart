import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = "/otp-screen";
  final String verficationId;


  const OtpScreen({super.key , required this.verficationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
