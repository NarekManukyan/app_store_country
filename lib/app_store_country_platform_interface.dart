import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_store_country_method_channel.dart';

abstract class AppStoreCountryPlatform extends PlatformInterface {
  /// Constructs a AppStoreCountryPlatform.
  AppStoreCountryPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppStoreCountryPlatform _instance = MethodChannelAppStoreCountry();

  /// The default instance of [AppStoreCountryPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppStoreCountry].
  static AppStoreCountryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppStoreCountryPlatform] when
  /// they register themselves.
  static set instance(AppStoreCountryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getCountryCode() {
    throw UnimplementedError('getCountryCode() has not been implemented.');
  }
}
