import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/common/widgets/error.dart';
import 'package:whats_up/common/widgets/loader.dart';
import 'package:whats_up/features/auth/controller/auth_controller.dart';
import 'package:whats_up/features/landing/screens/landing_screen.dart';
import 'package:whats_up/firebase_options.dart';
import 'package:whats_up/router.dart';
import 'package:whats_up/screens/mobile_chat_screen.dart';

void main() async {
  //makes sue that flutter engine had been intialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Whats-up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return LandingScreen();
              }
              return const MobileChatScreen();
            },
            error: (err, trace) {
              return ErrorScreen(
                error: err.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}



// web       1:777332670415:web:4147ff882fa78a105f1cba
// android   1:777332670415:android:8af36ae0bd309e365f1cba
// ios       1:777332670415:ios:ffe871bb5e48fa455f1cba
// macos     1:777332670415:ios:ffe871bb5e48fa455f1cba