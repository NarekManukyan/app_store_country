import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_store_country_platform_interface.dart';

/// An implementation of [AppStoreCountryPlatform] that uses method channels.
class MethodChannelAppStoreCountry extends AppStoreCountryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_store_country');

  @override
  Future<String?> getCountryCode() async {
    return methodChannel.invokeMethod<String>('getCountryCode');
  }
}
