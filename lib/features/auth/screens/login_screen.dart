// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/common/utils/utils.dart';
import 'package:whats_up/common/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
    final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

 

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Enter your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text("Whats up will need to verify your phone number"),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: pickCountry,
                    child: const Text("Pick Country"),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      if (country != null)
                        Text(
                          '+${country!.phoneCode}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            hintText: 'phone number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.3),
                    child: CustomButton(
                      text: "next",
                      function: sendPhoneNumber,
                    ),
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
