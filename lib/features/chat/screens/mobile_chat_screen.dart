import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/common/widgets/loader.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';
import 'package:whats_up/features/calls/controller/call_controller.dart';
import 'package:whats_up/features/calls/screens/call_pickup_screen.dart';
import 'package:whats_up/features/chat/widgets/bottom_chat_field.dart';
import 'package:whats_up/models/user_model.dart';
import 'package:whats_up/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const routeName = '/mobile-chat';
  final String name;
  final String uid;
  final bool isGroup;
  final String profilePic;
  const MobileChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.isGroup,
    required this.profilePic,
  });

  void makeCall(
    WidgetRef ref,
    BuildContext context,
  ) {
    ref.read(callControllerProvider).makeCall(
          context,
          name,
          uid,
          '',
          isGroup,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          title: isGroup
              ? Text(name)
              : StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider).userDataById(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    return Column(
                      children: [
                        Text(name),
                        Text(
                          snapshot.data!.isOnline ? 'online' : 'offline',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  },
                ),
          actions: [
            IconButton(
              onPressed: () => makeCall(ref, context),
              icon: const Icon(Icons.video_call),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: isGroup,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: isGroup,
            ),
          ],
        ),
      ),
    );
  }
}
