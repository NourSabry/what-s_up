import 'package:flutter/material.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/info.dart';
import 'package:whats_up/widgets/chat_list.dart';

class MobileChatScreen extends StatelessWidget {
  const MobileChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          info[0]['name'].toString(),
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
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.emoji_emotions, color: Colors.grey),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.camera_alt, color: Colors.grey),
                    Icon(Icons.attach_file, color: Colors.grey),
                    Icon(Icons.money_off, color: Colors.grey),
                  ],
                ),
              ),
              hintText: "Type a message",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  )),
              contentPadding: const EdgeInsets.all(10),
            ),
          )
        ],
      ),
    );
  }
}
