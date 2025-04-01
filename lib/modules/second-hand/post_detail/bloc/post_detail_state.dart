part of 'post_detail_bloc.dart';

sealed class PostDetailState extends Equatable {
  const PostDetailState();

  @override
  List<Object?> get props => [];
}

final class PostDetailInitial extends PostDetailState {
  const PostDetailInitial();
}

final class PostDetailLoading extends PostDetailState {
  const PostDetailLoading();
}

final class PostDetailError extends PostDetailState {
  const PostDetailError({this.errorMessage});

  final String? errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

final class PostDetailLoaded extends PostDetailState {
  const PostDetailLoaded({required this.post});

  final Post post;

  @override
  List<Object?> get props => [post];
}

final class PostDetailCommentValidationChecked extends PostDetailState {
  const PostDetailCommentValidationChecked({required this.isValid});

  final bool isValid;

  @override
  List<Object?> get props => [isValid];
}

final class PostDetailDeleteSucceed extends PostDetailState {
  const PostDetailDeleteSucceed();
}

final class PostDetailUserBlockedSucceed extends PostDetailState {
  const PostDetailUserBlockedSucceed({this.isPost, this.message});

  final bool? isPost;
  final String? message;

  @override
  List<Object?> get props => [isPost];
}
