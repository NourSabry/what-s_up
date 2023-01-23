import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whats_up/colors.dart';
import 'package:whats_up/features/landing/screens/landing_screen.dart';
import 'package:whats_up/firebase_options.dart';
import 'package:whats_up/router.dart';

void main() async {
  //makes sue that flutter engine had been intialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: LandingScreen(),
    );
  }
}



// web       1:777332670415:web:4147ff882fa78a105f1cba
// android   1:777332670415:android:8af36ae0bd309e365f1cba
// ios       1:777332670415:ios:ffe871bb5e48fa455f1cba
// macos     1:777332670415:ios:ffe871bb5e48fa455f1cba