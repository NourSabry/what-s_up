// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whats_up/features/group%20chat/repository/group_repository.dart';

final groupControllerProvider = Provider((ref) {
  final groupRepoistory = ref.read(groupRepositoryProvider);
  return GroupController(
    groupRepoistory: groupRepoistory,
    ref: ref,
  );
});

class GroupController {
  final GroupRepoistory groupRepoistory;
  final ProviderRef ref;
  GroupController({
    required this.groupRepoistory,
    required this.ref,
  });

  void createGroup(
    BuildContext context,
    String name,
    File profilePic,
    List<Contact> selectedContacts,
  ) {
    groupRepoistory.createGroup(context, name, profilePic, selectedContacts);
  }
}
