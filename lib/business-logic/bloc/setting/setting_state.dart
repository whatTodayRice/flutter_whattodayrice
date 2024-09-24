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
  const SettingError();
}

final class SettingLoaded extends SettingState {
  const SettingLoaded({this.isLogOut});

  final bool? isLogOut;

  @override
  List<Object?> get props => [isLogOut];
}
