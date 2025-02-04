import 'package:encryptonator/screens/encryption_screen.dart';
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
        CustomEncryptionScreen.screenId: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          return CustomEncryptionScreen(
              isEncryptNotDecrypt: args['isEncryptNotDecrypt']);
        },
      },
      initialRoute: WelcomeScreen.screenId,
    );
  }
}
