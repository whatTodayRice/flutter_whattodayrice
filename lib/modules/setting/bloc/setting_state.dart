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
  const SettingLoaded({this.profile});

  final Profile? profile;

  @override
  List<Object?> get props => [profile];
}

final class SettingMyPostLoaded extends SettingState {
  const SettingMyPostLoaded({required this.myPostList, this.lastDocId});

  final List<Post> myPostList;
  final String? lastDocId;

  @override
  List<Object?> get props => [myPostList, lastDocId];
}

final class SettingLoginSucceed extends SettingState {
  const SettingLoginSucceed();
}

final class SettingLogoutSucceed extends SettingState {
  const SettingLogoutSucceed();
}
