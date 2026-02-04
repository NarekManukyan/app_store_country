# app_store_country

A Flutter plugin that returns the Apple App Store **storefront** country code (ISO-3166 alpha-3) on iOS using StoreKit. Use it to gate external payment options (e.g. Stripe) by storefront while staying within App Store rules.

- **iOS**: Returns the storefront country (e.g. `"USA"`, `"DEU"`) via StoreKit. Returns `null` if the storefront is unavailable.
- **Android**: Returns `null` from [getCountryCode](#getcountrycode) and `false` from [isUnitedStates](#isunitedstates). The plugin does **not** throw on Android so you can call it safely and treat `null` as "no App Store storefront" (e.g. use your own payment or in-app purchase logic).

This plugin detects **App Store storefront** (tied to the Apple ID), not device location. It does not implement payment flows or bypass Apple payment rules.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  app_store_country: ^0.0.1
```

Then run `flutter pub get`.

## Usage

### Get storefront country

```dart
import 'package:app_store_country/app_store_country.dart';

final country = await AppStoreCountry.getCountryCode();
// iOS: e.g. "USA", "DEU", or null
// Android: null
```

### Gate external payments by storefront

```dart
final country = await AppStoreCountry.getCountryCode();

if (country == 'USA') {
  // Enable Stripe / external payment UI where allowed
} else {
  // Use Apple In-App Purchase or other logic
}
```

On Android, `country` is `null`, so the `else` branch runs unless you add an explicit Android path.

### Convenience and configurable helper

```dart
final isUS = await AppStoreCountry.isUnitedStates();
// true only on iOS when storefront is United States; false on Android or when unavailable

// Configurable list of storefronts where external payment is treated as supported (default: {"USA"})
AppStoreCountry.setExternalPaymentSupportedCountries({'USA', 'GBR'});
final canUseExternal = country != null && AppStoreCountry.isExternalPaymentSupported(country);
```

## API

| Method | Description |
|--------|-------------|
| [getCountryCode](#getcountrycode) | Returns storefront country (ISO-3166 alpha-3) or `null`. On Android returns `null`. |
| [isUnitedStates](#isunitedstates) | Returns `true` only when storefront is US on iOS; `false` on Android or when unavailable. |
| [setExternalPaymentSupportedCountries](#setexternalpaymentsupportedcountries) | Sets the list of alpha-3 country codes treated as supporting external payments (default: `{"USA"}`). |
| [isExternalPaymentSupported](#isexternalpaymentsupported) | Returns `true` if the given alpha-3 country is in the configured supported set. |

### getCountryCode

Returns the App Store storefront country code (e.g. `"USA"`, `"GBR"`). Returns `null` if the storefront is unavailable or on non-iOS platforms (e.g. Android). Does not throw on Android.

### isUnitedStates

Returns `true` when the storefront is United States on iOS; otherwise `false` (including on Android).

### setExternalPaymentSupportedCountries

Override the set of storefront countries where external payments are treated as supported. Entries must be ISO-3166 alpha-3; they are normalized to uppercase. Default is `{"USA"}`.

### isExternalPaymentSupported

Returns `true` if the given alpha-3 [countryCode] is in the set configured by [setExternalPaymentSupportedCountries].

## Platform behavior

| Platform | getCountryCode | isUnitedStates |
|----------|----------------|----------------|
| iOS      | Storefront code or `null` | `true` only when storefront is US |
| Android  | `null`         | `false` |

No native Android implementation is included; the Dart API is safe to call from Android and returns null/false.

## Compliance notes

- Apple evaluates payment eligibility using App Store storefront. Storefront is tied to the Apple ID, not the device.
- This plugin is suitable for feature gating, UI decisions, and compliance checks. External payments are subject to App Store Review Guidelines.
- The plugin does not bypass Apple payment rules; it only exposes the storefront country so you can branch your logic.

## License

MIT. See [LICENSE](LICENSE).
