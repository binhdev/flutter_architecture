import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/core/l10n/messages_all.dart';
import 'package:flutter_architecture_sample/core/l10n/strings_impl.dart';
import 'package:intl/intl.dart';

/// アプリケーションの多言語をサポートするクラス
/// アプリでの文言はこれ経由で取得する
class Strings with StringsImpl {
  /// 言語リソースを扱う
  /// localeは端末設定・アプリの指定を踏まえて最適なものが渡ってくる
  static Future<Strings> load(Locale locale) {
    String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();

    final localeName = Intl.canonicalizedLocale(name);

    // 言語リソース読み込み
    return initializeMessages(localeName).then((_) {
      // デフォルト言語を設定
      Intl.defaultLocale = localeName;
      // 自身を返す
      return Strings();
    });
  }

  // Widgetツリーから自身を取り出す
  static Strings? of(BuildContext context) =>
      Localizations.of<Strings>(context, Strings);

  /// 端末のロケールを取得
  static Locale locale(BuildContext context) => Localizations.localeOf(context);
}
