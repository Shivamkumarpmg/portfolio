import 'dart:convert';
import 'package:encrypt/encrypt.dart';

import 'env.dart';


class Aes{
  late final _key = Key.fromUtf8(Env.aesKey);
  final mode = AESMode.cbc;
  final iv = IV.allZerosOfLength(16);

  dynamic aesEncrypted(dynamic data, {String? check}) {
    data =
    check == null ? jsonEncode(data) : data.toString().replaceAll(" ", "");
    final encrypter = Encrypter(AES(_key, mode: mode));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  dynamic aesDecrypted(var data) {
    var dt = Encrypted.from64(data);
    final encrypter = Encrypter(AES(_key, mode: mode));
    final decrypted = encrypter.decrypt(dt, iv: iv);
    return jsonDecode(decrypted);
  }
}