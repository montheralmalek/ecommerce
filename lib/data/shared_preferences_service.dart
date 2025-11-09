import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/exceptions/app_exceptions.dart';

import 'package:store/core/utils/result.dart';

abstract class SharedPreferencesService {
  Future<Result<String?>> fetchToken();
  Future<Result<void>> saveToken(String? token);
  Future<Result<void>> clear();
  Future<Result<String?>> fetchThemeMode();
  Future<Result<void>> saveThemeMode(String? themeMode);
  Future<Result<String?>> fetchLocale();
  Future<Result<void>> saveLocale(String? locale);
}

class SharedPreferencesServiceImp implements SharedPreferencesService {
  final SharedPreferences _sharedPreferences;
  SharedPreferencesServiceImp(this._sharedPreferences);

  /// Keys for SharedPreferences
  static const _tokenKey = 'TOKEN';
  static const _themeModeKey = 'THEME_MODE';
  static const _localeKey = 'LOCALE';

  final _log = Logger('SharedPreferencesService');

  @override
  Future<Result<String?>> fetchToken() async {
    try {
      _log.finer('Got token from SharedPreferences');
      return Result.success(_sharedPreferences.getString(_tokenKey));
    } on Exception catch (e) {
      _log.warning('Failed to get token', e);
      return Result.failure(e.toAppException().toError());
    }
  }

  @override
  Future<Result<void>> saveToken(String? token) async {
    try {
      if (token == null) {
        _log.finer('Removed token');
        await _sharedPreferences.remove(_tokenKey);
      } else {
        _log.finer('Replaced token');
        await _sharedPreferences.setString(_tokenKey, token);
      }
      return Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to set token', e);
      return Result.failure(e.toAppException().toError());
    }
  }

  @override
  Future<Result<void>> clear() async {
    try {
      _log.finer('Cleared all data');
      await _sharedPreferences.clear();
      return Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to clear data', e);
      return Result.failure(e.toAppException().toError());
    }
  }

  @override
  Future<Result<String?>> fetchThemeMode() async {
    try {
      _log.finer('Got theme mode from SharedPreferences');
      return Result.success(_sharedPreferences.getString(_themeModeKey));
    } on Exception catch (e) {
      _log.warning('Failed to get theme mode', e);
      return Result.failure(e.toAppException().toError());
    }
  }

  @override
  Future<Result<void>> saveThemeMode(String? themeMode) async {
    try {
      if (themeMode == null) {
        _log.finer('Removed theme mode');
        await _sharedPreferences.remove(_themeModeKey);
      } else {
        _log.finer('Replaced theme mode');
        await _sharedPreferences.setString(_themeModeKey, themeMode);
      }
      return Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to set theme mode', e);
      return Result.failure(e.toAppException().toError());
    }
  }

  @override
  Future<Result<String?>> fetchLocale() async {
    try {
      _log.finer('Got locale from SharedPreferences');
      return Result.success(_sharedPreferences.getString(_localeKey));
    } on Exception catch (e) {
      _log.warning('Failed to get locale', e);
      return Result.failure(e.toAppException().toError());
    }
  }

  @override
  Future<Result<void>> saveLocale(String? locale) async {
    try {
      if (locale == null) {
        _log.finer('Removed locale');
        await _sharedPreferences.remove(_localeKey);
      } else {
        _log.finer('Replaced locale');
        await _sharedPreferences.setString(_localeKey, locale);
      }
      return Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to set locale', e);
      return Result.failure(e.toAppException().toError());
    }
  }
}
