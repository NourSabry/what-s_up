// ignore_for_file: use_key_in_widget_constructors

import 'package:audioplayers/audioplayers.dart';
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
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    final size = MediaQuery.of(context).size;
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(
              builder: (context  , setState) {
             return IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () async {
                    if(isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                         isPlaying = false;
                      });
                    } else {
                      await audioPlayer.play(UrlSource(message));
                           setState(() {
                         isPlaying = true;
                      });
                    }
                  },
                  icon:   Icon(
                isPlaying ? Icons.pause_circle :    Icons.play_circle,
                    size: 30,
                  ),
                  constraints: BoxConstraints(
                    minWidth: size.width / 0.9,
                
                  ),
              
                );
              }
            )
            : type == MessageEnum.video
                ? VideoPlayerItem(videoUrl: message)
                : type == MessageEnum.gif
                    ? CachedNetworkImage(imageUrl: message)
                    : CachedNetworkImage(imageUrl: message);
  }
}
