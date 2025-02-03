import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();

  EncryptionService._internal();

  factory EncryptionService() {
    return _instance;
  }

  late encrypt.Key _key;

  void init(String keyString) {
    _key = encrypt.Key.fromUtf8(keyString);
  }

  // The decryption process must use the same Initialization Vector that was used during encryption.
  // However, the IV does not need to be kept secret. It can be safely stored or
  // transmitted along with the ciphertext.

  (String ivBase64, String encryptedBase64) encryptData(String plainText) {
    final iv = encrypt.IV.fromLength(16); // Generate a random IV
    final encrypter = encrypt.Encrypter(encrypt.AES(_key!));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final ivBase64 = iv.base64;
    final encryptedBase64 = encrypted.base64;

    return (ivBase64, encryptedBase64);
  }

  String decryptData({
    required String encryptedBase64,
    required String ivBase64,
  }) {
    final iv = encrypt.IV.fromBase64(ivBase64); // Extract the IV
    final encrypted = encrypt.Encrypted.fromBase64(encryptedBase64);

    final encrypter = encrypt.Encrypter(encrypt.AES(_key!));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return decrypted;
  }
}
