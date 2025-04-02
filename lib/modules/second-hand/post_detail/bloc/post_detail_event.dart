part of 'post_detail_bloc.dart';

sealed class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object?> get props => [];
}

final class PostDetailLoadRequested extends PostDetailEvent {
  const PostDetailLoadRequested({required this.postId});

  final String postId;

  @override
  List<Object?> get props => [postId];
}

final class PostDetailSellStatusChangeRequested extends PostDetailEvent {
  const PostDetailSellStatusChangeRequested({required this.statusIndex});

  final int statusIndex;

  @override
  List<Object?> get props => [statusIndex];
}

final class PostDetailDeleteRequested extends PostDetailEvent {
  const PostDetailDeleteRequested({this.commentId});

  final String? commentId;

  @override
  List<Object?> get props => [commentId];
}

final class PostDetailWriterBlockRequested extends PostDetailEvent {
  const PostDetailWriterBlockRequested({required this.commentIndex});

  final int? commentIndex;

  @override
  List<Object?> get props => [commentIndex];
}

final class PostDetailCommentContentChangeRequested extends PostDetailEvent {
  const PostDetailCommentContentChangeRequested({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

final class PostDetailCreateCommentRequested extends PostDetailEvent {
  const PostDetailCreateCommentRequested();
}
