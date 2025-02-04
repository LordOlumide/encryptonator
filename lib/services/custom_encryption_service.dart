import 'dart:convert' show base64Url;

abstract final class CustomEncryptionService {
  // Caesar cipher shift value
  static const int shift = 13;

  static String encrypt({required String data, required String secret}) {
    assert(secret != '', 'Secret cannot be empty string');
    if (data == '') return '';

    final sourceCodes = data.codeUnits;
    final secretCodes = secret.codeUnits;
    final sourceLength = sourceCodes.length;
    final secretLength = secretCodes.length;

    // Perform XOR operation
    List<int> encoded = List.generate(
      sourceLength,
      (i) => sourceCodes[i] ^ secretCodes[i % secretLength],
      growable: false,
    );

    // Apply Caesar cipher shift
    List<int> shifted = List.generate(
      encoded.length,
      (i) => encoded[i] + shift,
      growable: false,
    );

    return base64Url.encode(shifted);
  }

  static String decrypt({required String data, required String secret}) {
    assert(secret != '', 'Secret cannot be empty string');
    if (data == '') return '';

    final sourceCodes = base64Url.decode(base64Url.normalize(data));
    final secretCodes = secret.codeUnits;
    final sourceLength = sourceCodes.length;
    final secretLength = secretCodes.length;

    // Reverse Caesar cipher shift
    List<int> unshifted = List.generate(
      sourceLength,
      (i) => sourceCodes[i] - shift,
      growable: false,
    );

    // Perform XOR operation
    List<int> decoded = List.generate(
      sourceLength,
      (i) => unshifted[i] ^ secretCodes[i % secretLength],
      growable: false,
    );

    return String.fromCharCodes(decoded);
  }
}
