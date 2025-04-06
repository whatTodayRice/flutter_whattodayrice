part of 'my_post_bloc.dart';

sealed class MyPostState extends Equatable {
  const MyPostState();

  @override
  List<Object?> get props => [];
}

final class MyPostInitial extends MyPostState {
  const MyPostInitial();
}

final class MyPostLoading extends MyPostState {
  const MyPostLoading();
}

final class MyPostError extends MyPostState {
  const MyPostError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

final class MyPostLoaded extends MyPostState {
  const MyPostLoaded({this.nickname, required this.myPostList, this.lastDocId});

  final String? nickname;
  final List<Post> myPostList;
  final String? lastDocId;

  @override
  List<Object?> get props => [myPostList, lastDocId];
}
