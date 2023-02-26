import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';

void showSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImageFromgallery(BuildContext context) async {
  File? image;

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<File?> pickVideoFromgallery(BuildContext context) async {
  File? video;

  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

Future<GiphyGif?> pickGif(BuildContext context) async {
  GiphyGif? gif;
  try {
    await Giphy.getGif(
        context: context, apiKey: 'QucnPt5hhL4cLntTpJk9mPWggIPc1MaT');
  } catch (e) {
    showSnackBar(
      context: context,
      content: extensionStreamHasListener.toString(),
    );
  }
  return gif;
}


 
//   async: ^2.9.0
  // collection: ^1.16.0
  // connectivity_plus: ^2.3.9
  // fixnum: ^1.0.1
  // meta: ^1.8.0
  // http: ^0.13.5
  // logging: ^1.1.0
  // uuid: ^3.0.6
  // synchronized: ^3.0.0+3
  // protobuf: ^2.1.0
  // flutter_webrtc: 0.9.18
  // dart_webrtc: 1.0.12
  // device_info_plus: ^6.0.0
  // webrtc_interface: 1.0.10