part of 'setting_bloc.dart';

sealed class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

final class SettingInitial extends SettingState {
  const SettingInitial();
}

final class SettingLoading extends SettingState {
  const SettingLoading();
}

final class SettingError extends SettingState {
  const SettingError({this.errorMessage});

  final String? errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

final class SettingLoaded extends SettingState {
  const SettingLoaded({required this.items});

  final List<SettingItemEnum> items;

  @override
  List<Object?> get props => [items];
}

final class SettingLogoutSucceed extends SettingState {
  const SettingLogoutSucceed();
}
