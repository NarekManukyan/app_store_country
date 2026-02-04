import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_store_country/app_store_country_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAppStoreCountry platform = MethodChannelAppStoreCountry();
  const MethodChannel channel = MethodChannel('app_store_country');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return 'USA';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getCountryCode', () async {
    expect(await platform.getCountryCode(), 'USA');
  });
}
