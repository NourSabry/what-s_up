import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_up/common/enums/message_enum.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/models/chat_contact.dart';
import 'package:whats_up/models/message.dart';
import 'package:whats_up/models/user_model.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void saveDataToContactsSubCollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    var recieverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    //go to firestore, go to users, with the reciever id go to the rceiver chat, and
    //finally save our chat there
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(
          recieverChatContact.toMap(),
        );

    var senderChatContact = ChatContact(
      name: recieverUserData.name,
      profilePic: recieverUserData.profilePic,
      contactId: recieverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubCollection({
    required String receiverUderId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String userName,
    required String receiverUserName,
    required MessageEnum messageType,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverId: receiverUderId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUderId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

//if we want to do a unit testing we should't make it like that insead,
//we'll have to make it future
  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);

// it will generate uuid based on time
      var messageId = const Uuid().v1();
      saveDataToContactsSubCollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        recieverUserId,
      );

      _saveMessageToMessageSubCollection(
        receiverUderId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        userName: senderUser.name,
        receiverUserName: recieverUserData.name,
        messageType: MessageEnum.text,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
