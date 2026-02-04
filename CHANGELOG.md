## 0.0.1

* Initial release.
* **iOS only**: Returns the App Store storefront country code (ISO-3166 alpha-3) via StoreKit.
* `AppStoreCountry.getCountryCode()` — returns storefront country (e.g. `"USA"`, `"DEU"`) or `null` if unavailable.
* `AppStoreCountry.isUnitedStates()` — convenience helper for US storefront.
* `AppStoreCountry.setExternalPaymentSupportedCountries(Set<String>)` — configure which storefront countries are treated as supporting external payments (default: `{"USA"}`).
* `AppStoreCountry.isExternalPaymentSupported(String countryCode)` — returns whether the given alpha-3 country code is in the configured supported set.
* On non-iOS platforms (e.g. Android), `getCountryCode()` returns `null` and `isUnitedStates()` returns `false`; the plugin does not throw so callers can branch safely.
* Minimum iOS: 13.0. Uses StoreKit 2 (`Storefront.current`) on iOS 15+ and `SKPaymentQueue.default().storefront` on iOS 13–14.
