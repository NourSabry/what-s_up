import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';
import 'package:whats_up/features/calls/repository/call_repository.dart';
import 'package:whats_up/models/call.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.read(callRepositoryProvider);
  return CallController(
    callRepository: callRepository,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class CallController {
  final CallRepository callRepository;
  final ProviderRef ref;
  final FirebaseAuth auth;
  CallController({
    required this.callRepository,
    required this.ref,
    required this.auth,
  });

  Stream<DocumentSnapshot> get callStream => callRepository.callStream;
  void makeCall(
    BuildContext context,
    String recieverName,
    String receiverUserId,
    String reciverProfilePic,
    bool isGroupChat,
  ) {
    String callId = const Uuid().v1();
    ref.read(userDataAuthProvider).whenData((value) {
      Call senderCallData = Call(
        callerId: auth.currentUser!.uid,
        callerName: value!.name,
        callerPic: value.profilePic,
        receiverId: receiverUserId,
        receiverName: recieverName,
        receiverPic: reciverProfilePic,
        callId: callId,
        hasDialled: true,
      );

      Call recieverCallData = Call(
        callerId: auth.currentUser!.uid,
        callerName: value.name,
        callerPic: value.profilePic,
        receiverId: receiverUserId,
        receiverName: recieverName,
        receiverPic: reciverProfilePic,
        callId: callId,
        hasDialled: false,
      );

      callRepository.makeCall(
        senderCallData,
        context,
        recieverCallData,
      );
    });
  }


    void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) {
    callRepository.endCall(callerId, receiverId, context);
  }
}
