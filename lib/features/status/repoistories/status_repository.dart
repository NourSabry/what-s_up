// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_up/common/repository/common_firebase_repo.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/models/status.dart';
import 'package:whats_up/models/user_model.dart';



final statusRepositoryProvider = Provider(
  (ref) => StatusRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class StatusRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  StatusRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void uploadState({
    required String userName,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
    required BuildContext context,
  }) async {
    try {
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;
       String imageurl = await ref
          .read(commonFirebaseStorageRepoProvider)
          .storeToFilestore(
            '/status/$statusId$uid',
            statusImage,
          );

      List<Contact> contacts = [];

      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }

      List<String> uidwhoCanSee = [];
      for (int i = 0; i < contacts.length; i++) {
        var userDataFireBase = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: contacts[i].phones[0].number.replaceAll(' ', ''),
            )
            .get();

        if (userDataFireBase.docs.isNotEmpty) {
          var userData = UserModel.fromMap(userDataFireBase.docs[0].data());
          uidwhoCanSee.add(userData.uid);
        }
      }

      List<String> statusImageUrls = [];
      var statusSnapShot = await firestore
          .collection('status')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .get();

      if (statusSnapShot.docs.isNotEmpty) {
        Status status = Status.fromMap(statusSnapShot.docs[0].data());
        statusImageUrls = status.photoUrl;
        statusImageUrls.add(imageurl);
        await firestore
            .collection('status')
            .doc(statusSnapShot.docs[0].id)
            .update(
          {
            'photoUrl': statusImageUrls,
          },
        );
        return;
      } else {
        statusImageUrls = [imageurl];
      }
      Status status = Status(
        uid: uid,
        userName: userName,
        phoneNumber: phoneNumber,
        profilePic: profilePic,
        statusId: statusId,
        photoUrl: statusImageUrls,
        whoCanSee: uidwhoCanSee,
        createAt: DateTime.now(),
      );

      await firestore.collection('status').doc(statusId).set(
            status.toMap(),
          );
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    }
  }
}
