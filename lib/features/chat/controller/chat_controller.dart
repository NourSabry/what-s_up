// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';
import 'package:whats_up/features/chat/repoistories/chat_repository.dart';
import 'package:whats_up/models/chat_contact.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepo = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatrepo: chatRepo,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatrepo;
  final ProviderRef ref;
  ChatController({
    required this.chatrepo,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatrepo.getChatContacts();
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatrepo.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!,
          ),
        );
  }
}
