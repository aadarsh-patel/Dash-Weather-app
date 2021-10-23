import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kNotificationsPrefs = "allowNotifications";
  static final String _kSortingOrderPrefs = "sortOrder";
  static final String _kPhoneNo = "phoneNo";

  static Future<String?> getMobileNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(_kPhoneNo) ?? null;
    return result;
  }

  static Future<bool> setMobileNo(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString(_kPhoneNo, value);
    return result;
  }

  static Future<void> clearMobileNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kPhoneNo);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user decision to allow notifications
  /// ------------------------------------------------------------
  static Future<bool> getAllowsNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kNotificationsPrefs) ?? false;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision to allow notifications
  /// ----------------------------------------------------------
  static Future<bool> setAllowsNotifications(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kNotificationsPrefs, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user decision on sorting order
  /// ------------------------------------------------------------
  static Future<String> getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kSortingOrderPrefs) ?? 'name';
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision on sorting order
  /// ----------------------------------------------------------
  static Future<bool> setSortingOrder(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kSortingOrderPrefs, value);
  }
}
