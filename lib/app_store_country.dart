import 'dart:io';

import 'package:flutter/services.dart';

import 'app_store_country_platform_interface.dart';

class AppStoreCountry {
  static final Set<String> _defaultExternalPaymentSupportedCountries = <String>{
    'USA',
  };

  static Set<String> _externalPaymentSupportedCountries =
      Set<String>.from(_defaultExternalPaymentSupportedCountries);

  /// Returns the App Store storefront country code (ISO-3166 alpha-3).
  ///
  /// Example: "USA", "GBR", "DEU"
  ///
  /// Returns null if storefront is unavailable or on non-iOS platforms (e.g.
  /// Android). On Android, the plugin does not throw; callers get null and can
  /// treat it as "no App Store storefront" (e.g. use in-app purchase or other
  /// logic).
  static Future<String?> getCountryCode() async {
    if (!Platform.isIOS) {
      return null;
    }

    try {
      return await AppStoreCountryPlatform.instance.getCountryCode();
    } on PlatformException {
      return null;
    }
  }

  /// Convenience helper
  ///
  /// Returns true if the App Store storefront is United States.
  ///
  /// Returns false on non-iOS platforms (e.g. Android) or when storefront is
  /// unavailable.
  static Future<bool> isUnitedStates() async {
    return (await getCountryCode()) == 'USA';
  }

  /// Overrides the list of storefront countries where external payments are
  /// supported.
  ///
  /// The plugin does not determine eligibility; it only provides the App Store
  /// storefront and a configurable helper for feature gating.
  ///
  /// Entries must be ISO-3166 alpha-3 (e.g. "USA", "DEU") and will be normalized
  /// to uppercase.
  static void setExternalPaymentSupportedCountries(Set<String> countries) {
    _externalPaymentSupportedCountries =
        countries.map((c) => c.toUpperCase()).toSet();
  }

  /// Returns true if external payments are configured as supported for
  /// [countryCode].
  ///
  /// [countryCode] must be ISO-3166 alpha-3.
  static bool isExternalPaymentSupported(String countryCode) {
    return _externalPaymentSupportedCountries.contains(countryCode.toUpperCase());
  }
}
