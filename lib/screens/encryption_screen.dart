import 'package:encryptonator/services/custom_encryption_service.dart';
import 'package:encryptonator/widgets/action_button_1.dart';
import 'package:encryptonator/widgets/copiable_display.dart';
import 'package:flutter/material.dart';

class CustomEncryptionScreen extends StatefulWidget {
  static const String screenId = 'xor_screen';

  final bool isEncryptNotDecrypt;

  const CustomEncryptionScreen({super.key, required this.isEncryptNotDecrypt});

  @override
  State<CustomEncryptionScreen> createState() => _CustomEncryptionScreenState();
}

class _CustomEncryptionScreenState extends State<CustomEncryptionScreen> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  bool inDisplayMode = false;
  String? resultText;

  @override
  void dispose() {
    textController.dispose();
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEncrypt = widget.isEncryptNotDecrypt;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: Text('XOR ${isEncrypt ? 'Encryption' : 'Decryption'}'),
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
                  Text(
                    isEncrypt
                        ? 'Enter the plain text here:'
                        : 'Enter the cipher text here:',
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: textController,
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
                    'Enter the secret key here:',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: keyController,
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
                      ? ActionButton1(
                          text: isEncrypt ? 'Encrypt' : 'Decrypt',
                          onPressed: _convertText,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.purple),
          if (inDisplayMode && resultText != null)
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      isEncrypt ? 'Encrypted text:' : 'Decrypted text:',
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    CopiableDisplay(text: resultText!),
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

  void _convertText() {
    setState(() {
      if (widget.isEncryptNotDecrypt) {
        resultText = CustomEncryptionService.encrypt(
          data: textController.text,
          secret: keyController.text,
        );
      } else {
        resultText = CustomEncryptionService.decrypt(
          data: textController.text,
          secret: keyController.text,
        );
      }
      print(resultText);
      inDisplayMode = true;
    });
  }

  void _deactivateDisplayMode() {
    setState(() {
      resultText = null;
      inDisplayMode = false;
    });
  }
}
