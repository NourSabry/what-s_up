// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/common/enums/message_enum.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';
import 'package:whats_up/features/chat/repoistories/chat_repository.dart';
import 'package:whats_up/models/chat_contact.dart';
import 'package:whats_up/models/message.dart';

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

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatrepo.getChatStream(recieverUserId);
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

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatrepo.sendFileMessage(
            context: context,
            file: file,
            receiverId: recieverUserId,
            senderUser: value!,
            messageEnum: messageEnum,
            ref: ref,
          ),
        );
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String recieverUserId,
  ) {
     int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    ref.read(userDataAuthProvider).whenData(
          (value) => chatrepo.sendgifMessage(
            context: context,
            gifUrl: newgifUrl,
            recieverUserId: recieverUserId,
            senderUser: value!,
          ),
        );
  }
}
