import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whats_up/common/utils/utils.dart';

class UserInfoInformationScreen extends StatefulWidget {
  static const String routeName = '/user-information';
  const UserInfoInformationScreen({super.key});

  @override
  State<UserInfoInformationScreen> createState() =>
      _UserInfoInformationScreenState();
}

class _UserInfoInformationScreenState extends State<UserInfoInformationScreen> {
  final nameController = TextEditingController();
    File? image;


  void selectImage() async {
    image = await pickImageFromgallery(context);
    setState(() {
      
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                   image == null ? const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                    ),
                    radius: 64,
                  ) :  CircleAvatar(
                    backgroundImage: FileImage(image!),
                                        radius: 64,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(hintText: "Enter your name"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.done),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
