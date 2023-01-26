// ignore_for_file: unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/models/user_model.dart';

final selectContactRepoProvider = Provider(
  (ref) => SelectContactRepo(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepo {
  final FirebaseFirestore firestore;

  SelectContactRepo({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

//we're using a frgein loop, here we already have that codument thhat we will get by using [i] n the particular loop
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        print(selectedContact.phones[0].number);
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
