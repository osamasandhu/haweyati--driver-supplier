import 'package:intl/intl.dart';
import 'output/messages_all.dart';
import 'package:flutter/cupertino.dart';

class HaweyatiLocalization {
  static const delegate = const _HaweyatiLocalizationDelegate();
  static HaweyatiLocalization of(BuildContext context) => Localizations.of(context, HaweyatiLocalization);

  String get signInAsDriver => Intl.message('Sign In as Driver', name: 'signInAsDriver');
  String get signInAsSupplier => Intl.message('Sign In as Supplier', name: 'signInAsSupplier');
}

class _HaweyatiLocalizationDelegate extends LocalizationsDelegate<HaweyatiLocalization> {
  const _HaweyatiLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<HaweyatiLocalization> load(Locale locale) async {
    await initializeMessages(locale.languageCode);

    Intl.defaultLocale = Intl.canonicalizedLocale(
      locale.countryCode?.isEmpty ?? false ? locale.countryCode : locale.toString()
    );
    return HaweyatiLocalization();
  }

  @override
  bool shouldReload(LocalizationsDelegate<HaweyatiLocalization> old) => false;
}
