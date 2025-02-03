import 'package:encryptonator/environment.dart';
import 'package:encryptonator/services/encryption_service.dart';
import 'package:encryptonator/widgets/copiable_display.dart';
import 'package:flutter/material.dart';

class EncryptScreen extends StatefulWidget {
  static const screenId = 'home_screen';

  const EncryptScreen({super.key});

  @override
  State<EncryptScreen> createState() => _EncryptScreenState();
}

class _EncryptScreenState extends State<EncryptScreen> {
  late final EncryptionService encryptionService;

  final TextEditingController controller = TextEditingController();

  bool inDisplayMode = false;
  String? encryptedBase64;
  String? ivBase64;

  @override
  void initState() {
    super.initState();
    encryptionService = EncryptionService();
    print(Environment.encryptionKey);
    encryptionService.init(Environment.encryptionKey);
  }

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
        title: const Text('Encrypt-onator'),
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
                      ? MaterialButton(
                          onPressed: _encryptText,
                          color: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Encrypt',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          const Divider(),
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
