
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  cacheAppLanguage(int localeCode);
  int? getAppLanguage();

  Future<void>cashSearchedListOurPartners(List<String> searchedPartners);
  Future<List<String>?> getCashedSearchedListOurPartners();
  clearCashedSearchedListOurPartners();
}

const APP_LANGUAGE='APP_LANGUAGE';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  cacheAppLanguage(int localeCode) {
    return sharedPreferences.setInt(APP_LANGUAGE, localeCode);
  }

  @override
  int? getAppLanguage() {
    return sharedPreferences.getInt(APP_LANGUAGE);
  }

  @override
  Future<void>cashSearchedListOurPartners(List<String>? searchedPartners)async
  {
    await sharedPreferences.setStringList('searchedPartners', searchedPartners??[]);
  }


  @override
  Future<List<String>?> getCashedSearchedListOurPartners()async {

    return sharedPreferences.getStringList('searchedPartners');
  }

  @override
  clearCashedSearchedListOurPartners()
  {
    return sharedPreferences.remove('searchedPartners');
  }
}