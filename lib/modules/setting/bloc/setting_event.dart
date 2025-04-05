part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

final class SettingLoadRequested extends SettingEvent {
  const SettingLoadRequested();
}

final class SettingMyPostLoadRequested extends SettingEvent {
  const SettingMyPostLoadRequested();
}

final class SettingLoginRequested extends SettingEvent {
  const SettingLoginRequested();
}

final class SettingLogOutRequested extends SettingEvent {
  const SettingLogOutRequested();
}
