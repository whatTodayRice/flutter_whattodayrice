part of 'comment_bloc.dart';

class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

class CommentListLoadRequested extends CommentEvent {
  const CommentListLoadRequested();
}

final class CommentDeleteRequested extends CommentEvent {
  const CommentDeleteRequested({required this.commentIndex});

  final int commentIndex;

  @override
  List<Object?> get props => [commentIndex];
}

final class CommentCreateRequested extends CommentEvent {
  const CommentCreateRequested();
}

final class CommentContentChanged extends CommentEvent {
  const CommentContentChanged({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}
