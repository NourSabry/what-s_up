// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:whats_up/common/widgets/error.dart';
import 'package:whats_up/features/auth/screens/login_screen.dart';
import 'package:whats_up/features/auth/screens/otp_screen.dart';
import 'package:whats_up/features/auth/screens/user_info_screen.dart';
import 'package:whats_up/features/contacts/screens/select_contact_screen.dart';
import 'package:whats_up/features/chat/screens/mobile_chat_screen.dart';

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
    case UserInfoInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => UserInfoInformationScreen(),
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => SelectContactsScreen(),
      );

    case MobileChatScreen.routeName:
      final arguemnts = settings.arguments as Map<String, dynamic>;
      final name = arguemnts['name'];
      final uid = arguemnts['uid'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
        ),
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
