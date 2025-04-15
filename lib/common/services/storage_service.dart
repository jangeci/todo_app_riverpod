import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/common/utils/constants.dart';
import 'package:todo_app/models/user.dart';

class StorageService {
  late final SharedPreferences _pref;

  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  String getString(String key) {
    return _pref.getString(key) ?? '';
  }

  String getUserToken() {
    return _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? '';
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool isLoggedIn() {
    return _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY) != null && _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY)!.isNotEmpty;
  }

  UserProfileModel? getUserProfile() {
    var json = _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? '';

    if (json.isNotEmpty) {
      var profileJson = jsonDecode(json);
      return UserProfileModel.fromJson(profileJson);
    } else {
      return null;
    }
  }

  Future<bool> remove(String key) async {
    await _pref.remove(key);
    return true;
  }
}
