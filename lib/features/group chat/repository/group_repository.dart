// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_up/common/repository/common_firebase_repo.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/models/group.dart' as model;

final groupRepositoryProvider = Provider(
  (ref) => GroupRepoistory(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class GroupRepoistory {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  GroupRepoistory({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void createGroup(
    BuildContext context,
    String name,
    File profilePic,
    List<Contact> selectedContacts,
  ) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContacts.length; i++) {
        var userCollection = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: selectedContacts[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .get();
        if ( userCollection.docs.isNotEmpty &&  userCollection.docs[0].exists) {
          uids.add(userCollection.docs[0].data()['uid']);
        }
      }

      var groupId = const Uuid().v1();
      String profileUrl =
          await ref.read(commonFirebaseStorageRepoProvider).storeToFilestore(
                'group/$groupId',
                profilePic,
              );
      model.Group group = model.Group(
        senderId: auth.currentUser!.uid,
        name: name,
        groupId: groupId,
        lastMessage: '',
        groupPic: profileUrl,
        membersUid: [auth.currentUser!.uid, ...uids],
        timeSent: DateTime.now(),
      );

      await firestore.collection('groups').doc(groupId).set(group.toMap());
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    }
  }
}
