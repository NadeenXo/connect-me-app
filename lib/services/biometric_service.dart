import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> canAuthenticate() async {
    try {
      final canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

      final isDeviceSupported = await _localAuthentication.isDeviceSupported();

      return canCheckBiometrics && isDeviceSupported;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      final canUseBiometrics = await canAuthenticate();

      if (!canUseBiometrics) {
        return false;
      }

      return await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to open your profile',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      return false;
    }
  }
}
