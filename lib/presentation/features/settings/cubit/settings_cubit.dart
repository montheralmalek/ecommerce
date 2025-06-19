import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/data/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingsRepository _settingsRepository;
  SettingCubit(this._settingsRepository) : super(SettingState.initial()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final themeMode = await _settingsRepository.getTheme;
    final local = await _settingsRepository.getLocale;

    emit(state.copyWith(themeMode: themeMode, locale: local));
  }

  Future<void> setThemeMode(ThemeMode? themeMode) async {
    await _settingsRepository.saveTheme(themeMode);
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> setLocale(Locale locale) async {
    await _settingsRepository.saveLocale(locale);
    emit(state.copyWith(locale: locale));
  }

  Future<void> resetToDefault() async {
    await _settingsRepository.resetToDefault();
    emit(SettingState.initial());
  }

  Future<void> toggleNotifications(bool enabled) async {
    // Assuming notificationsEnabled is a boolean in the state
    emit(state.copyWith(notificationsEnabled: enabled));
    // Here you would also save the notification preference if needed
  }

  ThemeMode get themeMode => state.themeMode;
  Locale get locale => state.locale;
  bool get notificationsEnabled => state.notificationsEnabled;
}
