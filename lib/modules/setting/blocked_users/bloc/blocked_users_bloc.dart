import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'blocked_users_event.dart';
part 'blocked_users_state.dart';

class BlockedUsersBloc extends Bloc<BlockedUsersEvent, BlockedUsersState> {
  BlockedUsersBloc() : super(const BlockedUsersInitial()) {
    on<BlockedUsersLoadRequested>(_onBlockedUsersLoadRequested);
  }

  FutureOr<void> _onBlockedUsersLoadRequested(
    BlockedUsersLoadRequested event,
    Emitter<BlockedUsersState> emit,
  ) async {}
}
