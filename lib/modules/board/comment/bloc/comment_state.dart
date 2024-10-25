part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState({
    this.comments = const [],
    this.isContentEmpty,
    this.errorMessage = "",
    this.parentCommentIndex,
  });

  final List<Comment> comments;
  final bool? isContentEmpty;
  final String? errorMessage;
  final int? parentCommentIndex;

  @override
  List<Object?> get props => [comments, isContentEmpty, errorMessage, parentCommentIndex];
}

class CommentInitial extends CommentState {
  const CommentInitial();
}

class CommentLoading extends CommentState {
  const CommentLoading();
}

class CommentListLoaded extends CommentState {
  const CommentListLoaded({
    super.comments,
    super.isContentEmpty,
    super.parentCommentIndex,
  });
}

class CommentError extends CommentState {
  const CommentError({super.errorMessage});
}
