// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:whats_up/info.dart';
import 'package:whats_up/widgets/my_message_card.dart';
import 'package:whats_up/widgets/sender_message_card.dart';

class ChartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (messages[index]['isMe'] == true) {
        return  MyMessageCard(
            message: messages[index]['text'].toString(),
            date: messages[index]['time'].toString(),
          );
        }
       return SenderMessageCard(
          message: messages[index]['text'].toString(),
          date: messages[index]['time'].toString(),
        );
      },
      itemCount: messages.length,
    );
  }
}
