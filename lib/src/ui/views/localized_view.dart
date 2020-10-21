import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';

typedef LocalizedViewBuilder = Widget Function(BuildContext context, AppLocalizations lang);

class LocalizedView extends StatelessWidget {
  LocalizedView({this.builder});
  final LocalizedViewBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context, AppLocalizations.of(context));
}
