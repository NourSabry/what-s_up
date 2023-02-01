import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 import 'package:whats_up/common/widgets/loader.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';
import 'package:whats_up/features/chat/widgets/bottom_chat_field.dart';
import 'package:whats_up/models/user_model.dart';
import 'package:whats_up/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const routeName = '/mobile-chat';
  final String name;
  final String uid;
  const MobileChatScreen({super.key, required this.name, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return Column(
              children: [

                Text(name),
                 Text(
                  snapshot.data!.isOnline ?
                   'online' 
                   : 'offline'
                   ,
                  style: const  TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChartList(),
          ),
          BottomChatField()
        ],
      ),
    );
  }
}