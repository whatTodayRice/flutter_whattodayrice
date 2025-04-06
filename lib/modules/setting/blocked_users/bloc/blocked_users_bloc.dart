import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'blocked_users_event.dart';
part 'blocked_users_state.dart';

class BlockedUsersBloc extends Bloc<BlockedUsersEvent, BlockedUsersState> {
  final UserRepository userRepository;

  BlockedUsersBloc({required this.userRepository}) : super(const BlockedUsersInitial()) {
    on<BlockedUsersLoadRequested>(_onBlockedUsersLoadRequested);
    on<BlockedUsersDeleteRequested>(_onBlockedUsersDeleteRequested);
  }

  Profile? profile;

  FutureOr<void> _onBlockedUsersLoadRequested(
    BlockedUsersLoadRequested event,
    Emitter<BlockedUsersState> emit,
  ) async {
    emit(const BlockedUsersLoading());

    profile = userRepository.getUserProfileFromCache();

    emit(BlockedUsersLoaded(blockedUsers: [...profile?.blockedUsers ?? []]));
  }

  FutureOr<void> _onBlockedUsersDeleteRequested(
    BlockedUsersDeleteRequested event,
    Emitter<BlockedUsersState> emit,
  ) async {
    emit(const BlockedUsersLoading());

    final response = await userRepository.deleteBlockedUser(
      userId: profile!.id,
      blockedUserId: profile!.blockedUsers[event.index].id,
    );

    if (response.isSucceed != true) {
      emit(BlockedUsersError(message: response.errorMessage));

      return;
    }

    emit(BlockedUsersDeleteSucceed(message: '${profile!.blockedUsers[event.index].nickname ?? "-"}님을 차단 해제했어요.'));
  }
}
