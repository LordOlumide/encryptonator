import 'package:encryptonator/services/encryption_service.dart';
import 'package:encryptonator/widgets/action_button_1.dart';
import 'package:encryptonator/widgets/copiable_display.dart';
import 'package:flutter/material.dart';

class DecryptScreen extends StatefulWidget {
  static const screenId = 'decrypt_screen';

  const DecryptScreen({super.key});

  @override
  State<DecryptScreen> createState() => _DecryptScreenState();
}

class _DecryptScreenState extends State<DecryptScreen> {
  final EncryptionService encryptionService = EncryptionService();

  final TextEditingController encryptedController = TextEditingController();
  final TextEditingController ivController = TextEditingController();

  bool inDisplayMode = false;
  String? decryptedText;

  @override
  void dispose() {
    encryptedController.dispose();
    ivController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text('Encrypt-onator'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    'Enter the encrypted Base64 text for decryption here:',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: encryptedController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (_) {
                      if (inDisplayMode == true) {
                        _deactivateDisplayMode();
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Enter the Initialization Vector (IV) for decryption here:',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: ivController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (_) {
                      if (inDisplayMode == true) {
                        _deactivateDisplayMode();
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  !inDisplayMode
                      ? ActionButton1(text: 'Decrypt', onPressed: _decryptText)
                      : const SizedBox.shrink(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.purple),
          if (inDisplayMode && decryptedText != null)
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Decrypted text:',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    CopiableDisplay(text: decryptedText!),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  void _decryptText() {
    setState(() {
      decryptedText = encryptionService.decryptData(
        encryptedBase64: encryptedController.text,
        ivBase64: ivController.text,
      );
      inDisplayMode = true;
    });
  }

  void _deactivateDisplayMode() {
    setState(() {
      decryptedText = null;
      inDisplayMode = false;
    });
  }
}
