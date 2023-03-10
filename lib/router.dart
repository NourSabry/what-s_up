// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whats_up/common/widgets/error.dart';
import 'package:whats_up/features/auth/screens/login_screen.dart';
import 'package:whats_up/features/auth/screens/otp_screen.dart';
import 'package:whats_up/features/auth/screens/user_info_screen.dart';
import 'package:whats_up/features/contacts/screens/select_contact_screen.dart';
import 'package:whats_up/features/chat/screens/mobile_chat_screen.dart';
import 'package:whats_up/features/group%20chat/screens/create_group_screen.dart';
import 'package:whats_up/features/status/screens/confirm_status_screen.dart';
import 'package:whats_up/features/status/screens/status_screen.dart';
import 'package:whats_up/models/status.dart';

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
      final isGroupChat = arguemnts['isGroupChat'];
      final profilePic = arguemnts['profilePic'];

      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
          isGroup: isGroupChat,
          profilePic: profilePic,
        ),
      );
    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );
    case StatusScreen.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
        builder: (context) => StatusScreen(
          status: status,
        ),
      );
    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => CreateGroupScreen(),
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
