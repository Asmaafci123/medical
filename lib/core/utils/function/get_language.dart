import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/datasources/local_data_source/local_data_source.dart';
import '../../constants/constants.dart';

getLanguageCode() async {
  final prefs = await SharedPreferences.getInstance();
  final int? languageCode=prefs.getInt(APP_LANGUAGE);
  languageId = languageCode??1;
}
