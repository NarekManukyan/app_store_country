# App Store Country Example

[![Pub Version](https://img.shields.io/pub/v/app_store_country)](https://pub.dev/packages/app_store_country)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](../LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)](https://flutter.dev)

Example app for the [app_store_country](https://github.com/NarekManukyan/app_store_country) plugin. It demonstrates reading the App Store storefront country code (ISO-3166 alpha-3) on iOS and using it for feature gating (e.g. external payment eligibility).

<p align="center">
  <a href="https://github.com/NarekManukyan/app_store_country">GitHub</a> -
  <a href="https://github.com/NarekManukyan/app_store_country/blob/main/README.md">Package README</a> -
  <a href="https://github.com/NarekManukyan/app_store_country/issues">Issue tracker</a>
</p>

## What This Example Supports

### Features

- **Storefront country**: Displays the current App Store storefront country code (e.g. `USA`, `DEU`) via `AppStoreCountry.getCountryCode()`
- **Graceful failure**: Handles `PlatformException` and null (shows a fallback message)
- **Async-safe**: Uses `mounted` check before `setState` after the platform call

### Platform support

- **iOS**: Full support (StoreKit storefront). Run the example on an iOS simulator or device to see the storefront country.
- **Android**: Not supported natively. `getCountryCode()` returns `null` and `isUnitedStates()` returns `false`; the plugin does not throw, so the example can run on Android and will show a fallback.

## How It Works

The example app calls the plugin when the screen loads, then shows the result:

1. On `initState`, it calls `AppStoreCountry.getCountryCode()`.
2. The plugin uses StoreKit on iOS to read the Apple ID storefront (ISO-3166 alpha-3).
3. The UI displays the country code or a fallback if the call fails or returns null.

For architecture and full API (e.g. `isUnitedStates()`, `isExternalPaymentSupported()`, `setExternalPaymentSupportedCountries()`), see the [package README](../README.md).

## Installation

From the plugin root (parent of `example/`), the example depends on the local package. From this directory:

```bash
cd example
flutter pub get
```

## How to run

From this directory (`example/`):

```bash
flutter pub get
flutter run
```

To run on iOS only:

```bash
flutter run -d ios
```

## Usage

### What the example does

The app shows the current App Store storefront country code by calling `AppStoreCountry.getCountryCode()` and displaying it in the UI. On failure or null, it shows a fallback message.

### Basic usage (get country code)

```dart
import 'package:app_store_country/app_store_country.dart';

final country = await AppStoreCountry.getCountryCode();
// e.g. "USA", "DEU", or null if unavailable
```

### Gating external payments by storefront

Typical pattern for allowing external payments (e.g. Stripe) only where the App Store permits:

```dart
final country = await AppStoreCountry.getCountryCode();

if (country == 'USA') {
  // Enable Stripe / external payment UI
} else {
  // Use Apple In-App Purchase
}
```

### Using the configurable helper

Default supported list includes `USA`. You can override it with `setExternalPaymentSupportedCountries()`:

```dart
final country = await AppStoreCountry.getCountryCode();
if (country != null && AppStoreCountry.isExternalPaymentSupported(country)) {
  // Show external payment option
} else {
  // Use in-app purchase
}
```

### API summary

| API | Description |
|-----|-------------|
| `AppStoreCountry.getCountryCode()` | Returns storefront country code (ISO-3166 alpha-3) or `null`. On Android returns `null` (no throw). |
| `AppStoreCountry.isUnitedStates()` | Returns `true` if storefront is United States. On Android returns `false` (no throw). |
| `AppStoreCountry.setExternalPaymentSupportedCountries(Set<String>)` | Sets the list of storefront countries where external payments are treated as supported (default: `{"USA"}`). Alpha-3 only. |
| `AppStoreCountry.isExternalPaymentSupported(String countryCode)` | Returns `true` if the given alpha-3 country code is in the configured supported set. |

## More information

- [Package README](../README.md) — Full API, compliance notes, and App Store storefront behavior
- [GitHub repository](https://github.com/NarekManukyan/app_store_country)
- [Issue tracker](https://github.com/NarekManukyan/app_store_country/issues)

## License

This project is licensed under the MIT License — see [../LICENSE](../LICENSE).
