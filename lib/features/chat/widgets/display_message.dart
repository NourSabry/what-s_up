// ignore_for_file: use_key_in_widget_constructors

import 'package:whats_up/common/enums/message_enum.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:whats_up/features/chat/widgets/video_player_item.dart';

class DisplayMessage extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayMessage({
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(videoUrl: message)
            : type == MessageEnum.gif
                ? CachedNetworkImage(imageUrl: message)
                : CachedNetworkImage(imageUrl: message);
  }
}
