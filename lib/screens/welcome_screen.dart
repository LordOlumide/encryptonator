import 'package:encryptonator/screens/encryption_screen.dart';
import 'package:encryptonator/widgets/action_button_1.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const screenId = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome to the Encrypt-onator',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'XOR Cipher',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              ActionButton1(
                text: 'Encrypt Text',
                onPressed: () => _onXOREncryptPressed(context, true),
              ),
              const SizedBox(height: 15),
              ActionButton1(
                text: 'Decrypt Text',
                onPressed: () => _onXOREncryptPressed(context, false),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _onXOREncryptPressed(BuildContext context, bool isEncryptNotDecrypt) {
    Navigator.pushNamed(
      context,
      CustomEncryptionScreen.screenId,
      arguments: {'isEncryptNotDecrypt': isEncryptNotDecrypt},
    );
  }
}
