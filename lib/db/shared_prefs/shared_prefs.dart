import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigaet/resources/constants/app_constants.dart';

class SharedPrefs {
  Future<SharedPreferences> getDbInstance() async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> getUserRole() async {
    final prefs = await getDbInstance();
    return prefs.getString(AppConstants.userRole);
  }

  Future setUserRole(String userRole) async {
    final prefs = await getDbInstance();
    return prefs.setString(AppConstants.userRole, userRole);
  }

  Future removeUser() async {
    final prefs = await getDbInstance();
    prefs.clear();
  }
}
