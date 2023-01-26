import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/features/auth/repository/auth_repository.dart';
import 'package:whats_up/models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(
    authrepo: authRepo,
    ref: ref,
  );
});

final userDataAuthProvider = FutureProvider((ref) {
  final authContrller = ref.watch(authControllerProvider);
  return authContrller.getUserData();
});

class AuthController {
  final AuthRepo authrepo;
  final ProviderRef ref;

  AuthController({required this.authrepo, required this.ref});

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authrepo.signInWithPhone(context, phoneNumber);
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await authrepo.getCurrentUserData();
    return user;
  }

  void verifyOtp(BuildContext context, String verifcationId, String userOtp) {
    authrepo.verifyOtp(
      context: context,
      verficationId: verifcationId,
      userOtp: userOtp,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authrepo.saveUserDatatoFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }
}
