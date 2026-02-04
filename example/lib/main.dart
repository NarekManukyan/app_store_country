import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:app_store_country/app_store_country.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _countryCode = 'Unknown';

  @override
  void initState() {
    super.initState();
    initCountryCodeState();
  }

  // Country code is asynchronous, so we initialize in an async method.
  Future<void> initCountryCodeState() async {
    String countryCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      countryCode =
          await AppStoreCountry.getCountryCode() ?? 'Unknown platform version';
    } on PlatformException {
      countryCode = 'Failed to get country code.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _countryCode = countryCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Country code: $_countryCode\n'),
        ),
      ),
    );
  }
}
