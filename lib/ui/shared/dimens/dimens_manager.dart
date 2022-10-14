import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_sample/ui/shared/dimens/dimens_login_view.dart';
import 'package:flutter_architecture_sample/ui/views/login_view.dart';

class DimensManager {
  late DimensLoginView _dimensLoginView;

  DimensLoginView get loginViewSize => _dimensLoginView;

  static DimensManager? _instance;

  factory DimensManager() {
    return _instance ??= DimensManager._();
  }

  /// Constructor
  DimensManager._() {
    _calculatorLanguage();
    _initializeDimens();
  }

  void destroyInstance() {
    _instance = null;
  }

  //TODO:
  void _calculatorLanguage() {
    //TODO: Locale myLocale = Localizations.localeOf(context);
  }

  void _initializeDimens() {
    /// [BEGIN] Screen Size
    // LoginView
    _dimensLoginView = DimensLoginView();

    /// [END] Screen Size
    /// [BEGIN] Widget Size

    /// [END] Widget Size
    /// TODO: Add more
  }

  void calculatorRatio<T>(BuildContext context) {
    switch (T) {
      case LoginView:
        _dimensLoginView.calculatorRatio<T>(context);
        break;
      default:
        // TODO: Handle later
        break;

      ///Add
    }
  }
}
