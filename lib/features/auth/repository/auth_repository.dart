// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/features/auth/screens/otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/features/auth/screens/user_info_screen.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepo(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepo({
    required this.auth,
    required this.firestore,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            OtpScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verficationId,
    required String userOtp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationId,
        smsCode: userOtp,
      );
      await auth.signInWithCredential(credential);
      // we won't be able to go back cause the stat would be removed after e finish here
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoInformationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context: context,
        content: e.message!,
      );
    }
  }
}
