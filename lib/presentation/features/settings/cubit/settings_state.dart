part of 'settings_cubit.dart';

class SettingState {
  final ThemeMode themeMode;
  final Locale locale;
  final bool notificationsEnabled;

  const SettingState({
    required this.themeMode,
    required this.locale,
    required this.notificationsEnabled,
  });

  factory SettingState.initial() {
    return const SettingState(
      themeMode: ThemeMode.system,
      locale: Locale('en', 'US'),
      notificationsEnabled: true,
    );
  }

  SettingState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? notificationsEnabled,
  }) {
    return SettingState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingState &&
        other.themeMode == themeMode &&
        other.locale == locale &&
        other.notificationsEnabled == notificationsEnabled;
  }

  @override
  int get hashCode {
    return themeMode.hashCode ^ locale.hashCode ^ notificationsEnabled.hashCode;
  }

  @override
  String toString() {
    return 'SettingState(themeMode: $themeMode, locale: $locale, notificationsEnabled: $notificationsEnabled)';
  }
}
