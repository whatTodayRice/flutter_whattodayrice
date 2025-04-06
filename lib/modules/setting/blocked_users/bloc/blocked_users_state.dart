part of 'blocked_users_bloc.dart';

sealed class BlockedUsersState extends Equatable {
  const BlockedUsersState();

  @override
  List<Object?> get props => [];
}

final class BlockedUsersInitial extends BlockedUsersState {
  const BlockedUsersInitial();
}

final class BlockedUsersLoading extends BlockedUsersState {
  const BlockedUsersLoading();
}

final class BlockedUsersError extends BlockedUsersState {
  const BlockedUsersError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

final class BlockedUsersLoaded extends BlockedUsersState {
  const BlockedUsersLoaded();
}
