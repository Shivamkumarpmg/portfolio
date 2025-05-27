import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'AesKey', obfuscate: true)
  static final String aesKey = _Env.aesKey;
}
