import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

enum SettingItemEnum {
  myPosts('myPosts', '내 게시글'),
  blockedUsers('blockedUsers', '차단한 계정'),
  siteTerms('siteTerms', '이용 약관');

  final String routeName;
  final String displayValue;

  const SettingItemEnum(this.routeName, this.displayValue);
}

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SettingBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(const SettingInitial()) {
    on<SettingLoadRequested>(_onSettingLoadRequested);
    on<SettingLogOutRequested>(_onSettingLogOutRequested);
  }

  FutureOr<void> _onSettingLoadRequested(
    SettingLoadRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoading());

    emit(const SettingLoaded(items: [...SettingItemEnum.values]));
  }

  Future<void> _onSettingLogOutRequested(
    SettingLogOutRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoading());

    userRepository.clearUserProfile();

    final response = await authRepository.signOut();

    if (!response.isSucceed) {
      return;
    }

    emit(const SettingLogoutSucceed());
  }
}
