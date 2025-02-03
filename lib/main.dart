import 'package:encryptonator/screens/decrypt_screen.dart';
import 'package:encryptonator/screens/encrypt_screen.dart';
import 'package:encryptonator/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        WelcomeScreen.screenId: (context) => const WelcomeScreen(),
        EncryptScreen.screenId: (context) => const EncryptScreen(),
        DecryptScreen.screenId: (context) => const DecryptScreen(),
      },
      initialRoute: WelcomeScreen.screenId,
    );
  }
}
