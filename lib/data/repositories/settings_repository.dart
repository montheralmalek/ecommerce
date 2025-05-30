import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:store/core/utils/result.dart';
import 'package:store/data/shared_preferences_service.dart';

abstract class SettingsRepository {
  Future<ThemeMode?> get getTheme;
  Future<Result<void>> saveTheme(ThemeMode? theme);

  Future<Locale?> get getLocale;
  Future<Result<void>> saveLocale(Locale? locale);

  Future<Result<void>> resetToDefault();
}

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferencesService _preferencesService;

  SettingsRepositoryImpl(this._preferencesService);

  ThemeMode? _themeMode;
  Locale? _locale;
  final _log = Logger('SettingsRepositoryImpl');

  /// Initializes the repository by fetching the settings.
  Future<SettingsRepository> init() async {
    _log.fine('Initializing SettingsRepository');
    await _fetchAll();
    return this;
  }

  /// Fetches the theme mode and locale from shared preferences.
  Future<void> _fetchAll() async {
    _log.fine('Fetching settings');
    await _fetchThemeMode();
    _log.fine('Theme mode fetched: $_themeMode');
    await _fetchLocale();
    _log.fine('Locale fetched: $_locale');
    _log.fine('Settings fetched successfully');
  }

  /// fetches the theme mode from shared preferences service.
  Future<void> _fetchThemeMode() async {
    _log.fine('Fetching theme mode from SharedPreferencesService');
    final result = await _preferencesService.fetchThemeMode();
    result.where(
      onSuccess: (value) {
        _log.fine('Theme mode fetched successfully: $value');
        _themeMode = value != null ? ThemeMode.values.byName(value) : null;
      },
      onFailure: (error) {
        _log.warning('Failed to fetch theme mode', error);
        return null;
      },
    );
  }

  /// fetches the locale from shared preferences service.
  Future<void> _fetchLocale() async {
    // _log.fine('Fetching locale from SharedPreferencesService');
    // final result = await _preferencesService.fetchLocale();
    // result.where(
    //   onSuccess: (value) {
    //     _log.fine('Locale fetched successfully: $value');
    //     _locale = value;
    //   },
    //   onFailure: (error) {
    //     _log.warning('Failed to fetch locale', error);
    //     return null;
    //   },
    // );

    // final countryCode = _preferencesService.getString('countryCode');
    // _locale = Locale(languageCode, countryCode);
    // _log.fine('Locale fetched successfully: $_locale');
  }

  @override
  Future<ThemeMode?> get getTheme async {
    // await _fetchThemeMode();
    if (_themeMode == null) {
      await _fetchThemeMode();
    }
    return _themeMode;
  }

  @override
  Future<Result<void>> saveTheme(ThemeMode? theme) async {
    _log.fine('Saving theme mode: $theme');
    final result = await _preferencesService.saveThemeMode(theme?.name);
    return result.where(
      onSuccess: (value) {
        _log.fine('Theme mode saved successfully: $theme');
        _themeMode = theme;
        return Result.success(value);
      },
      onFailure: (error) {
        _log.warning('Failed to save theme mode', error);
        return Result.failure(error);
      },
    );
  }

  @override
  Future<Locale?> get getLocale async {
    // await _fetchLocale();
    return _locale;
  }

  @override
  Future<Result<void>> saveLocale(Locale? locale) async {
    return _preferencesService.saveLocale(locale?.languageCode);
  }

  @override
  Future<Result<void>> resetToDefault() async {
    _log.fine('Resetting settings to default');
    // Reset theme mode to system default
    final themeResult = await _preferencesService.saveThemeMode(null);
    final localeResult = await _preferencesService.saveLocale(null);
    if (themeResult.isFailure) {
      _log.warning('Failed to reset theme mode', themeResult.failureValue);
      return themeResult;
    }
    if (localeResult.isFailure) {
      _log.warning('Failed to reset locale', localeResult.failureValue);
      return localeResult;
    }
    _log.fine('Settings reset to default successfully');
    // Clear local variables
    _themeMode = null;
    _locale = null;
    return Result.success(null);
  }
}
