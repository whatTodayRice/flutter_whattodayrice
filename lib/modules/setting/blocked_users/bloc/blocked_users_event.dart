part of 'blocked_users_bloc.dart';

sealed class BlockedUsersEvent extends Equatable {
  const BlockedUsersEvent();

  @override
  List<Object?> get props => [];
}

final class BlockedUsersLoadRequested extends BlockedUsersEvent {
  const BlockedUsersLoadRequested();
}
