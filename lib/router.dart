import 'package:flutter/material.dart';
import 'package:whats_up/common/widgets/error.dart';
import 'package:whats_up/features/auth/screens/login_screen.dart';
import 'package:whats_up/features/auth/screens/otp_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OtpScreen.routeName:
      final verficationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OtpScreen(verficationId: verficationId),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(
            error: "this page does not exist",
          ),
        ),
      );
  }
}
