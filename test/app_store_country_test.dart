import 'package:flutter_test/flutter_test.dart';
import 'package:app_store_country/app_store_country.dart';
import 'package:app_store_country/app_store_country_platform_interface.dart';
import 'package:app_store_country/app_store_country_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppStoreCountryPlatform
    with MockPlatformInterfaceMixin
    implements AppStoreCountryPlatform {

  @override
  Future<String?> getCountryCode() => Future.value('USA');
}

void main() {
  final AppStoreCountryPlatform initialPlatform = AppStoreCountryPlatform.instance;

  test('$MethodChannelAppStoreCountry is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppStoreCountry>());
  });

  test('getPlatformVersion', () async {
    expect(await AppStoreCountry.getCountryCode(), 'USA');
  });
}
