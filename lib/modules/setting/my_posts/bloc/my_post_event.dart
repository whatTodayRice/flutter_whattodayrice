part of 'my_post_bloc.dart';

sealed class MyPostEvent extends Equatable {
  const MyPostEvent();

  @override
  List<Object?> get props => [];
}

final class MyPostLoadRequested extends MyPostEvent {
  const MyPostLoadRequested();
}
