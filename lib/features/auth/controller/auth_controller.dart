import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authrepo: authRepo);
});

class AuthController {
  final AuthRepo authrepo;

  AuthController({required this.authrepo});

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authrepo.signInWithPhone(context, phoneNumber);
  }

  void verifyOtp(BuildContext context, String verifcationId, String userOtp) {
    authrepo.verifyOtp(
      context: context,
      verficationId: verifcationId,
      userOtp: userOtp,
    );
  }
}
