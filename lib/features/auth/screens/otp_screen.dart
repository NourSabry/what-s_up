import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';

class OtpScreen extends ConsumerWidget {
  static const routeName = "/otp-screen";
  final String verficationId;

  const OtpScreen({super.key, required this.verficationId});

  void verifyOtp(WidgetRef ref, BuildContext context, String userOtp) {
    ref.read(authControllerProvider).verifyOtp(
          context,
          verficationId,
          userOtp,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Verifying your number"),
        backgroundColor: backgroundColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("We have sent an sms to your phone"),
          SizedBox(
            width: size.height * 0.5,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "- - - - - -",
                hintStyle: TextStyle(fontSize: 30),
              ),
              keyboardType: TextInputType.number,
              onChanged: ((value) {
                if (value.length == 6) {
                  verifyOtp(ref, context , value.trim());
                } 
              }),
            ),
          ),
        ],
      ),
    );
  }
}
