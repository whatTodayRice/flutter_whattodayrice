import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final PostRepository postRepository;

  SettingBloc({
    required this.authRepository,
    required this.userRepository,
    required this.postRepository,
  }) : super(const SettingInitial()) {
    on<SettingLoadRequested>(_onSettingLoadRequested);
    on<SettingMyPostLoadRequested>(_onSettingMyPostLoadRequested);
    on<SettingLoginRequested>(_onSettingLoginRequested);
    on<SettingLogOutRequested>(_onSettingLogOutRequested);
  }

  Profile? profile;

  List<Post> myPostList = [];
  String? lastDocId;

  FutureOr<void> _onSettingLoadRequested(
    SettingLoadRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoading());

    profile = userRepository.getUserProfileFromCache();

    emit(SettingLoaded(profile: profile));
  }

  FutureOr<void> _onSettingMyPostLoadRequested(
    SettingMyPostLoadRequested event,
    Emitter<SettingState> emit,
  ) async {
    if (profile == null) {
      return;
    }

    emit(const SettingLoading());

    final response = await postRepository.getMyPostList(userId: profile!.id);

    if (response.isSucceed != true) {
      emit(SettingError(errorMessage: response.errorMessage));

      return;
    }

    myPostList = [...myPostList, ...response.succeedData ?? []];
    lastDocId = (response.succeedData ?? []).length >= 20 ? response.succeedData!.last.id : null;

    emit(SettingMyPostLoaded(myPostList: [...myPostList], lastDocId: lastDocId));
  }

  FutureOr<void> _onSettingLoginRequested(
    SettingLoginRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoading());

    final response = await authRepository.signInWithKakaoTalk();

    if (response.isSucceed != true) {
      emit(SettingError(errorMessage: response.errorMessage));

      return;
    }

    await userRepository.getUserProfile();

    emit(const SettingLoginSucceed());
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
