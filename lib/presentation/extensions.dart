
import 'package:flutter/cupertino.dart';

import '../src/generated/i18n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
