import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'app_localisation/app_localisation.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': AppLocalisation.appLocale,
    // 'hi_IN': {'hello': 'नमस्ते'},
  };
}