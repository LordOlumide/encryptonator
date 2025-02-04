import 'package:encryptonator/archive/aes_encryption_service.dart';
import 'package:encryptonator/widgets/action_button_1.dart';
import 'package:encryptonator/widgets/copiable_display.dart';
import 'package:flutter/material.dart';

class AESEncryptScreen extends StatefulWidget {
  static const screenId = 'home_screen';

  const AESEncryptScreen({super.key});

  @override
  State<AESEncryptScreen> createState() => _AESEncryptScreenState();
}

class _AESEncryptScreenState extends State<AESEncryptScreen> {
  final AESEncryptionService encryptionService = AESEncryptionService();

  final TextEditingController controller = TextEditingController();

  bool inDisplayMode = false;
  String? encryptedBase64;
  String? ivBase64;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text('AES Encryption'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    'Enter the text for encryption here:',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: controller,
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
                  ),
                  const SizedBox(height: 30),
                  !inDisplayMode
                      ? ActionButton1(text: 'Encrypt', onPressed: _encryptText)
                      : const SizedBox.shrink(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.purple),
          if (inDisplayMode && (encryptedBase64 != null && ivBase64 != null))
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Encrypted text in Base64:',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    CopiableDisplay(text: encryptedBase64!),
                    const SizedBox(height: 30),
                    const Text(
                      'Initialization Vector (IV) in Base64:',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    CopiableDisplay(text: ivBase64!),
                    const SizedBox(height: 20),
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

  void _encryptText() {
    late final String ivBase64Temp;
    late final String encryptedBase64Temp;
    (ivBase64Temp, encryptedBase64Temp) =
        encryptionService.encryptData(controller.text);

    setState(() {
      ivBase64 = ivBase64Temp;
      encryptedBase64 = encryptedBase64Temp;
      inDisplayMode = true;
    });
  }

  void _deactivateDisplayMode() {
    setState(() {
      ivBase64 = null;
      encryptedBase64 = null;
      inDisplayMode = false;
    });
  }
}
