// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';
import 'package:whats_up/common/repository/common_firebase_repo.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/features/auth/screens/otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/features/auth/screens/user_info_screen.dart';
import 'package:whats_up/models/user_model.dart';
import 'package:whats_up/screens/mobile_screen_layout.dart';

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

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

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

  void saveUserDatatoFirebase(
      {required String name,
      required File? profilePic,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUtl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
      if (profilePic != null) {
        photoUtl =
            await ref.read(commonFirebaseStorageRepoProvider).storeToFilestore(
                  "profilePic/$uid",
                  profilePic,
                );
      }
      var user = UserModel(
        groupId: [],
        isOnlie: true,
        name: name,
        phoneNumber: auth.currentUser!.uid,
        profilePic: photoUtl,
        uidl: uid,
      );
      //if the user collection is not there, it wil creae a user collection
      //but if it's already there, it will go to  doc(uid) and create a document there
      // where the properties  set(user.toMap())
      // so it's gonna change all the properties in the user model to an object format and save it to firebase

      await firestore.collection('users').doc(uid).set(user.toMap());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MobileScreenLayout(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    }
  }
}
