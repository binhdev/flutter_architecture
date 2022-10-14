import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/core/l10n/strings.dart';
import 'package:flutter_architecture_sample/view_models/application_view_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/navigator/top_screen/top_screen_navigator_routes.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  final ApplicationViewModel _applicationViewModel = ApplicationViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback(_onBuildCompleted);
  }

  void _onBuildCompleted(Duration timestamp) {}

  @override
  Widget build(BuildContext context) {
    return _buildApplication();
  }

  Widget _buildApplication() {
    return MaterialApp(
      onGenerateTitle: (context) => "App Test",
      theme: ThemeData(),
      localizationsDelegates: const [
        _MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja', 'JP'),
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (deviceLocale != null) {
            if (supportedLocale.languageCode == deviceLocale.languageCode) {
              if (supportedLocale.countryCode == deviceLocale.countryCode ||
                  supportedLocale.scriptCode == deviceLocale.scriptCode) {
                return Locale(
                    supportedLocale.languageCode, supportedLocale.countryCode);
              }
            }
          }
        }
        // If the locale of the device is not supported set default English
        return const Locale('en');
      },
      initialRoute: TopScreenNavigatorRoutes().initialRoute(),
      onGenerateRoute: TopScreenNavigatorRoutes().routeBuilders,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _applicationViewModel.destroySingletonObject();
  }
}

class _MyLocalizationsDelegate extends LocalizationsDelegate<Strings> {
  const _MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Strings> old) => false;
}
